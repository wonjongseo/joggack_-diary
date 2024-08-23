import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/screens/add_diary_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDiaryWidget extends StatelessWidget {
  const AddDiaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const AddDiaryScreen());
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(
          Responsive.width10,
        ),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: Responsive.width10 * 5,
              ),
              SizedBox(height: Responsive.height15),
              Text(
                'Write about a your today',
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
