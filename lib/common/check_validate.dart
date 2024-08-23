import 'package:flutter/material.dart';

class CheckValidate {
  String? validateTitle(FocusNode focusNode, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Write the title';
    } else if (value.length < 5) {
      return 'Please Write 5 more chat';
    }
    return null; // バリデーションが成功した場合はnullを返す
  }

  String? validateContent(FocusNode focusNode, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Write the content';
    } else if (value.length < 5) {
      return 'Please Write 10 more chat';
    }
    return null; // バリデーションが成功した場合はnullを返す
  }
}
