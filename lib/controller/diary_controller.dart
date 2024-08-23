import 'package:diary_jonggack/models/diary_models.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DiaryController extends GetxController {
  List<DiaryModel> diarys = [];

  Future<void> getAllDiarys() async {
    diarys = await DiaryReporistory.getAllDatas();
    update();
  }

  Future<void> getSameDayDiarys(DateTime searchedDate) async {
    diarys = await DiaryReporistory.getSameDayDatas(searchedDate);
    update();
  }

  Future<void> addDiary(DiaryModel diary) async {
    diarys.add(diary);
    await DiaryReporistory.putData(diary);
    update();
  }

  Future<void> remoteDiaryAtIndex(int index) async {
    DiaryModel remoteDiary = diarys[index];

    if (await DiaryReporistory.remoteDatas(remoteDiary) == true) {
      diarys.removeAt(index);

      update();
    }
  }

  Future<bool> remoteDiary(DiaryModel remoteDiary) async {
    for (int i = 0; i < diarys.length; i++) {
      if (diarys[i].id == remoteDiary.id) {
        await remoteDiaryAtIndex(i);
        return true;
      }
    }
    return false;
  }
}

class DiaryReporistory {
  static Future<bool> isExistData() async {
    final box = Hive.box(DiaryModel.boxKey);
    return box.isNotEmpty;
  }

  static Future<bool> putData(DiaryModel diary) async {
    try {
      final box = Hive.box(DiaryModel.boxKey);

      await box.put(diary.id, diary);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<DiaryModel>> getSameDayDatas(DateTime searchedDate) async {
    final box = Hive.box(DiaryModel.boxKey);
    print('searchedDate : ${searchedDate}');

    try {
      List<DiaryModel> diaryModels =
          box.values.whereType<DiaryModel>().where((element) {
        if (element.year == searchedDate.year &&
            element.day == searchedDate.day &&
            element.month == searchedDate.month) {
          return true;
        }
        return false;
      }).toList();

      return diaryModels;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<List<DiaryModel>> getAllDatas() async {
    final box = Hive.box(DiaryModel.boxKey);

    try {
      List<DiaryModel> diaryModels = List.generate(
        box.length,
        (index) {
          print('box.getAt(index) : ${box.getAt(index)}');

          return (box.getAt(index));
        },
      );

      return diaryModels;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<bool> remoteDatas(DiaryModel diary) async {
    final box = Hive.box(DiaryModel.boxKey);

    try {
      await box.delete(diary.id);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
