import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class CalmCornerScreen extends StatelessWidget {
  const CalmCornerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Icon(Icons.self_improvement, size: 34, color: Colors.grey),
        title: Text(
          'Calm Corner',
          style: TextStyle(
            color: ColorData.colorIcon,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu, color: Colors.grey),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.home, color: ColorData.colorIcon),
                  title: Text("Home"),
                  onTap: () {
                    // Handle Home action
                    Get.toNamed(Routes.home);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.call, color: ColorData.colorIcon),
                  title: Text("Call"),
                  onTap: () {
                    // Handle Call action
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.message, color: ColorData.colorIcon),
                  title: Text("Message"),
                  onTap: () {
                    // Handle Message action
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.location_on, color: ColorData.colorIcon),
                  title: Text("Location"),
                  onTap: () {
                    // Handle Location action
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.info, color: ColorData.colorIcon),
                  title: Text("About"),
                  onTap: () {
                    // Handle About action
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/images/Flow.png"),

            _buildCircularButton(Icons.music_note, context, () {
              //
            }),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 60,
              runSpacing: 50,
              children: [
                _buildCircularButton(Icons.bookmark, context, () {
                  //
                }),
                _buildCircularButton(Icons.chrome_reader_mode, context, () {
                  //
                }),
                _buildCircularButton(Icons.lock_clock, context, () {
                  //
                }),
                _buildCircularButton(Icons.info, context, () {
                  //
                }),
              ],
            ),

            const SizedBox(height: 40),

            // Add button at the bottom
            CircleAvatar(
              radius: 30,
              backgroundColor: ColorData.colorIcon,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFE9F1F5), // Light background color
    );
  }

  Widget _buildCircularButton(
      IconData icon, BuildContext context, VoidCallback onPress) {
    return GestureDetector(
      onTap: () {
        onPress;
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(icon, color: ColorData.colorIcon),
      ),
    );
  }
}
