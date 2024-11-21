import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/modules/Record/record_third.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class RecordSecondView extends StatefulWidget {
  const RecordSecondView({Key? key}) : super(key: key);

  @override
  _RecordSecondViewState createState() => _RecordSecondViewState();
}

class _RecordSecondViewState extends State<RecordSecondView> {
  // Record
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descController = TextEditingController();
  int? _gender = 1;
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
              print("object");
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
                    children: const [
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name of the violent person ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sex",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text("Male"),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        value: 2,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text("Female"),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        value: 3,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text("Other"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: 'Address the incident occurred ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 20,
                indent: 5,
                endIndent: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    maxLines: 5,
                    controller: descController,
                    decoration: const InputDecoration(
                      hintText: 'Quick description of the incident ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ButtonComponent(
                text: "Next",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecordThirdView(
                        name: nameController.text,
                        address: addressController.text,
                        desc: descController.text,
                        sex: _gender!,
                      ),
                    ),
                  );
                },
                width: 350,
                backgroundColor: ColorData.colorSos,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: ColorData.colorSos,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
