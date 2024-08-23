import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/components/today_widget.dart';
import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:diary_jonggack/models/diary_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({super.key, required this.diary});
  final DiaryModel diary;
  @override
  Widget build(BuildContext context) {
    DiaryController diaryController = Get.find<DiaryController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        // centerTitle: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: TodayWidget(
            day: diary.day.toString(),
            month: diary.month.toString(),
            year: diary.year.toString(),
            week: diary.weekday.toString(),
          ),
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
                    return Hero(
                      tag: diary.id,
                      child: Image.asset(
                        diary.imageUrls![index],
                      ),
                    );
                  }
                  return Image.asset(
                    diary.imageUrls![index],
                  );
                },
              ),
            ),
          Text(
            'Hello My Name is wonjognseo',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          if (index == 0) {
            // edit
            await diaryController.remoteDiary(diary);
          }

          Get.back();
          // }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: ''),
        ],
      ),
    );
  }
}
