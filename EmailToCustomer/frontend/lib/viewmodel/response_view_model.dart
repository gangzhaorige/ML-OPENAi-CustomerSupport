import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../dio.dart';

class GenerateResponseModel with ChangeNotifier {

  final List<String> languages = ['English', 'Spanish', 'Chinese', 'Japanese', 'Korean', 'French'];

  String? _curLanguage = 'English';

  bool _translateComment = false;
  bool _translateEmail = false;

  set curLanguage(String? index) {
    _curLanguage = index;
    notifyListeners();
  }

  String? get curLanguage => _curLanguage;
  
  String _comment = '';

  String get comment => _comment;

  String _email = '';

  String get email => _email;

  bool get translateComment => _translateComment;

  bool get translateEmail => _translateEmail;

  set translateComment(bool translateComment) {
    _translateComment = translateComment;
    notifyListeners();
  }

  set translateEmail(bool translateEmail) {
    _translateEmail = translateEmail;
    notifyListeners();
  }

  set comment(String comment) {
    _comment = comment;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  Future<void> generate() async {
    await DioApi.postRequest(data: {'language': curLanguage, 'translate_comment': _translateComment, 'translate_email': _translateEmail}, path: '/generate').then((value) => {
      comment = value.data['comment'],
      email = value.data['email'],
    });
  }
}