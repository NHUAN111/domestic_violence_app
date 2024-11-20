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
        title: const Text(
          "Call Police",
          style: TextStyle(
            color: ColorData.colorIcon,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              color: Color.fromARGB(255, 255, 230, 230),
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Emergency assistance (Call the police)",
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorData.colorSos,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.local_police,
                      color: ColorData.colorSos,
                      size: 34,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Calling...',
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: ColorData.colorSos,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                    totalRepeatCount: 20,
                    displayFullTextOnTap: true,
                  ),
                  Image.asset(
                    "assets/images/callpolice.png",
                  ),
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
