import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_jonggack/common/responsive.dart';
import 'package:diary_jonggack/components/shadow_text.dart';
import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:diary_jonggack/main.dart';
import 'package:diary_jonggack/models/diary_models.dart';
import 'package:diary_jonggack/screens/add_diary_screen.dart';
import 'package:diary_jonggack/screens/diary_detail_screen.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:diary_jonggack/components/today_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;

  DateTime today = DateTime.now();

  late String year;
  late String month;
  late String day;
  late String week;

  void setToday() async {
    year = today.year.toString();
    month = DateFormat('MMMM').format(today);
    day = today.day.toString();
    week = DateFormat('EEEE').format(today);
    DiaryController diaryController = Get.put(DiaryController());
    await diaryController.getSameDayDiarys(today.year, today.month, today.day);
  }

  @override
  void initState() {
    setToday();

    super.initState();
  }

  // List<DiaryModel> diaryModels = [];
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
            fontSize: Responsive.width10 * 3.2,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Header(day: day, month: month, year: year, week: week),
            const SizedBox(height: 20),
            GetBuilder<DiaryController>(builder: (diaryController) {
              return CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  height: Responsive.height10 * 40,
                  // disableCenter: true,
                  viewportFraction: 0.75,
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
                    return DiaryCard(
                      diary: diaryController.diarys[index],
                    );
                  },
                ),
              );
            }),
            SizedBox(height: Responsive.height20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.height16),
              child: SizedBox(
                height: Responsive.height10 * 6,
                child: DropdownDatePicker(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.redAccent,
                  ),
                  width: 6,
                  textStyle: TextStyle(
                    fontSize: Responsive.width14,
                  ),
                  dateformatorder: OrderFormat.YDM, // default is myd
                  inputDecoration: InputDecoration(
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
                  endYear: today.year, // optional
                  selectedDay: today.day, // optional
                  selectedMonth: today.month, // optional
                  selectedYear: today.year, // optional
                  onChangedDay: (value) {
                    if (value != null) {
                      day = value;
                      today = DateTime(today.year, today.month, int.parse(day));
                      setToday();
                      setState(() {});
                    }
                  },
                  onChangedMonth: (value) {
                    if (value != null) {
                      month = value;
                      today = DateTime(today.year, int.parse(month), today.day);
                      setToday();
                      setState(() {});
                    }
                  },
                  onChangedYear: (value) {
                    if (value != null) {
                      year = value;
                      today = DateTime(int.parse(year), today.month, today.day);
                      setToday();
                      setState(() {});
                    }
                  },
                  yearFlex: 4,
                  dayFlex: 3, // optional
                  monthFlex: 4,
                  locale: "ko_KR", // optional
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                      image: AssetImage(diary.imageUrls![0]), // 이미지 경로
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

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.week,
  });

  final String day;
  final String month;
  final String year;
  final String week;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TodayWidget(
            year: year,
            month: month,
            week: week,
            day: day,
          ),
          IconButton(
              onPressed: () {
                print('asdasdsa');
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 28,
              ))
        ],
      ),
    );
  }
}
