import 'package:get/get.dart';

import '../../home/model/safe_convert.dart';

/// meta : {"msg":"Restaurant found successfully","status":true}
/// data : {"_id":"62945a0746f536ddafd14f9e","timings":{"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"},"restaurantId":"62945a0746f536ddafd14f9d","restaurantImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-blob-1653889692444-153644"],"deliveryTime":45,"isPickup":true,"isDelivery":true,"ratings":0,"state":"APPROVED","status":"ACTIVE","coordinates":[77.4730653,23.2436838],"restaurantName":"New Horizon Restaurant","distance":598233.5552093196,"menus":[{"_id":"6294609846f536ddafd15000","menuId":"6294609846f536ddafd14fff","menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-Palak%20paneer-1653891243966-393109.jpg"],"state":"PENDING","status":"ACTIVE","restaurantId":"62945a0746f536ddafd14f9d","dishName":"Palak Paneer","description":"<p>In some agencies in the 90 circulated a text called the \"yellow tram\" or \"yellow subway\" sensible replace Lorem Ipsum to give a more modern look to content. But too many people were looking to read the text when it was in French or English, the desired effect was not achieved. Working with readable text, containing directions can cause distractions and this can help to focus on the layout.</p><p>The advantage of Latin origin and nonsense content Lorem ipsum prevents the reader from being distracted by the content of the text and thus can focus its attention on graphic design. Indeed the text Lorem Ipsum has the advantage in contrast to a generic text using variable word length to simulate a normal occupancy of the model so that it matches the final product and to ensure future unaltered publication.</p>","price":200,"foodType":"Vegetarian","dishType":"Lunch","dishVisibilityStart":"23:00","dishVisibilityEnd":"23:59","createdAt":1653891224916,"updatedAt":1653891259614,"__v":0,"calories":"56","carbs":"76","fat":"54","protein":"87"},{"_id":"6294617346f536ddafd15036","menuId":"6294617346f536ddafd15035","menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"],"state":"PENDING","status":"ACTIVE","restaurantId":"62945a0746f536ddafd14f9d","dishName":"Da Pizzeria","description":"<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>","price":78,"foodType":"Vegetarian","dishType":"Lunch","dishVisibilityStart":"11:00","dishVisibilityEnd":"23:59","createdAt":1653891443270,"updatedAt":1655378052441,"__v":0,"calories":"67","carbs":"23","fat":"45","protein":"12"}],"rootCategory":[{"_id":"627b6150c9889116b827db80","categoryId":"627b6150c9889116b827db7f","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Indian","url":"Indian cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.amazonaws.com/categoryImg-Indian%20Cusines-1652253008027-433082.jpg","createdAt":1652253008926,"updatedAt":1652253008926,"__v":0},{"_id":"627b61c4c9889116b827db8d","categoryId":"627b61c4c9889116b827db8c","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Chinese","url":"chinese cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-chinese%20cuisines-1652253123952-887614.jpg","createdAt":1652253124366,"updatedAt":1652253124366,"__v":0},{"_id":"627b6222c9889116b827db9b","categoryId":"627b6222c9889116b827db9a","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Italian","url":"Italian cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Italian%20cuisines-1652253218353-406419.jpg","createdAt":1652253218812,"updatedAt":1652253218812,"__v":0}]}

class RestaurantDetailsModel {
  RestaurantDetailsModel({
      Meta? meta,
      Data? data,}){
    _meta = meta;
    _data = data;
}

  RestaurantDetailsModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
RestaurantDetailsModel copyWith({  Meta? meta,
  Data? data,
}) => RestaurantDetailsModel(  meta: meta ?? _meta,
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

/// _id : "62945a0746f536ddafd14f9e"
/// timings : {"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"}
/// restaurantId : "62945a0746f536ddafd14f9d"
/// restaurantImg : ["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-blob-1653889692444-153644"]
/// deliveryTime : 45
/// isPickup : true
/// isDelivery : true
/// ratings : 0
/// state : "APPROVED"
/// status : "ACTIVE"
/// coordinates : [77.4730653,23.2436838]
/// restaurantName : "New Horizon Restaurant"
/// distance : 598233.5552093196
/// menus : [{"_id":"6294609846f536ddafd15000","menuId":"6294609846f536ddafd14fff","menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-Palak%20paneer-1653891243966-393109.jpg"],"state":"PENDING","status":"ACTIVE","restaurantId":"62945a0746f536ddafd14f9d","dishName":"Palak Paneer","description":"<p>In some agencies in the 90 circulated a text called the \"yellow tram\" or \"yellow subway\" sensible replace Lorem Ipsum to give a more modern look to content. But too many people were looking to read the text when it was in French or English, the desired effect was not achieved. Working with readable text, containing directions can cause distractions and this can help to focus on the layout.</p><p>The advantage of Latin origin and nonsense content Lorem ipsum prevents the reader from being distracted by the content of the text and thus can focus its attention on graphic design. Indeed the text Lorem Ipsum has the advantage in contrast to a generic text using variable word length to simulate a normal occupancy of the model so that it matches the final product and to ensure future unaltered publication.</p>","price":200,"foodType":"Vegetarian","dishType":"Lunch","dishVisibilityStart":"23:00","dishVisibilityEnd":"23:59","createdAt":1653891224916,"updatedAt":1653891259614,"__v":0,"calories":"56","carbs":"76","fat":"54","protein":"87"},{"_id":"6294617346f536ddafd15036","menuId":"6294617346f536ddafd15035","menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"],"state":"PENDING","status":"ACTIVE","restaurantId":"62945a0746f536ddafd14f9d","dishName":"Da Pizzeria","description":"<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>","price":78,"foodType":"Vegetarian","dishType":"Lunch","dishVisibilityStart":"11:00","dishVisibilityEnd":"23:59","createdAt":1653891443270,"updatedAt":1655378052441,"__v":0,"calories":"67","carbs":"23","fat":"45","protein":"12"}]
/// rootCategory : [{"_id":"627b6150c9889116b827db80","categoryId":"627b6150c9889116b827db7f","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Indian","url":"Indian cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.amazonaws.com/categoryImg-Indian%20Cusines-1652253008027-433082.jpg","createdAt":1652253008926,"updatedAt":1652253008926,"__v":0},{"_id":"627b61c4c9889116b827db8d","categoryId":"627b61c4c9889116b827db8c","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Chinese","url":"chinese cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-chinese%20cuisines-1652253123952-887614.jpg","createdAt":1652253124366,"updatedAt":1652253124366,"__v":0},{"_id":"627b6222c9889116b827db9b","categoryId":"627b6222c9889116b827db9a","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Italian","url":"Italian cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Italian%20cuisines-1652253218353-406419.jpg","createdAt":1652253218812,"updatedAt":1652253218812,"__v":0}]

class Data {
  Data({
      String? id,
      Timings? timings,
      String? restaurantId,
      List<String>? restaurantImg,
      int? deliveryTime,
      bool? isPickup,
      bool? isDelivery,
      dynamic ratings,
      String? state,
      String? status,
      List<double>? coordinates,
      String? restaurantName,
      double? distance,
      List<Menus>? menus,
      List<RootCategory>? rootCategory,}){
    _id = id;
    _timings = timings;
    _restaurantId = restaurantId;
    _restaurantImg = restaurantImg;
    _deliveryTime = deliveryTime;
    _isPickup = isPickup;
    _isDelivery = isDelivery;
    _ratings = ratings;
    _state = state;
    _status = status;
    _coordinates = coordinates;
    _restaurantName = restaurantName;
    _distance = distance;
    _menus = menus;
    _rootCategory = rootCategory;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _timings = json['timings'] != null ? Timings.fromJson(json['timings']) : null;
    _restaurantId = json['restaurantId'];
    _restaurantImg = json['restaurantImg'] != null ? json['restaurantImg'].cast<String>() : [];
    _deliveryTime = json['deliveryTime'];
    _isPickup = json['isPickup'];
    _isDelivery = json['isDelivery'];
    _ratings = json['ratings'];
    _state = json['state'];
    _status = json['status'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    _restaurantName = json['restaurantName'];
    _distance = json['distance'];
    if (json['menus'] != null) {
      _menus = [];
      json['menus'].forEach((v) {
        _menus?.add(Menus.fromJson(v));
      });
    }
    if (json['rootCategory'] != null) {
      _rootCategory = [];
      json['rootCategory'].forEach((v) {
        _rootCategory?.add(RootCategory.fromJson(v));
      });
    }
  }
  String? _id;
  Timings? _timings;
  String? _restaurantId;
  List<String>? _restaurantImg;
  int? _deliveryTime;
  bool? _isPickup;
  bool? _isDelivery;
  dynamic _ratings;
  String? _state;
  String? _status;
  List<double>? _coordinates;
  String? _restaurantName;
  double? _distance;
  List<Menus>? _menus;
  List<RootCategory>? _rootCategory;
Data copyWith({  String? id,
  Timings? timings,
  String? restaurantId,
  List<String>? restaurantImg,
  int? deliveryTime,
  bool? isPickup,
  bool? isDelivery,
  int? ratings,
  String? state,
  String? status,
  List<double>? coordinates,
  String? restaurantName,
  double? distance,
  List<Menus>? menus,
  List<RootCategory>? rootCategory,
}) => Data(  id: id ?? _id,
  timings: timings ?? _timings,
  restaurantId: restaurantId ?? _restaurantId,
  restaurantImg: restaurantImg ?? _restaurantImg,
  deliveryTime: deliveryTime ?? _deliveryTime,
  isPickup: isPickup ?? _isPickup,
  isDelivery: isDelivery ?? _isDelivery,
  ratings: ratings ?? _ratings,
  state: state ?? _state,
  status: status ?? _status,
  coordinates: coordinates ?? _coordinates,
  restaurantName: restaurantName ?? _restaurantName,
  distance: distance ?? _distance,
  menus: menus ?? _menus,
  rootCategory: rootCategory ?? _rootCategory,
);
  String? get id => _id;
  Timings? get timings => _timings;
  String? get restaurantId => _restaurantId;
  List<String>? get restaurantImg => _restaurantImg;
  int? get deliveryTime => _deliveryTime;
  bool? get isPickup => _isPickup;
  bool? get isDelivery => _isDelivery;
  dynamic get ratings => _ratings;
  String? get state => _state;
  String? get status => _status;
  List<double>? get coordinates => _coordinates;
  String? get restaurantName => _restaurantName;
  double? get distance => _distance;
  List<Menus>? get menus => _menus;
  List<RootCategory>? get rootCategory => _rootCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_timings != null) {
      map['timings'] = _timings?.toJson();
    }
    map['restaurantId'] = _restaurantId;
    map['restaurantImg'] = _restaurantImg;
    map['deliveryTime'] = _deliveryTime;
    map['isPickup'] = _isPickup;
    map['isDelivery'] = _isDelivery;
    map['ratings'] = _ratings;
    map['state'] = _state;
    map['status'] = _status;
    map['coordinates'] = _coordinates;
    map['restaurantName'] = _restaurantName;
    map['distance'] = _distance;
    if (_menus != null) {
      map['menus'] = _menus?.map((v) => v.toJson()).toList();
    }
    if (_rootCategory != null) {
      map['rootCategory'] = _rootCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "627b6150c9889116b827db80"
/// categoryId : "627b6150c9889116b827db7f"
/// commission : 0
/// status : "ACTIVE"
/// type : "ROOT"
/// isCompare : false
/// isFeaturedWeb : false
/// isCategoryWebNav : false
/// isCategoryMobile : false
/// isCategoryMobileNav : false
/// categoryName : "Indian"
/// url : "Indian cuisine url"
/// tax : 0
/// categoryImg : "https://choosi-foodi-bucket.s3.amazonaws.com/categoryImg-Indian%20Cusines-1652253008027-433082.jpg"
/// createdAt : 1652253008926
/// updatedAt : 1652253008926
/// __v : 0

class RootCategory {
  RootCategory({
      String? id,
      String? categoryId,
      int? commission,
      String? status,
      String? type,
      bool? isCompare,
      bool? isFeaturedWeb,
      bool? isCategoryWebNav,
      bool? isCategoryMobile,
      bool? isCategoryMobileNav,
      String? categoryName,
      String? url,
      int? tax,
      String? categoryImg,
      int? createdAt,
      int? updatedAt,
      int? v,}){
    _id = id;
    _categoryId = categoryId;
    _commission = commission;
    _status = status;
    _type = type;
    _isCompare = isCompare;
    _isFeaturedWeb = isFeaturedWeb;
    _isCategoryWebNav = isCategoryWebNav;
    _isCategoryMobile = isCategoryMobile;
    _isCategoryMobileNav = isCategoryMobileNav;
    _categoryName = categoryName;
    _url = url;
    _tax = tax;
    _categoryImg = categoryImg;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  RootCategory.fromJson(dynamic json) {
    _id = json['_id'];
    _categoryId = json['categoryId'];
    _commission = json['commission'];
    _status = json['status'];
    _type = json['type'];
    _isCompare = json['isCompare'];
    _isFeaturedWeb = json['isFeaturedWeb'];
    _isCategoryWebNav = json['isCategoryWebNav'];
    _isCategoryMobile = json['isCategoryMobile'];
    _isCategoryMobileNav = json['isCategoryMobileNav'];
    _categoryName = json['categoryName'];
    _url = json['url'];
    _tax = json['tax'];
    _categoryImg = json['categoryImg'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _categoryId;
  int? _commission;
  String? _status;
  String? _type;
  bool? _isCompare;
  bool? _isFeaturedWeb;
  bool? _isCategoryWebNav;
  bool? _isCategoryMobile;
  bool? _isCategoryMobileNav;
  String? _categoryName;
  String? _url;
  int? _tax;
  String? _categoryImg;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
RootCategory copyWith({  String? id,
  String? categoryId,
  int? commission,
  String? status,
  String? type,
  bool? isCompare,
  bool? isFeaturedWeb,
  bool? isCategoryWebNav,
  bool? isCategoryMobile,
  bool? isCategoryMobileNav,
  String? categoryName,
  String? url,
  int? tax,
  String? categoryImg,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => RootCategory(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  commission: commission ?? _commission,
  status: status ?? _status,
  type: type ?? _type,
  isCompare: isCompare ?? _isCompare,
  isFeaturedWeb: isFeaturedWeb ?? _isFeaturedWeb,
  isCategoryWebNav: isCategoryWebNav ?? _isCategoryWebNav,
  isCategoryMobile: isCategoryMobile ?? _isCategoryMobile,
  isCategoryMobileNav: isCategoryMobileNav ?? _isCategoryMobileNav,
  categoryName: categoryName ?? _categoryName,
  url: url ?? _url,
  tax: tax ?? _tax,
  categoryImg: categoryImg ?? _categoryImg,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get categoryId => _categoryId;
  int? get commission => _commission;
  String? get status => _status;
  String? get type => _type;
  bool? get isCompare => _isCompare;
  bool? get isFeaturedWeb => _isFeaturedWeb;
  bool? get isCategoryWebNav => _isCategoryWebNav;
  bool? get isCategoryMobile => _isCategoryMobile;
  bool? get isCategoryMobileNav => _isCategoryMobileNav;
  String? get categoryName => _categoryName;
  String? get url => _url;
  int? get tax => _tax;
  String? get categoryImg => _categoryImg;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['categoryId'] = _categoryId;
    map['commission'] = _commission;
    map['status'] = _status;
    map['type'] = _type;
    map['isCompare'] = _isCompare;
    map['isFeaturedWeb'] = _isFeaturedWeb;
    map['isCategoryWebNav'] = _isCategoryWebNav;
    map['isCategoryMobile'] = _isCategoryMobile;
    map['isCategoryMobileNav'] = _isCategoryMobileNav;
    map['categoryName'] = _categoryName;
    map['url'] = _url;
    map['tax'] = _tax;
    map['categoryImg'] = _categoryImg;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// _id : "6294609846f536ddafd15000"
/// menuId : "6294609846f536ddafd14fff"
/// menuImg : ["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-Palak%20paneer-1653891243966-393109.jpg"]
/// state : "PENDING"
/// status : "ACTIVE"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// dishName : "Palak Paneer"
/// description : "<p>In some agencies in the 90 circulated a text called the \"yellow tram\" or \"yellow subway\" sensible replace Lorem Ipsum to give a more modern look to content. But too many people were looking to read the text when it was in French or English, the desired effect was not achieved. Working with readable text, containing directions can cause distractions and this can help to focus on the layout.</p><p>The advantage of Latin origin and nonsense content Lorem ipsum prevents the reader from being distracted by the content of the text and thus can focus its attention on graphic design. Indeed the text Lorem Ipsum has the advantage in contrast to a generic text using variable word length to simulate a normal occupancy of the model so that it matches the final product and to ensure future unaltered publication.</p>"
/// price : 200
/// foodType : "Vegetarian"
/// dishType : "Lunch"
/// dishVisibilityStart : "23:00"
/// dishVisibilityEnd : "23:59"
/// createdAt : 1653891224916
/// updatedAt : 1653891259614
/// __v : 0
/// calories : "56"
/// carbs : "76"
/// fat : "54"
/// protein : "87"

class Menus {
  Menus({
      String? id,
      String? menuId,
      List<String>? menuImg,
      String? state,
      String? status,
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
      dynamic protein,
      int selectQuantity = 0,
      int calclulateCalary = 0,
      bool isAddToCart = false,
      bool isBuyNow = false,
      bool isAddToCartEnable = true,
      bool isAddOnEnable = false,
      List<OtherAddonsItem>? otherAddons,
  }){
    _id = id;
    _menuId = menuId;
    _menuImg = menuImg;
    _state = state;
    _status = status;
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
    _selectQuantity = selectQuantity;
    _isAddToCart = isAddToCart;
    _isBuyNow = isBuyNow;
    _otherAddons = otherAddons;
    _isAddOnEnable = isAddOnEnable;
}

  Menus.fromJson(dynamic json) {
    _id = json['_id'];
    _menuId = json['menuId'];
    _menuImg = json['menuImg'] != null ? json['menuImg'].cast<String>() : [];
    _state = json['state'];
    _status = json['status'];
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
    _selectQuantity = 1;
    _isAddToCart = false;
    _isBuyNow = false;
    _isAddToCartEnable = true;
     // _otherAddons = json['otherAddons'];
    if ( json['otherAddons'].toString().isEmpty || json['otherAddons'] == null) {
      _otherAddons = [];
      _isAddOnEnable = false;
    }else{
      _otherAddons = [];
      json['otherAddons'].forEach((v) {
        _otherAddons?.add(OtherAddonsItem.fromJson(v));
      });
      _isAddOnEnable = true;
      print('_isAddOnEnable: $_isAddOnEnable');
    }


    // if ( json['otherAddons'].toString().isNotEmpty || json['otherAddons'] != null) {
    //   _otherAddons = [];
    //   json['otherAddons'].forEach((v) {
    //     _otherAddons?.add(OtherAddonsItem.fromJson(v));
    //   });
    // }
  }
  String? _id;
  String? _menuId;
  List<String>? _menuImg;
  String? _state;
  String? _status;
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
  int _selectQuantity = 1;
  dynamic _calclulateCalary = 0.0;
  dynamic _calclulateFat = 0.0;
  dynamic _calclulateCarbs = 0.0;
  dynamic _calclulateProtein= 0.0;
  int _calclulatePrice= 0;
  bool _isAddToCart = false;
  bool _isBuyNow = false;
  bool _isAddToCartEnable = true;
  bool _isAddOnEnable = false;
  List<OtherAddonsItem>? _otherAddons=[];

Menus copyWith({  String? id,
  String? menuId,
  List<String>? menuImg,
  String? state,
  String? status,
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
  int? selectQuantity,
  int? calclulateCalary,
  bool? isAddToCart,
  bool? isAddOnEnable,
  List<OtherAddonsItem>? otherAddons,
}) => Menus(  id: id ?? _id,
  menuId: menuId ?? _menuId,
  menuImg: menuImg ?? _menuImg,
  state: state ?? _state,
  status: status ?? _status,
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
  selectQuantity: selectQuantity ?? _selectQuantity,
  calclulateCalary: calclulateCalary ?? _calclulateCalary,
  isAddToCart: isAddToCart ?? _isAddToCart,
  isBuyNow: isBuyNow,
  isAddOnEnable: isAddOnEnable ?? _isAddOnEnable,
  isAddToCartEnable: isAddToCartEnable,
);
  String? get id => _id;
  String? get menuId => _menuId;
  List<String>? get menuImg => _menuImg;
  String? get state => _state;
  String? get status => _status;
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
  int get selectQuantity => _selectQuantity;
  dynamic get calculateCalories => _calclulateCalary;
  dynamic get calculateFat => _calclulateFat;
  dynamic get calculateCarbs => _calclulateCarbs;
  dynamic get calculateProtein => _calclulateProtein;
  dynamic get calculatePrice => _calclulatePrice;
  bool get isAddToCart => _isAddToCart;
  bool get isBuyNow => _isBuyNow;
  bool get isAddOnEnable => _isAddOnEnable;
  bool get isAddToCartEnable => _isAddToCartEnable;
  List<OtherAddonsItem>? get otherAddons => _otherAddons;

  set setAddToCart(bool? isChecked){
    this._isAddToCart = isChecked!;
    print("In Model _isAddToCart   $_isAddToCart");
  }

  set setBuyNow(bool? isChecked){
    this._isBuyNow = isChecked!;
    print("In Model _isBuyNow   $_isAddToCart");
  }

  set setAddToCartEnable(bool? isChecked){
    this._isAddToCartEnable = isChecked!;
    print("In Model _isAddToCartEnable   $_isAddToCartEnable");
  }

  set setQuantity(int selectQuantity){
    this._selectQuantity = selectQuantity;
  }

  set setCalories(dynamic value){
    this._calclulateCalary = value;
    // print("In Model _calories  $_calories");
  }

  set setFat(dynamic value){
    this._calclulateFat = value;
    // print("In Model _fat  $_fat");
  }
  set setCarbs(dynamic value){
    this._calclulateCarbs = value;
    // print("In Model _carbs  $_carbs");
  }
  set setProtein(dynamic value){
    this._calclulateProtein = value;
    // print("In Model _protein  $_protein");
  }

  set setPrice(dynamic value){
    this._calclulatePrice = value;
    // print("In Model _protein  $_protein");
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['menuId'] = _menuId;
    map['menuImg'] = _menuImg;
    map['state'] = _state;
    map['status'] = _status;
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
    map['selectQuantity'] = _selectQuantity;
    map['calclulateCalary'] = _calclulateCalary;
    map['isAddToCart'] = _isAddToCart;
    map['isAddToCartEnable'] = _isAddToCartEnable;
    map['otherAddons'] = _otherAddons;
    return map;
  }

}

/// day : "SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY"
/// openingTime : "11:00"
/// closingTime : "23:59"

class Timings {
  Timings({
      String? day,
      String? openingTime,
      String? closingTime,}){
    _day = day;
    _openingTime = openingTime;
    _closingTime = closingTime;
}

  Timings.fromJson(dynamic json) {
    _day = json['day'];
    _openingTime = json['openingTime'];
    _closingTime = json['closingTime'];
  }
  String? _day;
  String? _openingTime;
  String? _closingTime;
Timings copyWith({  String? day,
  String? openingTime,
  String? closingTime,
}) => Timings(  day: day ?? _day,
  openingTime: openingTime ?? _openingTime,
  closingTime: closingTime ?? _closingTime,
);
  String? get day => _day;
  String? get openingTime => _openingTime;
  String? get closingTime => _closingTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['openingTime'] = _openingTime;
    map['closingTime'] = _closingTime;
    return map;
  }

}

/// msg : "Restaurant found successfully"
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

class OtherAddonsItem {
  final String id;
  final String title;
  final List<OptionsItem>? options;

  OtherAddonsItem({
    this.id = "",
    this.title = "",
     this.options,
  });

  factory OtherAddonsItem.fromJson(Map<String, dynamic>? json) => OtherAddonsItem(
    id: asT<String>(json, '_id'),
    title: asT<String>(json, 'title'),
    options: asT<List>(json, 'options').map((e) => OptionsItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'options': options?.map((e) => e.toJson()),
  };
}

class OptionsItem {
  final String id;
  final String option;
  bool isSelect = false;

  OptionsItem({
    this.id = "",
    this.option = "",
    this.isSelect = false,
  });

  set setCheckedOption(bool? isChecked){
    this.isSelect = isChecked!;
    print("In Model isSelect   $isSelect");
  }

  factory OptionsItem.fromJson(Map<String, dynamic>? json) => OptionsItem(
    id: asT<String>(json, '_id'),
    option: asT<String>(json, 'option'),
    isSelect: asT<bool>(json, 'isSelect'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'option': option,
    'isSelect': isSelect,
  };
}