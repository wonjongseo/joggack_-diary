import 'package:diary_jonggack/controller/diary_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class DayController extends GetxController {
  late DateTime today;
  late DiaryController diaryController;
  DayController() {
    today = DateTime.now();
    diaryController = Get.put(DiaryController());
    diaryController.getSameDayDiarys(today);
  }

  void onChangedDay(String? day) {
    if (day == null) {
      return;
    }

    today = DateTime(today.year, today.month, int.parse(day));

    print('today : ${today}');

    diaryController.getSameDayDiarys(today);
    update();
  }

  void onChangedMonth(String? month) {
    if (month == null) {
      return;
    }
    today = DateTime(today.year, int.parse(month), today.day);
    diaryController.getSameDayDiarys(today);
    update();
  }

  void onChangedYear(String? year) {
    if (year == null) {
      return;
    }
    today = DateTime(int.parse(year), today.month, today.day);
    print('today : ${today}');
    diaryController.getSameDayDiarys(today);
    update();
  }

  String getYear() {
    return today.year.toString();
  }

  String getMonth() {
    return DateFormat('MMMM').format(today);
  }

  String getDay() {
    return today.day.toString();
  }

  String getWeekend() {
    return DateFormat('EEEE').format(today);
  }

  void updateDate(DateTime newDate) {
    today = newDate;

    update();
  }
}
