/// meta : {"msg":"Foodi fact list found successfully","status":true}
/// data : [{"foodiFactId":"62d924391e3f093f80470547","status":"ACTIVE","_id":"62d924391e3f093f80470548","title":"noodles","content":"hello","calories":23,"carbs":21,"fat":10,"protein":23,"foodiFactImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/foodiFactImg-logo-1658397882059-942653.jpg","createdAt":1658397753304,"updatedAt":1658397900357,"__v":0}]

class FoodiFactModel {
  FoodiFactModel({
      Meta? meta, 
      List<Data>? data,}){
    _meta = meta;
    _data = data;
}

  FoodiFactModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<Data>? _data;
FoodiFactModel copyWith({  Meta? meta,
  List<Data>? data,
}) => FoodiFactModel(  meta: meta ?? _meta,
  data: data ?? _data,
);
  Meta? get meta => _meta;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// foodiFactId : "62d924391e3f093f80470547"
/// status : "ACTIVE"
/// _id : "62d924391e3f093f80470548"
/// title : "noodles"
/// content : "hello"
/// calories : 23
/// carbs : 21
/// fat : 10
/// protein : 23
/// foodiFactImg : "https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/foodiFactImg-logo-1658397882059-942653.jpg"
/// createdAt : 1658397753304
/// updatedAt : 1658397900357
/// __v : 0

class Data {
  Data({
      String? foodiFactId, 
      String? status, 
      String? id, 
      String? title, 
      String? content, 
      int? calories, 
      int? carbs, 
      int? fat, 
      int? protein, 
      String? foodiFactImg, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _foodiFactId = foodiFactId;
    _status = status;
    _id = id;
    _title = title;
    _content = content;
    _calories = calories;
    _carbs = carbs;
    _fat = fat;
    _protein = protein;
    _foodiFactImg = foodiFactImg;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _foodiFactId = json['foodiFactId'];
    _status = json['status'];
    _id = json['_id'];
    _title = json['title'];
    _content = json['content'];
    _calories = json['calories'];
    _carbs = json['carbs'];
    _fat = json['fat'];
    _protein = json['protein'];
    _foodiFactImg = json['foodiFactImg'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _foodiFactId;
  String? _status;
  String? _id;
  String? _title;
  String? _content;
  int? _calories;
  int? _carbs;
  int? _fat;
  int? _protein;
  String? _foodiFactImg;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? foodiFactId,
  String? status,
  String? id,
  String? title,
  String? content,
  int? calories,
  int? carbs,
  int? fat,
  int? protein,
  String? foodiFactImg,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  foodiFactId: foodiFactId ?? _foodiFactId,
  status: status ?? _status,
  id: id ?? _id,
  title: title ?? _title,
  content: content ?? _content,
  calories: calories ?? _calories,
  carbs: carbs ?? _carbs,
  fat: fat ?? _fat,
  protein: protein ?? _protein,
  foodiFactImg: foodiFactImg ?? _foodiFactImg,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get foodiFactId => _foodiFactId;
  String? get status => _status;
  String? get id => _id;
  String? get title => _title;
  String? get content => _content;
  int? get calories => _calories;
  int? get carbs => _carbs;
  int? get fat => _fat;
  int? get protein => _protein;
  String? get foodiFactImg => _foodiFactImg;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foodiFactId'] = _foodiFactId;
    map['status'] = _status;
    map['_id'] = _id;
    map['title'] = _title;
    map['content'] = _content;
    map['calories'] = _calories;
    map['carbs'] = _carbs;
    map['fat'] = _fat;
    map['protein'] = _protein;
    map['foodiFactImg'] = _foodiFactImg;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "Foodi fact list found successfully"
/// status : true

class Meta {
  Meta({
      String? msg, 
      bool? status,}){
    _msg = msg;
    _status = status;
}

  Meta.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
  }
  String? _msg;
  bool? _status;
Meta copyWith({  String? msg,
  bool? status,
}) => Meta(  msg: msg ?? _msg,
  status: status ?? _status,
);
  String? get msg => _msg;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    return map;
  }

}