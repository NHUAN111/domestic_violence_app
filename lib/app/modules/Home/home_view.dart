import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/emergency_button_component.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/text.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';

import '../../routes/app_pages.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorData.colorNavBar,
          titleSpacing: 16,
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          "assets/images/lion.png",
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: ColorData.colorIcon,
                              size: 20,
                            ),
                            Text(
                              "Current location",
                              style: TextStyle(
                                color: ColorData.colorIcon,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          UtilText.truncateString('Ngu Hanh Son, Da Nang', 20),
                          style: const TextStyle(
                              fontSize: 14,
                              color: ColorData.colorIcon,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    color: ColorData.colorIcon,
                    onPressed: () {
                      print('camera');
                    },
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    color: ColorData.colorIcon,
                    onPressed: () {
                      print('notification');
                    },
                    icon: Icon(
                      Icons.notifications_active,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Are you in an emergency?',
                            style: TextStyle(
                              color: ColorData.colorText,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Press the SOS button, your live location will be shared with the nearest help centre and your emergency contacts.',
                            style: TextStyle(
                              color: ColorData.colorText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Image.asset(
                        'assets/images/victim.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Column(
                  children: [
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 14,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 247, 88, 88)
                                              .withOpacity(0.7),
                                      spreadRadius: 10,
                                      blurRadius: 50,
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print("Nút SOS đã được nhấn!");
                                    Get.toNamed(Routes.sosview);
                                  },
                                  child: Card(
                                    elevation: 10,
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    // Nút SOS
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'SOS',
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Emergency Features',
                  style: TextStyle(
                    color: ColorData.colorIcon,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    EmergencyButtonComponent(
                      label: ' Call Police',
                      icon: Icons.local_police,
                      onPressed: () {
                        //
                        BaseToast.showConfirmToast("Notification",
                            "Please confirm to transfer the call to the police",
                            () {
                          //
                          Get.toNamed(Routes.callpoliceview);
                        });
                      },
                    ),
                    EmergencyButtonComponent(
                      label: ' SMS SOS',
                      icon: Icons.sms,
                      onPressed: () {
                        //
                      },
                    ),
                    EmergencyButtonComponent(
                      label: ' Record ',
                      icon: Icons.video_call,
                      onPressed: () {
                        //
                      },
                    ),
                    EmergencyButtonComponent(
                      label: ' Share Location',
                      icon: Icons.emergency_share,
                      onPressed: () {
                        //
                      },
                    ),
                    EmergencyButtonComponent(
                      label: ' Stealth Mode',
                      icon: Icons.visibility,
                      onPressed: () {
                        //
                      },
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
