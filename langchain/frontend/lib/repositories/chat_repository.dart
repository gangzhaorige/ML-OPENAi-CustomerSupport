import 'package:dio/dio.dart';
import 'package:flutter_front_end/dio.dart';
import 'package:flutter_front_end/view/main_page_chat.dart';

import '../models/message_model.dart';

class ChatRepository {

  Future<MessageModel> generateMessage(String question) async {
    Response<dynamic> response = await DioApi.postRequest(path: '/generate', data: {'question' : question});
    return MessageModel(isSender: false, text: response.data['response'], url: response.data['url']);
  }
}