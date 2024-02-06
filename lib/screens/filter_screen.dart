import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/models/filter_list.dart';
import 'package:gdsc_solution_project/screens/best_list_screen.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
import 'package:gdsc_solution_project/widgets/filter_screen/selcet_price_screen.dart';
import 'package:get/get.dart';


class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final List<Filter> filters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '특정 카테고리의\n인기상품을 골라주세요',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder<FilterList>(
              future:
                  ApiService().getBestFilters(), // 비동기 작업으로 FilterList를 가져옵니다.
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {

                  // 에러가 발생한 경우 에러 메시지를 표시합니다.
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 데이터가 성공적으로 로드된 경우 UI를 구성합니다.
                  filters =
                      snapshot.data!.filterList;
                      
                  return Column(
                    children: [
                      ...filters
                          .map(
                            (filter) => CustomTextButton(
                              filter.title, // Filter 모델의 title 필드를 사용합니다.
                              () {
                                
                                  Get.to(BestListScreen(isBestUrl:filter.url, title: filter.title,));
                                
                              },
                            ),
                          )
                          .toList(),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  );
                }
              },
            ),
            
          ],
        ),
      ),
    );
  }

  Column CustomTextButton(String label, VoidCallback onPressed) {
    return Column(
      children: [
        Divider(
          color: Colors.black,
        ),
        TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
