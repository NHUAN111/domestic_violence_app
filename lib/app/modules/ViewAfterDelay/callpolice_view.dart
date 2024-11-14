import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class CallPoliceView extends StatefulWidget {
  const CallPoliceView({Key? key}) : super(key: key);

  @override
  _CallPoliceViewState createState() => _CallPoliceViewState();
}

class _CallPoliceViewState extends State<CallPoliceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Police"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Emergency assistance (Call the police)",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(Icons.local_police, color: Colors.blue),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Calling...',
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: ColorData.colorSos,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        totalRepeatCount:
                            1, // Loop it once, or use `repeatForever` to loop indefinitely
                        displayFullTextOnTap: true,
                      ),
                      Image.asset(
                        "assets/images/callpolice.png",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonComponent(
                      text: "Cancel",
                      onPress: () {
                        Get.back();
                      },
                      backgroundColor: ColorData.colorSos,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
