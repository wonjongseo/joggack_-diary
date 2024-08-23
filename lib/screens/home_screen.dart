import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/components/add_diary_widget.dart';
import 'package:diary_jonggack/components/diary_card.dart';
import 'package:diary_jonggack/components/home_screen_header.dart';
import 'package:diary_jonggack/controller/day_controller.dart';
import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:diary_jonggack/screens/add_diary_screen.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:get/get.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DayController dayController = Get.put(DayController());

  CarouselSliderController carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MOMENT',
          style: TextStyle(
            letterSpacing: 2,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w400,
            fontSize: Responsive.width10 * 3.2,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<DayController>(builder: (dayController) {
          return Column(
            children: [
              const HomeScreenHeader(),
              SizedBox(height: Responsive.height20),
              GetBuilder<DiaryController>(builder: (diaryController) {
                return CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: Responsive.height10 * 40,
                    viewportFraction: 0.68,
                    enableInfiniteScroll: false,
                    initialPage: _currentIndex,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      _currentIndex = index;
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: List.generate(
                    diaryController.diarys.length + 1,
                    (index) {
                      if (diaryController.diarys.length == index) {
                        return const AddDiaryWidget();
                      }
                      return DiaryCard(diary: diaryController.diarys[index]);
                    },
                  ),
                );
              }),
              SizedBox(height: Responsive.height30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.height16),
                child: DropdownDatePicker(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.redAccent,
                  ),
                  // width: 6,
                  textStyle: TextStyle(
                    fontSize: Responsive.width14,
                  ),
                  dateformatorder: OrderFormat.YDM, // default is myd
                  inputDecoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.width10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.width10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.width10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ), // optional
                  isDropdownHideUnderline: true, // optional
                  isFormValidator: true, // optional
                  startYear: 2000, // optional
                  endYear: dayController.today.year, // optional
                  selectedDay: dayController.today.day, // optional
                  selectedMonth: dayController.today.month, // optional
                  selectedYear: dayController.today.year, // optional
                  onChangedDay: dayController.onChangedDay,
                  onChangedMonth: dayController.onChangedMonth,
                  onChangedYear: dayController.onChangedYear,
                  yearFlex: 5,
                  dayFlex: 4, // optional
                  monthFlex: 6,
                  locale: "en", // optional
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
