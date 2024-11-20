import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/data/localdata/datahelper_sms.dart';
import 'package:project_domestic_violence/app/models/sms.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SMSAddTitle extends StatefulWidget {
  @override
  _SMSAddTitleState createState() => _SMSAddTitleState();
}

class _SMSAddTitleState extends State<SMSAddTitle> {
  final DatabaseHelperSMS _databaseHelper = DatabaseHelperSMS();
  List<SMSModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(Constant.USER);
    UserModel user = UserModel.fromJson(jsonDecode(userJson!));

    if (user.accountId != null) {
      List<SMSModel> messages =
          await _databaseHelper.getAllSMS(user.accountId!);
      setState(() {
        _messages = messages;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('UserId không tồn tại. Vui lòng đăng nhập.')),
      );
    }
  }

  Future<void> _deleteMessage(int id) async {
    await _databaseHelper.deleteSMS(id);
    BaseToast.showSuccessToast("Success", "Message deleted successfully");
    _loadMessages(); // Tải lại danh sách tin nhắn
  }

  void _saveMessage(SMSModel smsModel) async {
    if (smsModel.desc != null) {
      await _databaseHelper.insertSMS(smsModel);
      _loadMessages();
      BaseToast.showSuccessToast("Success", "Message saved successfully");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vui lòng nhập nội dung tin nhắn!'),
      ));
    }
  }

  void _showAddMessageModal(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            width: 400,
            child: Text(
              'Create urgent message',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: ColorData.colorText),
            ),
          ),
          content: TextField(
            controller: messageController,
            maxLines: 7,
            decoration: InputDecoration(
              hintText: 'Enter urgent message...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            Center(
              child: ButtonComponent(
                text: 'Create Mesage',
                onPress: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String? userJson = prefs.getString(Constant.USER);
                  if (userJson != null) {
                    UserModel user = UserModel.fromJson(jsonDecode(userJson));

                    SMSModel smsModel = SMSModel(
                      userId: user.accountId!,
                      desc: messageController.text,
                    );

                    _saveMessage(smsModel);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User chưa đăng nhập. Vui lòng thử lại!'),
                      ),
                    );
                  }
                },
                backgroundColor: ColorData.colorSos,
                textColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SOS Messages',
          style: TextStyle(
            color: ColorData.colorIcon,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () => _showAddMessageModal(context),
          ),
        ],
      ),
      body: _messages.isEmpty
          ? Center(child: Text('No messages available'))
          : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                SMSModel message = _messages[index];
                return Column(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: null,
                              onChanged: (value) {
                                print(
                                    "Radio selected for message: ${message.desc}");
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.desc ?? 'No content',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await _deleteMessage(message.smsId!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
