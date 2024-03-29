import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';

import 'package:get/get.dart';

class AppNavigationBar extends StatelessWidget {
  AppNavigationBar({required this.currentIndex, Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  int currentIndex;

  final List<String> _screens = [
    "/home",
    "/search",
    '/selected_list',
    '/profile',
    // Add more screens as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: "네비게이션 바",
      child: BottomNavigationBar(
        selectedFontSize: 12,
        showUnselectedLabels: true,
        backgroundColor: GREEN_COLOR,
        currentIndex: currentIndex,
        onTap: (index) {
          // Handle item tap
          if (index != currentIndex) {
            Get.toNamed(_screens[index]);
            currentIndex = index;
          }
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: GREEN_COLOR,
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            backgroundColor: GREEN_COLOR,
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            backgroundColor: GREEN_COLOR,
            icon: Icon(Icons.favorite),
            label: '좋아요 상품 보기',
          ),
          BottomNavigationBarItem(
            backgroundColor: GREEN_COLOR,
            icon: Icon(Icons.manage_accounts_rounded),
            label: '사용설정',
          ),
          // Add more BottomNavigationBarItems as needed
        ],
      ),
    );
  }
}
