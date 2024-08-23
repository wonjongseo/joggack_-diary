import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_jonggack/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:diary_jonggack/common/check_validate.dart';
import 'package:diary_jonggack/components/today_widget.dart';
import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:diary_jonggack/models/diary_models.dart';
import 'package:get/get.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key});

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
  List<XFile>? images = null;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DiaryController diaryController = Get.find<DiaryController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    titleEditingController = TextEditingController();
    contentEditingController = TextEditingController();
    content2EditingController = TextEditingController();

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

  void backSceen() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const TodayWidget(
              day: '23',
              year: '2024',
              month: 'March',
              week: 'Friday',
            ),
            IconButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  DiaryModel diaryModel = DiaryModel(
                    title: titleEditingController.text,
                    content: contentEditingController.text,
                    content2: content2EditingController.text,
                    imageUrls: images != null
                        ? List.generate(
                            images!.length, (index2) => images![index2].path)
                        : null,
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
                    margin: EdgeInsets.symmetric(vertical: Responsive.height16),
                    // padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      borderRadius: BorderRadius.circular(Responsive.width10),
                      // color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.tag_faces_sharp)),
                        SizedBox(width: Responsive.width10 * 2.5),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.wb_sunny_outlined)),
                        SizedBox(width: Responsive.width10 * 2.5),
                        IconButton(
                          onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
// ギャラリーから写真を選択
                            images = await _picker.pickMultiImage();
                            if (images != null) {
                              for (var image in images!) {
                                print(image.path);
                              }
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                      ],
                    ),
                  ),
                  if (images != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: Responsive.height16 / 2),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 0.75,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                        ),
                        items: List.generate(
                          images!.length,
                          (index) => Image.asset(images![index].path),
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
                          validator: (value) =>
                              CheckValidate().validateTitle(_titleFocus, value),
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
                            hintText: 'Any fascinating dreams to write about?',
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
    );
  }

  OutlineInputBorder textFormFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
