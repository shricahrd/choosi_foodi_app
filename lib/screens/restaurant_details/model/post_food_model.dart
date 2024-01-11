
class PostFoodModel{
  String title = '';
  String option = '';

  PostFoodModel({ required this.title, required this.option,});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'option': this.option,
    };
  }

  factory PostFoodModel.fromMap(Map<String, dynamic> map) {
    return PostFoodModel(
      title: map['title'] as String,
      option: map['option'] as String,
    );
  }

  factory PostFoodModel.fromJson(Map<String, dynamic> json) {
    return PostFoodModel(
      title: json["title"],
      option: json["option"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "option": option,
    };
  }
}