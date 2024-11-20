import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class RecordListView extends StatefulWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Record the incident",
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
    );
  }
}
