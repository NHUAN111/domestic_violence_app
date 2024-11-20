import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteRecord.dart';
import 'package:project_domestic_violence/app/data/repository/recordRepository.dart';
import 'package:project_domestic_violence/app/models/record.dart';
import 'package:project_domestic_violence/app/modules/Record/record_controller.dart';
import 'package:project_domestic_violence/app/modules/Record/record_detail.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordListView extends StatefulWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  late RecordController recordController;
  late AppwriteRecord appwriteRecord;

  // Create list
  final RxList<RecordModel> records = <RecordModel>[].obs;

  @override
  void initState() {
    super.initState();
    appwriteRecord = AppwriteRecord();
    recordController = RecordController(RecordRepository(AppwriteRecord()));
    fectRecord();
  }

  Future<void> fectRecord() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(Constant.USER);
    if (userJson == null) {
      print('User not logged in or user data is unavailable.');
      return;
    }

    final userMap = Map<String, dynamic>.from(jsonDecode(userJson));
    String? userId = userMap['accountId'];
    print('User ID: $userId');

    try {
      List<Map<String, dynamic>> rawRecords =
          await recordController.fetchRecordsByUserId(userId!);
      records.value =
          rawRecords.map((record) => RecordModel.fromJson(record)).toList();
      print(rawRecords.length);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch record: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "List the incident",
            style: TextStyle(
              color: ColorData.colorIcon,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 28,
              color: ColorData.colorIcon,
            ),
            onPressed: () {
              Get.toNamed(Routes.recordfirst);
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (records.isEmpty) {
            return const Center(
              child: Text("No records found"),
            );
          }
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              int i = index + 1;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecordDetail(
                        name: record.name,
                        address: record.address,
                        desc: record.desc,
                        sex: record.sex,
                        images: record!.images!,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/Case.png",
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Case No. $i",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  record.name ?? "Untitled",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
