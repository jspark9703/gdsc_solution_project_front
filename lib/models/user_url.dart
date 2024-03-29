// User 모델
class User {
  String? userName;
  String? userClass;
  String? userInfo;
  bool? showMessage;

  User({this.userName, this.userClass, this.userInfo, this.showMessage});

  // JSON에서 User 객체로 변환하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json['user_name'],
        userClass: json['user_class'],
        userInfo: json['user_info'],
        showMessage: json['show_message'],
      );

  // User 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'user_name': userName,
        'user_class': userClass,
        'user_info': userInfo,
        'show_message': showMessage,
      };
}
