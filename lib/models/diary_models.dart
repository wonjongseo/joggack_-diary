import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:diary_jonggack/models/model_ids.dart';

part 'diary_models.g.dart';

@HiveType(typeId: ModelIds.DiaryModelTypeId)
class DiaryModel {
  static final String boxKey = 'diaryModel';

  @HiveField(1)
  late String id;

  @HiveField(2)
  final String title;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final String content2;

  @HiveField(5)
  List<String>? imageUrls;

  @HiveField(6)
  late int year;
  @HiveField(7)
  late int month;
  @HiveField(8)
  late int day;
  @HiveField(9)
  late int weekday;

  @HiveField(10)
  late DateTime createAt;
  @HiveField(11)
  late DateTime updatedAt;

  DiaryModel({
    this.imageUrls,
    required this.title,
    required this.content,
    required this.content2,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
    createAt = DateTime.now();
    year = createAt.year;
    month = createAt.month;
    day = createAt.day;
    weekday = createAt.weekday;

    updatedAt = DateTime.now();
  }

  DiaryModel copyWith({
    String? id,
    String? title,
    String? content,
    String? content2,
    List<String>? imageUrls,
    int? year,
    int? month,
    int? day,
    int? weekday,
    DateTime? createAt,
    DateTime? updatedAt,
  }) {
    return DiaryModel(
      title: title ?? this.title,
      content: content ?? this.content,
      content2: content2 ?? this.content2,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'content2': content2});
    if (imageUrls != null) {
      result.addAll({'imageUrls': imageUrls});
    }

    return result;
  }

  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      content2: map['content2'] ?? '',
      imageUrls: List<String>.from(map['imageUrls']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryModel.fromJson(String source) =>
      DiaryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiaryModel(id: $id, title: $title, content: $content, content2: $content2, imageUrls: $imageUrls, year: $year, month: $month, day: $day, weekday: $weekday, createAt: $createAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiaryModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.content2 == content2 &&
        listEquals(other.imageUrls, imageUrls) &&
        other.year == year &&
        other.month == month &&
        other.day == day &&
        other.weekday == weekday &&
        other.createAt == createAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        content2.hashCode ^
        imageUrls.hashCode ^
        year.hashCode ^
        month.hashCode ^
        day.hashCode ^
        weekday.hashCode ^
        createAt.hashCode ^
        updatedAt.hashCode;
  }
}
