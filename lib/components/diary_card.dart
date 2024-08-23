import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/components/shadow_text.dart';
import 'package:diary_jonggack/models/diary_models.dart';
import 'package:diary_jonggack/screens/diary_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    super.key,
    required this.diary,
  });
  final DiaryModel diary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => DiaryDetailScreen(diary: diary));
      },
      child: Hero(
        tag: diary.id,
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(5, 5),
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              image: diary.imageUrls != null
                  ? DecorationImage(
                      image: MemoryImage(diary.imageUrls![0]), // 이미지 경로
                      fit: BoxFit.cover, // 이미지가 컨테이너에 가득 차도록 설정
                    )
                  : null,
            ),
            width: double.infinity,
            child: diary.imageUrls != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        // if (diary.imageUrls != null) ...[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                            ),
                            child: ShadowText(
                              text: '${diary.day} March',
                              fontSize: Responsive.width22,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.all(Responsive.width10),
                            child: ShadowText(
                              text: diary.title,
                              fontSize: Responsive.width22,
                            ),
                          ),
                        ),
                      ])
                : Padding(
                    padding: EdgeInsets.all(Responsive.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: ShadowText(
                            text: '${diary.day} March',
                            fontSize: Responsive.width22,
                          ),
                        ),
                        SizedBox(height: Responsive.height10),
                        Text(
                          diary.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.width20,
                            letterSpacing: -1.5,
                          ),
                        ),
                        SizedBox(height: Responsive.height15),
                        Text(diary.content),
                        SizedBox(height: Responsive.height20),
                        Text(diary.content2),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
