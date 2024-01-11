/// meta : {"msg":"Food log list found.","status":true}
/// data : [{"foodLogId":"62d55d4f5ba2f209c0b850ad","status":"ACTIVE","_id":"62d55d4f5ba2f209c0b850ae","restaurantId":"62945a0746f536ddafd14f9d","restaurantName":"New Horizon Restaurant","userId":"629461ef9ba9e2ddb6513ece","userName":"Anwarul","menuId":"6294609846f536ddafd14fff","dishName":"Palak Paneer","menuOrderId":"62d55d4e5ba2f209c0b850a6","selectQuantity":10,"protein":"87","carbs":"76","fat":"54","calories":"56","createdAt":1658150223016,"updatedAt":1658150223016,"__v":0}]

class FoodLogListModel {
  FoodLogListModel({
      Meta? meta, 
      List<FoodData>? data,}){
    _meta = meta;
    _data = data;
}

  FoodLogListModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FoodData.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<FoodData>? _data;
FoodLogListModel copyWith({  Meta? meta,
  List<FoodData>? data,
}) => FoodLogListModel(  meta: meta ?? _meta,
  data: data ?? _data,
);
  Meta? get meta => _meta;
  List<FoodData>? get data => _data;

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

/// foodLogId : "62d55d4f5ba2f209c0b850ad"
/// status : "ACTIVE"
/// _id : "62d55d4f5ba2f209c0b850ae"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// restaurantName : "New Horizon Restaurant"
/// userId : "629461ef9ba9e2ddb6513ece"
/// userName : "Anwarul"
/// menuId : "6294609846f536ddafd14fff"
/// dishName : "Palak Paneer"
/// menuOrderId : "62d55d4e5ba2f209c0b850a6"
/// selectQuantity : 10
/// protein : "87"
/// carbs : "76"
/// fat : "54"
/// calories : "56"
/// createdAt : 1658150223016
/// updatedAt : 1658150223016
/// __v : 0

class FoodData {
  FoodData({
      String? foodLogId, 
      String? status, 
      String? id, 
      String? restaurantId, 
      String? restaurantName, 
      String? userId, 
      String? userName, 
      String? menuId, 
      String? dishName, 
      String? menuOrderId, 
      int? selectQuantity, 
      String? protein, 
      String? carbs, 
      String? fat, 
      String? calories, 
      int? createdAt, 
      int? updatedAt,
      dynamic calclulateCalary = 0.0,
      dynamic calclulateFat = 0.0,
      dynamic calclulateCarbs = 0.0,
      dynamic calclulateProtein = 0.0,
      // bool? itemDelete = false,
      int? v,}){
    _foodLogId = foodLogId;
    _status = status;
    _id = id;
    _restaurantId = restaurantId;
    _restaurantName = restaurantName;
    _userId = userId;
    _userName = userName;
    _menuId = menuId;
    _dishName = dishName;
    _menuOrderId = menuOrderId;
    _selectQuantity = selectQuantity;
    _protein = protein;
    _carbs = carbs;
    _fat = fat;
    _calories = calories;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _calclulateCalary = calclulateCalary;
    _calclulateFat = calclulateFat;
    _calclulateProtein = calclulateProtein;
    _calclulateCarbs = calclulateCarbs;
    _v = v;
}

  FoodData.fromJson(dynamic json) {
    _foodLogId = json['foodLogId'];
    _status = json['status'];
    _id = json['_id'];
    _restaurantId = json['restaurantId'];
    _restaurantName = json['restaurantName'];
    _userId = json['userId'];
    _userName = json['userName'];
    _menuId = json['menuId'];
    _dishName = json['dishName'];
    _menuOrderId = json['menuOrderId'];
    _selectQuantity = json['selectQuantity'];
    _protein = json['protein'];
    _carbs = json['carbs'];
    _fat = json['fat'];
    _calories = json['calories'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _foodLogId;
  String? _status;
  String? _id;
  String? _restaurantId;
  String? _restaurantName;
  String? _userId;
  String? _userName;
  String? _menuId;
  String? _dishName;
  String? _menuOrderId;
  int? _selectQuantity;
  String? _protein;
  String? _carbs;
  String? _fat;
  String? _calories;
  int? _createdAt;
  int? _updatedAt;
  dynamic _calclulateCalary = 0.0;
  dynamic _calclulateFat = 0.0;
  dynamic _calclulateCarbs = 0.0;
  dynamic _calclulateProtein = 0.0;
  int? _v;
  FoodData copyWith({  String? foodLogId,
  String? status,
  String? id,
  String? restaurantId,
  String? restaurantName,
  String? userId,
  String? userName,
  String? menuId,
  String? dishName,
  String? menuOrderId,
  int? selectQuantity,
  String? protein,
  String? carbs,
  String? fat,
  String? calories,
  int? createdAt,
  int? updatedAt,
  dynamic calclulateCalary = 0.0,
  dynamic calclulateFat = 0.0,
  dynamic calclulateCarbs = 0.0,
  dynamic calclulateProtein = 0.0,
  int? v,
}) => FoodData(  foodLogId: foodLogId ?? _foodLogId,
  status: status ?? _status,
  id: id ?? _id,
  restaurantId: restaurantId ?? _restaurantId,
  restaurantName: restaurantName ?? _restaurantName,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  menuId: menuId ?? _menuId,
  dishName: dishName ?? _dishName,
  menuOrderId: menuOrderId ?? _menuOrderId,
  selectQuantity: selectQuantity ?? _selectQuantity,
  protein: protein ?? _protein,
  carbs: carbs ?? _carbs,
  fat: fat ?? _fat,
  calories: calories ?? _calories,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  calclulateCalary: calclulateCalary ?? _calclulateCalary,
  calclulateFat: _calclulateFat ?? _calclulateFat,
  calclulateProtein: calclulateProtein ?? _calclulateProtein,
  calclulateCarbs: calclulateCarbs ?? _calclulateCarbs,
  v: v ?? _v,
);
  String? get foodLogId => _foodLogId;
  String? get status => _status;
  String? get id => _id;
  String? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get menuId => _menuId;
  String? get dishName => _dishName;
  String? get menuOrderId => _menuOrderId;
  int? get selectQuantity => _selectQuantity;
  String? get protein => _protein;
  String? get carbs => _carbs;
  String? get fat => _fat;
  String? get calories => _calories;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  double? get calclulateCalary => _calclulateCalary;
  double? get calclulateCarbs => _calclulateCarbs;
  double? get calclulateProtein => _calclulateProtein;
  double? get calclulateFat => _calclulateFat;
  int? get v => _v;
 /* bool? get itemDelete => _itemDelete;

  set setDelete(bool value){
    this._itemDelete = value;
  }*/

  set setCalories(dynamic value){
    this._calclulateCalary = value;
  }

  set setFat(dynamic value){
    this._calclulateFat = value;
  }
  set setCarbs(dynamic value){
    this._calclulateCarbs = value;
  }
  set setProtein(dynamic value){
    this._calclulateProtein = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foodLogId'] = _foodLogId;
    map['status'] = _status;
    map['_id'] = _id;
    map['restaurantId'] = _restaurantId;
    map['restaurantName'] = _restaurantName;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['menuId'] = _menuId;
    map['dishName'] = _dishName;
    map['menuOrderId'] = _menuOrderId;
    map['selectQuantity'] = _selectQuantity;
    map['protein'] = _protein;
    map['carbs'] = _carbs;
    map['fat'] = _fat;
    map['calories'] = _calories;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    // map['itemDelete'] = itemDelete;
    return map;
  }

}

/// msg : "Food log list found."
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