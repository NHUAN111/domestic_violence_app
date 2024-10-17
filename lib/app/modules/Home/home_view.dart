import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/text.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          ),
                          Text(
                            "Current location",
                            style: TextStyle(
                              color: ColorData.colorIcon,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        UtilText.truncateString('Ngu Hanh Son, Da Nang', 20),
                        style: const TextStyle(
                            fontSize: 12,
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
                    print('notifycation');
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
          padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 230,
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
                          'Press the SOS button, your live location will be shared wih the nearest help centre and your emergency contacts',
                          style: TextStyle(
                            color: ColorData.colorText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/victim.jpg',
                    width: 120,
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                children: [
                  Text(
                    'Call Emergency',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
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
                                  // Xử lý sự kiện khi nút SOS được nhấn
                                  print("Nút SOS đã được nhấn!");
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
