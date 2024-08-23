import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_jonggack/common/responsive.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:diary_jonggack/common/check_validate.dart';
import 'package:diary_jonggack/components/today_widget.dart';
import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:diary_jonggack/models/diary_models.dart';
import 'package:get/get.dart';

class AddDiaryScreen extends StatefulWidget {
  AddDiaryScreen({super.key, this.diaryModel});
  DiaryModel? diaryModel;

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  late TextEditingController titleEditingController;
  late TextEditingController contentEditingController;
  late TextEditingController content2EditingController;
  late FocusNode _titleFocus;
  late FocusNode _contentFocus;
  late FocusNode _content2Focus;

  List<Uint8List>? imageBytesList;
  String? selectedMode;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DiaryController diaryController = Get.find<DiaryController>();
  @override
  void initState() {
    super.initState();
    print('widget.diaryModel : ${widget.diaryModel}');

    if (widget.diaryModel == null) {
      titleEditingController = TextEditingController();
      contentEditingController = TextEditingController();
      content2EditingController = TextEditingController();
    } else {
      titleEditingController =
          TextEditingController(text: widget.diaryModel!.title);
      contentEditingController =
          TextEditingController(text: widget.diaryModel!.content);
      content2EditingController =
          TextEditingController(text: widget.diaryModel!.content2);

      imageBytesList = widget.diaryModel!.imageUrls;
      selectedMode = widget.diaryModel!.mode;
    }

    _titleFocus = FocusNode();
    _contentFocus = FocusNode();
    _content2Focus = FocusNode();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    contentEditingController.dispose();
    content2EditingController.dispose();
    _titleFocus.dispose();
    _contentFocus.dispose();
    _content2Focus.dispose();

    super.dispose();
  }

  void backSceen() async {
    Get.back();
  }

  bool isLoadImages = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus(); // 포커스 해제하여 키보드 닫기
        return true; // 뒤로 가기 허용
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
          scrolledUnderElevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: backSceen,
                icon: const Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
              ),
              const TodayWidget(),
              IconButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    DiaryModel diaryModel = DiaryModel(
                      title: titleEditingController.text,
                      content: contentEditingController.text,
                      content2: content2EditingController.text,
                      imageUrls: imageBytesList,
                      mode: selectedMode,
                    );

                    await diaryController.addDiary(diaryModel);
                    // diaryModels.add(diaryModel);
                    backSceen();
                  } else {
                    print('NonO');
                  }
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.width16),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: Responsive.height16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(Responsive.width10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (selectedMode == null)
                            IconButton(
                              onPressed: () {
                                Get.bottomSheet(SafeArea(
                                  child: EmojiPicker(
                                    onBackspacePressed: () => Get.back(),
                                    onEmojiSelected: (category, emoji) {
                                      selectedMode = emoji.emoji;
                                      setState(() {});

                                      Get.back();
                                    },
                                  ),
                                ));
                              },
                              icon: const Icon(Icons.tag_faces_sharp),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                selectedMode!,
                                style: TextStyle(
                                    fontSize: Responsive.width10 * 2.2),
                              ),
                            ),
                          SizedBox(width: Responsive.width10 * 2.5),
                          IconButton(
                            onPressed: () async {
                              isLoadImages = true;
                              setState(() {});
                              final ImagePicker _picker = ImagePicker();
                              List<XFile>? images =
                                  await _picker.pickMultiImage();
                              imageBytesList = [];

                              for (var image in images!) {
                                final imageFile = File(image.path);
                                final imageBytes =
                                    await imageFile.readAsBytes();
                                imageBytesList!.add(imageBytes);
                                print(image.path);
                              }
                              isLoadImages = false;
                              setState(() {});
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                        ],
                      ),
                    ),
                    if (isLoadImages)
                      Padding(
                        padding: EdgeInsets.all(Responsive.height16 / 2),
                        child: CircularProgressIndicator(
                          color: Colors.redAccent,
                        ),
                      ),
                    if (imageBytesList != null && imageBytesList!.isNotEmpty)
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: Responsive.height16 / 2),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.75,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                          ),
                          items: List.generate(
                            imageBytesList!.length,
                            (index) => Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image.memory(imageBytesList![index]),
                                IconButton(
                                  onPressed: () {
                                    imageBytesList!.removeAt(index);
                                    setState(() {});
                                  },
                                  // icon: Icon(
                                  //   FontAwesomeIcons.close,
                                  //   size: Responsive.width10 * 4,
                                  //   color: Colors.red,
                                  // ),
                                  icon: Icon(
                                    Icons.close,
                                    size: Responsive.width10 * 3.5,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            focusNode: _titleFocus,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              enabledBorder: textFormFieldBorder(),
                              border: textFormFieldBorder(),
                              focusedBorder: textFormFieldBorder(),
                            ),
                            controller: titleEditingController,
                            validator: (value) => CheckValidate()
                                .validateTitle(_titleFocus, value),
                          ),
                          SizedBox(height: Responsive.height20),
                          TextFormField(
                            focusNode: _contentFocus,
                            decoration: InputDecoration(
                              hintText: 'Write about your day...',
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              border: textFormFieldBorder(),
                              enabledBorder: textFormFieldBorder(),
                              focusedBorder: textFormFieldBorder(),
                            ),
                            validator: (value) => CheckValidate()
                                .validateContent(_contentFocus, value),
                            controller: contentEditingController,
                            maxLines: 20,
                          ),
                          SizedBox(height: Responsive.height20),
                          TextFormField(
                            focusNode: _content2Focus,
                            decoration: InputDecoration(
                              hintText:
                                  'Any fascinating dreams to write about?',
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              border: textFormFieldBorder(),
                              enabledBorder: textFormFieldBorder(),
                              focusedBorder: textFormFieldBorder(),
                            ),
                            controller: content2EditingController,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder textFormFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
