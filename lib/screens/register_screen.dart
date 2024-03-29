import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:gdsc_solution_project/commons/component/custom_text_field.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/login_screen.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Semantics(
              container: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    readOnly: true,
                    child: const Text(
                      '쇼핑 안내견 서비스를 이용하시려면,\n회원 가입을 진행해 주세요.',
                      style: TextStyle(
                        fontSize: 20,
                        color: GRAY_COLOR,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Semantics(
                    readOnly: true,
                    label: "이메일",
                    child: const Text(
                      '이메일',
                      style: TextStyle(fontSize: 20, color: GRAY_COLOR),
                    ),
                  ),
                  Semantics(
                    textField: true,
                    child: CustomTextField(
                        controller: _emailController,
                        hintText: '이메일을 입력해 주세요',
                        obscure: false,
                        prefixIcons: const Icon(Icons.email)),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    readOnly: true,
                    child: const Text(
                      '비밀번호',
                      style: TextStyle(fontSize: 20, color: GRAY_COLOR),
                    ),
                  ),
                  Semantics(
                    textField: true,
                    child: CustomTextField(
                        controller: _passwordController,
                        hintText: '비밀번호를 입력해 주세요',
                        obscure: true,
                        prefixIcons: const Icon(Icons.lock)),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    readOnly: true,
                    child: const Text(
                      '비밀번호 확인',
                      style: TextStyle(fontSize: 20, color: GRAY_COLOR),
                    ),
                  ),
                  Semantics(
                    textField: true,
                    child: CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: '비밀번호를 입력해 주세요',
                        obscure: true,
                        prefixIcons: const Icon(Icons.lock)),
                  ),
                  const SizedBox(height: 32),
                  Semantics(
                    button: true,
                    child: CustomButton(
                        onPressed: () {
                          // Register logic here
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            AuthController.instance.register(
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          } else {
                            // Show error message
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                "Confirm password",
                                "비밀번호를 확인해주세요");
                          }
                        },
                        label: '등록하기',
                        backgroundColor: GREEN_COLOR,
                        textColor: Colors.white),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(
                        readOnly: true,
                        child: const Text(
                          "이미 계정이 있으신가요?",
                          style: TextStyle(color: GRAY_COLOR),
                        ),
                      ),
                      Semantics(
                        button: true,
                        child: TextButton(
                          onPressed: () {
                            Get.to(const LoginScreen());
                          },
                          child: const Text(
                            '로그인',
                            style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
