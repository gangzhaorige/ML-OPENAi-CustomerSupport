import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front_end/dio.dart';
import 'package:flutter_front_end/ui/ui_helper.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

import 'viewmodel/response_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GenerateResponseModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Email to Customer',
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, fontSize: 40)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Translate Comment',
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, fontSize: 30),
                            ),
                          ),
                          Consumer<GenerateResponseModel>(
                            builder: (_, model, __) {
                              return MSHCheckbox(
                                size: 30,
                                value: model.translateComment,
                                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                  checkedColor: Colors.blue,
                                ),
                                style: MSHCheckboxStyle.stroke,
                                onChanged: (selected) {
                                  model.translateComment = selected;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Translate Email',
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, fontSize: 30),
                            ),
                          ),
                          Consumer<GenerateResponseModel>(
                            builder: (_, model, __) {
                              return MSHCheckbox(
                                size: 30,
                                value: model.translateEmail,
                                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                  checkedColor: Colors.blue,
                                ),
                                style: MSHCheckboxStyle.stroke,
                                onChanged: (selected) {
                                  model.translateEmail = selected;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Consumer<GenerateResponseModel>(
                    builder: (_, model, __) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: model.languages
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                          value: model.curLanguage!,
                          onChanged: (String? value) {
                            model.curLanguage = value;
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      );
                    }
                  ),
                  MaterialButton(
                    onPressed: () async {
                      Provider.of<GenerateResponseModel>(context, listen: false).generate();
                    },
                    child: Text(
                      'GENERATE!',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Comment:',
                                style: TextStyle(
                                  fontSize: getResponsiveFontSize(context, fontSize: 20)
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Selector<GenerateResponseModel, String>(
                                  selector: (_, foo) => foo.comment,
                                  builder: (_, data, __) {
                                    return Text(
                                      data,
                                      style: TextStyle(
                                        fontSize: getResponsiveFontSize(context, fontSize: 15)
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5
                            )
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(
                                  fontSize: getResponsiveFontSize(context, fontSize: 20)
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Selector<GenerateResponseModel, String>(
                                    selector: (_, foo) => foo.email,
                                    builder: (_, data, __) {
                                      return Text(
                                        data,
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(context, fontSize: 15)
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
