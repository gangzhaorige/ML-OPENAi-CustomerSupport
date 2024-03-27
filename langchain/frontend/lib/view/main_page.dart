import 'package:flutter/material.dart';
import 'package:flutter_front_end/ui/custom_input_field.dart';
import 'package:provider/provider.dart';

import '../viewmodel/conversation_model.dart';
import 'main_page_bar.dart';
import 'main_page_chat.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: Column(
          children: [
            TopBar(),
            Expanded(child: Conversation()),
          ]
        ),
      ),
    );
  }
}

