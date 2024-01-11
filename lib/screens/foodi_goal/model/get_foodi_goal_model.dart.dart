import '../../home/model/safe_convert.dart';

class FoodiGoalModel {
  final Meta? meta;
  final Data? data;

  FoodiGoalModel({
     this.meta,
     this.data,
  });

  factory FoodiGoalModel.fromJson(Map<String, dynamic>? json) => FoodiGoalModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: Data.fromJson(asT<Map<String, dynamic>>(json, 'data')),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.toJson(),
  };
}

class Meta {
  final String msg;
  final bool status;

  Meta({
    this.msg = "",
    this.status = false,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
    msg: asT<String>(json, 'msg'),
    status: asT<bool>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'msg': msg,
    'status': status,
  };
}


class Data {
  final dynamic protein;
  final dynamic calcium;
  final dynamic carbohydrates;
  final dynamic fat;
  final double caloriesPerDay;
  final String gender;
  final String userGoal;
  final String activityLevel;
  final int age;
  final int height;
  final int weight;
  final int meals;

  Data({
    this.protein = 0,
    this.calcium = 0,
    this.carbohydrates = 0,
    this.fat = 0.0,
    this.caloriesPerDay = 0.0,
    this.gender = "",
    this.userGoal = "",
    this.activityLevel = "",
    this.age = 0,
    this.height = 0,
    this.weight = 0,
    this.meals = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    protein: asT<dynamic>(json, 'protein'),
    calcium: asT<dynamic>(json, 'calcium'),
    carbohydrates: asT<dynamic>(json, 'carbohydrates'),
    fat: asT<dynamic>(json, 'fat'),
    caloriesPerDay: asT<double>(json, 'caloriesPerDay'),
    gender: asT<String>(json, 'gender'),
    userGoal: asT<String>(json, 'userGoal'),
    activityLevel: asT<String>(json, 'activityLevel'),
    age: asT<int>(json, 'age'),
    height: asT<int>(json, 'height'),
    weight: asT<int>(json, 'weight'),
    meals: asT<int>(json, 'meals'),
  );

  Map<String, dynamic> toJson() => {
    'protein': protein,
    'calcium': calcium,
    'carbohydrates': carbohydrates,
    'fat': fat,
    'caloriesPerDay': caloriesPerDay,
    'gender': gender,
    'userGoal': userGoal,
    'activityLevel': activityLevel,
    'age': age,
    'height': height,
    'weight': weight,
    'meals': meals,
  };
}

