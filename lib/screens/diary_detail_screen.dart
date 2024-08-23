import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/components/today_widget.dart';
import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:diary_jonggack/models/diary_models.dart';
import 'package:diary_jonggack/screens/add_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({super.key, required this.diary});
  final DiaryModel diary;

  void _showFullScreenImage(BuildContext context, Uint8List image) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.all(0), // EdgeInsets.zero로 설정하여 다이얼로그 크기 조절
          backgroundColor: Colors.transparent,
          child: Image.memory(image, fit: BoxFit.cover),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DiaryController diaryController = Get.find<DiaryController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TodayWidget(),
            if (diary.mode != null) Text(diary.mode!)
          ],
        ),
      ),
      body: Column(
        children: [
          if (diary.imageUrls != null)
            CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
              items: List.generate(
                diary.imageUrls!.length,
                (index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        _showFullScreenImage(
                          context,
                          diary.imageUrls![index],
                        );
                      },
                      child: Hero(
                        tag: diary.id,
                        child: Image.memory(
                          diary.imageUrls![index],
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      _showFullScreenImage(
                        context,
                        diary.imageUrls![index],
                      );
                    },
                    child: Image.memory(
                      diary.imageUrls![index],
                    ),
                  );
                },
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Responsive.width16),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.width20,
                        ),
                      ),
                      Text(
                        diary.title,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: Responsive.height16,
                        ),
                      ),
                      SizedBox(height: Responsive.height20),
                      Text(
                        'Content',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.width20,
                        ),
                      ),
                      Text(
                        diary.content,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: Responsive.height16,
                        ),
                      ),
                      if (diary.content2 != '') ...[
                        SizedBox(height: Responsive.height20),
                        Text(
                          'Content2',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.width20,
                          ),
                        ),
                        Text(
                          diary.content2,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: Responsive.height16,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, color: Colors.grey),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: Responsive.width10 * 2.4,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            onTap: (index) async {
              if (index == 0) {
                String? result = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(Responsive.width18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                            onTap: () {
                              Get.back(result: 'edit');
                              // 수정 로직 추가
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete'),
                            onTap: () {
                              Get.back(result: 'delete');
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (result == null) {
                  return;
                } else if (result == 'edit') {
                  print('aasd');

                  Get.to(
                    () => AddDiaryScreen(
                      diaryModel: diary,
                    ),
                  );
                } else if (result == 'delete') {
                  await diaryController.remoteDiary(diary);
                  Get.back();
                }
              } else {
                Get.back();
              }

              // }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.close), label: ''),
            ],
          ),
        ],
      ),
    );
  }
}
