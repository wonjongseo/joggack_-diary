import 'package:diary_jonggack/common/responsive.dart';
import 'package:flutter/material.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget(
      {super.key,
      required this.year,
      required this.month,
      required this.week,
      required this.day});

  final String day;
  final String year;
  final String month;
  final String week;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: Responsive.width10 * 0.8),
        Text(
          '$month , $year\n$week',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
