import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteUser.dart';
import 'package:project_domestic_violence/app/data/repository/authRepository.dart';
import 'package:project_domestic_violence/app/modules/SignUp/signup_controller.dart';
import 'dart:ui';

import 'package:project_domestic_violence/app/utils/toast.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignUpController signUpController;

  @override
  void initState() {
    super.initState();
    signUpController = SignUpController(AuthRepository(AppWriteUserProvider()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Ảnh nền
          Image.asset(
            "assets/images/tym.jpg",
            fit: BoxFit.cover,
          ),
          // Hiệu ứng mờ
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          // Nội dung
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: signUpController.formkey, // Form key for validation
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/tym.jpg",
                                  height: 80.0,
                                  width: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "Calm Corner",
                              style: TextStyle(
                                color: Color.fromARGB(255, 83, 178, 255),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Nơi Bình Yên Của Bạn",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Tên của bạn',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(235, 255, 255, 255),
                                  width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(235, 5, 83, 105),
                                  width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 0.5),
                            ),
                          ),
                          controller: signUpController.usernameController,
                          validator: (value) =>
                              signUpController.validateName(value!),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Điền Email của bạn nhé',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(235, 255, 255, 255),
                                  width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(235, 5, 83, 105),
                                  width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 0.5),
                            ),
                          ),
                          controller: signUpController.emailController,
                          validator: (value) =>
                              signUpController.validateEmail(value!),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Tạo cho mình một mật khẩu nè',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(235, 255, 255, 255),
                                  width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(235, 5, 83, 105),
                                  width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 0.5),
                            ),
                          ),
                          controller: signUpController.passwordController,
                          obscureText: true,
                          validator: (value) =>
                              signUpController.validatePass(value!),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            signUpController.validateAndSignup(
                              name: signUpController.usernameController.text,
                              email: signUpController.emailController.text,
                              pass: signUpController.passwordController.text,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 83, 178, 255),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Tạo Tài Khoản",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "hoặc",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn đã có tài khoản?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                " Đăng nhập tại đây nhé",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 83, 178, 255),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
