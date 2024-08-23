import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DayController extends GetxController {
  late DateTime today;
  DayController() {
    today = DateTime.now();
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
