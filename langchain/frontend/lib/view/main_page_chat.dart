import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/message_model.dart';
import 'package:flutter_front_end/ui/message.dart';
import 'package:provider/provider.dart';

import '../ui/custom_input_field.dart';
import '../viewmodel/conversation_model.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 1000,
              child: CustomScrollView(
                controller: _controller,
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverFillRemaining(
                    fillOverscroll: true,
                    hasScrollBody: false,
                    child: Consumer<ConversationModel>(
                      builder: (context, data, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(MessageModel messageInfo in data.conversations) ...[
                              Message(messageInfo: messageInfo)
                            ]
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomTextField(scrollController: _controller)
      ],
    );
    
  }
}