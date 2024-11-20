import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteRecord.dart';
import 'package:project_domestic_violence/app/data/repository/recordRepository.dart';
import 'package:project_domestic_violence/app/models/record.dart';
import 'package:project_domestic_violence/app/modules/Record/record_controller.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';

class RecordThirdView extends StatefulWidget {
  final String name;
  final String address;
  final String desc;
  final int sex;

  const RecordThirdView({
    Key? key,
    required this.name,
    required this.address,
    required this.desc,
    required this.sex,
  }) : super(key: key);

  @override
  _RecordThirdViewState createState() => _RecordThirdViewState();
}

class _RecordThirdViewState extends State<RecordThirdView> {
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  //
  late RecordController recordController;
  late AppwriteRecord appwriteRecord;

  @override
  void initState() {
    super.initState();
    appwriteRecord = AppwriteRecord();
    recordController = RecordController(RecordRepository(AppwriteRecord()));
  }

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  bool isValidFileType(String filePath) {
    final validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'mp4'];
    final extension = filePath.split('.').last.toLowerCase();
    return validExtensions.contains(extension);
  }

  void _saveRecord(BuildContext context) {
    if (_selectedImages.isEmpty) {
      print("Please select at least one image or video.");
      return;
    }

    for (var image in _selectedImages) {
      if (!isValidFileType(image.path)) {
        print("Unsupported file format. Please upload an image or video.");
        return;
      }
    }
    print("name ${widget.name}");
    print("name ${widget.sex}");
    print("name ${widget.address}");
    print("name ${widget.desc}");
    RecordModel recordModel = RecordModel(
      name: widget.name ?? "Unknown",
      sex: widget.sex,
      address: widget.address ?? "Unknown",
      desc: widget.desc ?? "",
    );

    // setState(() {
    //   _selectedImages.clear();
    // });

    List<String> imagePaths =
        _selectedImages.map((image) => image.path).toList();
    recordController
        .createRecord(recordModel, imagePaths)
        .then((value) => {
              BaseToast.showSuccessToast(
                  "Success", "Record created successfully!")
              // Get.toNamed(Routes.);
            })
        .catchError((error) {
      BaseToast.showErrorToast("Error", "Failed to create post: $error");
    });
  }

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
              Icons.list_sharp,
              size: 28,
              color: ColorData.colorIcon,
            ),
            onPressed: () {
              Get.toNamed(Routes.recordlist);
              print("Navigate to record list");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
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
                    children: [
                      Expanded(
                        child: Text(
                          "The information will be evidence to help you report the person who committed the violent act.",
                          style: TextStyle(
                            fontSize: 17,
                            color: ColorData.colorSos,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.video_call,
                        color: ColorData.colorSos,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 20, top: 30),
                  child: Column(
                    children: [
                      Text(
                        "Give credit to your report",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: ColorData.colorSos,
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: _pickImages,
                        child: Image.asset("assets/images/camera-retro.png"),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Upload pictures or video \n (Recommend videos of max 20sec)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorData.colorSos,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      if (_selectedImages.isNotEmpty)
                        Column(
                          children:
                              List.generate(_selectedImages.length, (index) {
                            return Stack(
                              children: [
                                Image.file(
                                  File(_selectedImages[index].path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      SizedBox(height: 30),
                      ButtonComponent(
                        text: "Complete",
                        width: 380,
                        onPress: () {
                          _saveRecord(context);
                        },
                        backgroundColor: ColorData.colorSos,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
