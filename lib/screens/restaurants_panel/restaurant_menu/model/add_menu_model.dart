/// meta : {"msg":"Menu item added successfully.","status":true}
/// data : {"menuId":"62c2f048a32e637fa5fb6f45","state":"PENDING","status":"DEACTIVE","_id":"62c2f048a32e637fa5fb6f46","restaurantId":"62945a0746f536ddafd14f9d","dishName":"Cheese Butter masala","description":"Cheese Butter","price":200,"foodType":"Vegan","dishType":"Dinner","dishVisibilityStart":"18:00","dishVisibilityEnd":"23:00","createdAt":1656942664192,"updatedAt":1656942664192,"__v":0,"id":"62c2f048a32e637fa5fb6f46"}

class AddMenuModel {
  AddMenuModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  AddMenuModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
AddMenuModel copyWith({  Meta? meta,
  Data? data,
}) => AddMenuModel(  meta: meta ?? _meta,
  data: data ?? _data,
);
  Meta? get meta => _meta;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// menuId : "62c2f048a32e637fa5fb6f45"
/// state : "PENDING"
/// status : "DEACTIVE"
/// _id : "62c2f048a32e637fa5fb6f46"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// dishName : "Cheese Butter masala"
/// description : "Cheese Butter"
/// price : 200
/// foodType : "Vegan"
/// dishType : "Dinner"
/// dishVisibilityStart : "18:00"
/// dishVisibilityEnd : "23:00"
/// createdAt : 1656942664192
/// updatedAt : 1656942664192
/// __v : 0
/// id : "62c2f048a32e637fa5fb6f46"

class Data {
  Data({
      String? menuId, 
      String? state, 
      String? status, 
      String? id, 
      String? restaurantId, 
      String? dishName, 
      String? description, 
      int? price, 
      String? foodType, 
      String? dishType, 
      String? dishVisibilityStart, 
      String? dishVisibilityEnd, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _menuId = menuId;
    _state = state;
    _status = status;
    _id = id;
    _restaurantId = restaurantId;
    _dishName = dishName;
    _description = description;
    _price = price;
    _foodType = foodType;
    _dishType = dishType;
    _dishVisibilityStart = dishVisibilityStart;
    _dishVisibilityEnd = dishVisibilityEnd;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _menuId = json['menuId'];
    _state = json['state'];
    _status = json['status'];
    _id = json['_id'];
    _restaurantId = json['restaurantId'];
    _dishName = json['dishName'];
    _description = json['description'];
    _price = json['price'];
    _foodType = json['foodType'];
    _dishType = json['dishType'];
    _dishVisibilityStart = json['dishVisibilityStart'];
    _dishVisibilityEnd = json['dishVisibilityEnd'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _menuId;
  String? _state;
  String? _status;
  String? _id;
  String? _restaurantId;
  String? _dishName;
  String? _description;
  int? _price;
  String? _foodType;
  String? _dishType;
  String? _dishVisibilityStart;
  String? _dishVisibilityEnd;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? menuId,
  String? state,
  String? status,
  String? id,
  String? restaurantId,
  String? dishName,
  String? description,
  int? price,
  String? foodType,
  String? dishType,
  String? dishVisibilityStart,
  String? dishVisibilityEnd,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  menuId: menuId ?? _menuId,
  state: state ?? _state,
  status: status ?? _status,
  id: id ?? _id,
  restaurantId: restaurantId ?? _restaurantId,
  dishName: dishName ?? _dishName,
  description: description ?? _description,
  price: price ?? _price,
  foodType: foodType ?? _foodType,
  dishType: dishType ?? _dishType,
  dishVisibilityStart: dishVisibilityStart ?? _dishVisibilityStart,
  dishVisibilityEnd: dishVisibilityEnd ?? _dishVisibilityEnd,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get menuId => _menuId;
  String? get state => _state;
  String? get status => _status;
  String? get id => _id;
  String? get restaurantId => _restaurantId;
  String? get dishName => _dishName;
  String? get description => _description;
  int? get price => _price;
  String? get foodType => _foodType;
  String? get dishType => _dishType;
  String? get dishVisibilityStart => _dishVisibilityStart;
  String? get dishVisibilityEnd => _dishVisibilityEnd;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuId'] = _menuId;
    map['state'] = _state;
    map['status'] = _status;
    map['_id'] = _id;
    map['restaurantId'] = _restaurantId;
    map['dishName'] = _dishName;
    map['description'] = _description;
    map['price'] = _price;
    map['foodType'] = _foodType;
    map['dishType'] = _dishType;
    map['dishVisibilityStart'] = _dishVisibilityStart;
    map['dishVisibilityEnd'] = _dishVisibilityEnd;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "Menu item added successfully."
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