import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/provider/user_info_provider.dart';
import 'package:get/get.dart';

class GuideMessage extends StatefulWidget {
  const GuideMessage({required this.text, super.key});

  final String text;

  @override
  State<GuideMessage> createState() => _GuideMessageState();
}

class _GuideMessageState extends State<GuideMessage> {
  @override
  Widget build(BuildContext context) {
    UserInfoController userController = Get.find<UserInfoController>();

    return Column(
      children: [
        const SizedBox(height: 10),
        Obx(() {
          bool isMessageOn = userController.user.value?.showMessage ?? true;
          return Visibility(
            visible: isMessageOn,
            child: Semantics(
              readOnly: true,
              
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 20,
                  color: GRAY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
