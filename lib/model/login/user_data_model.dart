import 'dart:convert';

UserDataModel UserDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String UserDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String userId;

  bool isLogin;

  String gender;
  String userGoal;
  String activityLevel;
  String status;
  String email;
  String mobile;
  String createdAt;
  String updatedAt;
  String age;
  String height;
  String weight;
  bool? isRestaurantAdded;

  UserDataModel(
    this.userId,
    this.isLogin,
    this.gender,
    this.userGoal,
    this.activityLevel,
    this.status,
    this.email,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.height,
    this.weight,
      this.isRestaurantAdded,
  );

  UserDataModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        isLogin = json['isLogin'],
        gender = json['gender'],
        userGoal = json['userGoal'],
        activityLevel = json['activityLevel'],
        status = json['status'],
        email = json['email'],
        mobile = json['mobile'],
        createdAt = json['createdAt'].toString(),
        updatedAt = json['updatedAt'].toString(),
        age = json['age'].toString(),
        height = json['height'].toString(),
        weight = json["weight"].toString(),
        isRestaurantAdded = json["isRestaurantAdded"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['isLogin'] = isLogin;
    data['gender'] = gender;
    data['userGoal'] = userGoal;
    data['activityLevel'] = activityLevel;
    data['status'] = status;
    data['email'] = email;
    data['mobile'] = mobile;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['age'] = age;
    data['height'] = height;
    data['weight'] = weight;
    data['isRestaurantAdded'] = isRestaurantAdded;
    return data;
  }
}
