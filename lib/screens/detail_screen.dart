import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/components/rating_star.dart';
import 'package:gdsc_solution_project/commons/components/text_contents.dart';
import 'package:gdsc_solution_project/commons/components/text_title_box.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.url, super.key});

  String? url;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDetailVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      //TODO futurebuilder이용해서 디테일 정보 받아오기
      body: FutureBuilder(
          future: ApiService().prodDetail(widget.url!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("오류가 발생했습니다\n ${snapshot.error}");
            } else if (snapshot.hasData) {
              final product = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child:
                          Image.network(product.prodImgUrl, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      color: BLACK_COLOR,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product.subTitle,
                                    style: TextStyle(
                                      color: DETAIL_COLOR,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 0.10,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_outline))
                            ],
                          ),
                          SizedBox(height: 12.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '가격',
                                style: TextStyle(
                                  color: BLACK_COLOR,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Column(
                                children: [
                                  if (product.dimmPrice != '')
                                    Text(product.dimmPrice),
                                  Text(product.price),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12.0,),
                          Text(
                            '주요정보',
                            style: TextStyle(
                              color: BLACK_COLOR,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.0,),
                          Column(
                              children: product.details.map((e) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(e.itemCate),
                                Text(e.itemName),
                                Text(e.itemContent),
                              ],
                            );
                          }).toList()),

                          Text(
                            '리뷰',
                            style: TextStyle(
                              color: BLACK_COLOR,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '총점',
                                style: TextStyle(
                                  color: BLACK_COLOR,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '1233개 리뷰',
                                style: TextStyle(
                                  color: DETAIL_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          TextTitleBox(
                            mainIcon: StarRating(rating: 3),
                            subText: '4/5 점',
                            mode: 'sub',
                          ),

                          //TODO futurebuilder이용해서 리뷰 정보, 리뷰 요약 받아오기

                          TextTitleBox(
                            mainText: '종합 리뷰',
                            mode: 'sub',
                          ),
                          TextContentBox(
                            mainText: '곰곰 고추장 제육 불고기는...',
                          ),
                          Visibility(
                            visible: _isDetailVisible,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTitleBox(
                                  mainText: '장점',
                                  mode: 'sub',
                                ),
                                TextContentBox(
                                  mainText: '맛과 식감: 사용자는 제품의 맛을 극찬하며, ...',
                                ),
                                TextTitleBox(
                                  mainText: '단점',
                                  mode: 'sub',
                                ),
                                TextContentBox(
                                  mainText:
                                      '수입산 고기 사용: 몇몇 리뷰어들은 수입산 고기를 사용한 것이 아쉽다고 언급했으나...',
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 12.0,
                              ),
                              CustomButton(
                                onPressed: () {
                                  setState(() {
                                    _isDetailVisible =
                                        !_isDetailVisible; // 상태 업데이트
                                  });
                                },
                                label:
                                    _isDetailVisible ? '리뷰 요약보기' : '리뷰 자세히 보기',
                                backgroundColor: LIGHT_GREEN_COLOR,
                                textColor: GREEN_COLOR,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              CustomButton(
                                onPressed: () {},
                                label: '사이트 확인하기',
                                backgroundColor: GREEN_COLOR,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('데이터가 없습니다.');
            }
          }),
    );
  }
}
