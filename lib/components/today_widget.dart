import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/controller/day_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DayController>(builder: (dayController) {
      return Row(
        children: [
          Text(
            dayController.getDay(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: Responsive.height20 * 2.5,
              fontFamily: 'NewAmsterdam',
            ),
          ),
          SizedBox(width: Responsive.width12),
          Text(
            '${dayController.getMonth()}, ${dayController.getYear()}\n${dayController.getWeekend()}',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: Responsive.height20,
              height: 1.2,
              fontFamily: 'NewAmsterdam',
            ),
          ),
        ],
      );
    });
  }
}
