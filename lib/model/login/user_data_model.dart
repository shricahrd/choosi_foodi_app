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
  String password;
  String mobile;
  String createdAt;
  String updatedAt;
  String __v;
  String age;
  String height;
  String weight;

  UserDataModel(
    this.userId,
    this.isLogin,
    this.gender,
    this.userGoal,
    this.activityLevel,
    this.status,
    this.email,
    this.password,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.__v,
    this.age,
    this.height,
    this.weight,
  );

  UserDataModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        isLogin = json['isLogin'],
        gender = json['gender'],
        userGoal = json['userGoal'],
        activityLevel = json['activityLevel'],
        status = json['status'],
        email = json['email'],
        password = json['password'],
        mobile = json['mobile'],
        createdAt = json['createdAt'].toString(),
        updatedAt = json['updatedAt'].toString(),
        __v = json['__v'].toString(),
        age = json['age'].toString(),
        height = json['height'].toString(),
        weight = json["weight"].toString();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['isLogin'] = isLogin;
    data['gender'] = gender;
    data['userGoal'] = userGoal;
    data['activityLevel'] = activityLevel;
    data['status'] = status;
    data['email'] = email;
    data['password'] = password;
    data['mobile'] = mobile;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = __v;
    data['age'] = age;
    data['height'] = height;
    data['weight'] = weight;
    return data;
  }
}
