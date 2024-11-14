import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  late SharedPreferences prefs;
  late String userJson;
  late UserModel user;

  // Initialize text controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    prefs = await SharedPreferences.getInstance();
    userJson = prefs.getString(Constant.USER) ?? '';

    if (userJson.isNotEmpty) {
      user = UserModel.fromJson(jsonDecode(userJson));

      _usernameController.text = user.userName ?? '';
      _emailController.text = user.email ?? '';
      _passwordController.text = user.password ?? '';
      print("pass ${user.password}");
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: ColorData.colorIcon,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorData.colorNavBar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/sosicon.png'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ButtonComponent(
              text: "Update Profile",
              onPress: () {
                // Handle profile update logic here
              },
              backgroundColor: ColorData.colorMain,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
