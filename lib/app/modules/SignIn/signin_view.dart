import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteUser.dart';
import 'package:project_domestic_violence/app/data/repository/authRepository.dart';
import 'dart:ui';

import 'package:project_domestic_violence/app/modules/SignIn/signin_controller.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late SignInController signInController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo SignInController với AuthRepository
    signInController = SignInController(AuthRepository(AppWriteUserProvider()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/tym.jpg",
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: signInController.formkey, // Form key từ controller
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
                            hintText: 'Nhập Email của bạn',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          controller: signInController.emailController,
                          obscureText: false,
                          validator: (value) =>
                              signInController.validateEmail(value ?? ''),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Mật khẩu của bạn',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          controller: signInController.passwordController,
                          obscureText: true,
                          validator: (value) =>
                              signInController.validatePass(value ?? ''),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            signInController.validateAndSignin(
                              email: signInController.emailController.text,
                              pass: signInController.passwordController.text,
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
                                "Vào Không Gian",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa có tài khoản?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.signup);
                              },
                              child: const Text(
                                " Đăng ký tại đây nhé",
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
