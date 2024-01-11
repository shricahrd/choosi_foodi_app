/// meta : {"msg":"Menu item found successfully","status":true}
/// data : {"menuId":"6294617346f536ddafd15035","menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"],"state":"PENDING","status":"ACTIVE","_id":"6294617346f536ddafd15036","restaurantId":"62945a0746f536ddafd14f9d","dishName":"Da Pizzeria","description":"<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>","price":78,"foodType":"Vegetarian","dishType":"Lunch","dishVisibilityStart":"11:00","dishVisibilityEnd":"23:59","createdAt":1653891443270,"updatedAt":1655790013108,"__v":0,"calories":"67","carbs":"23","fat":"45","protein":"12","id":"6294617346f536ddafd15036"}

class RestMenuViewModel {
  RestMenuViewModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  RestMenuViewModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
RestMenuViewModel copyWith({  Meta? meta,
  Data? data,
}) => RestMenuViewModel(  meta: meta ?? _meta,
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

/// menuId : "6294617346f536ddafd15035"
/// menuImg : ["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"]
/// state : "PENDING"
/// status : "ACTIVE"
/// _id : "6294617346f536ddafd15036"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// dishName : "Da Pizzeria"
/// description : "<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>"
/// price : 78
/// foodType : "Vegetarian"
/// dishType : "Lunch"
/// dishVisibilityStart : "11:00"
/// dishVisibilityEnd : "23:59"
/// createdAt : 1653891443270
/// updatedAt : 1655790013108
/// __v : 0
/// calories : "67"
/// carbs : "23"
/// fat : "45"
/// protein : "12"
/// id : "6294617346f536ddafd15036"

class Data {
  Data({
      String? menuId, 
      List<String>? menuImg,
      List<String>? rootCategoryIds,
      List<String>? categoryIds,
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
    dynamic calories,
    dynamic carbs,
    dynamic fat,
    dynamic protein,}){
    _menuId = menuId;
    _menuImg = menuImg;
    _rootCategoryIds = rootCategoryIds;
    _categoryIds = categoryIds;
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
    _calories = calories;
    _carbs = carbs;
    _fat = fat;
    _protein = protein;

}

  Data.fromJson(dynamic json) {
    _menuId = json['menuId'];
    _menuImg = json['menuImg'] != null ? json['menuImg'].cast<String>() : [];
    _rootCategoryIds = json['rootCategoryIds'] != null ? json['rootCategoryIds'].cast<String>() : [];
    _categoryIds = json['categoryIds'] != null ? json['categoryIds'].cast<String>() : [];
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
    _calories = json['calories'];
    _carbs = json['carbs'];
    _fat = json['fat'];
    _protein = json['protein'];

  }
  String? _menuId;
  List<String>? _menuImg;
  List<String>? _rootCategoryIds;
  List<String>? _categoryIds;
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
  dynamic _calories;
  dynamic _carbs;
  dynamic _fat;
  dynamic _protein;
Data copyWith({  String? menuId,
  List<String>? menuImg,
  List<String>? rootCategoryIds,
  List<String>? categoryIds,
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
  String? calories,
  String? carbs,
  String? fat,
  String? protein,
}) => Data(  menuId: menuId ?? _menuId,
  menuImg: menuImg ?? _menuImg,
  rootCategoryIds: rootCategoryIds ?? _rootCategoryIds,
  categoryIds: categoryIds ?? _categoryIds,
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
  calories: calories ?? _calories,
  carbs: carbs ?? _carbs,
  fat: fat ?? _fat,
  protein: protein ?? _protein,
);
  String? get menuId => _menuId;
  List<String>? get menuImg => _menuImg;
  List<String>? get rootCategoryIds => _rootCategoryIds;
  List<String>? get categoryIds => _categoryIds;
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
  dynamic get calories => _calories;
  dynamic get carbs => _carbs;
  dynamic get fat => _fat;
  dynamic get protein => _protein;

  set setFoodType(String foodtype){
    this._foodType = foodtype;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuId'] = _menuId;
    map['menuImg'] = _menuImg;
    map['rootCategoryIds'] = _rootCategoryIds;
    map['categoryIds'] = _categoryIds;
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
    map['calories'] = _calories;
    map['carbs'] = _carbs;
    map['fat'] = _fat;
    map['protein'] = _protein;
    return map;
  }
}

/// msg : "Menu item found successfully"
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
