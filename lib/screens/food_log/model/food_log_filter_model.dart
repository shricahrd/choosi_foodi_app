
import 'food_log_list_model.dart';

class FoodLogFilterMainList{
  late String date;
  List<FoodData>  foodLogFilterList = [];

  FoodLogFilterMainList({required this.date, required this.foodLogFilterList});

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'foodLogFilterList': this.foodLogFilterList,
    };
  }

  factory FoodLogFilterMainList.fromMap(Map<String, dynamic> map) {
    return FoodLogFilterMainList(
      date: map['date'] as String,
      foodLogFilterList: map['foodLogFilterList'] as List<FoodData>,
    );
  }
}