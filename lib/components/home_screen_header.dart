import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/components/today_widget.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TodayWidget(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: Responsive.width10 * 2.8,
            ),
          )
        ],
      ),
    );
  }
}
