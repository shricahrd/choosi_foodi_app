/// meta : {"msg":"Restaurant list found successfully","status":true}
/// data : [{"_id":"62945a0746f536ddafd14f9e","timings":{"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"},"restaurantId":"62945a0746f536ddafd14f9d","rootCategoryIds":["627b6150c9889116b827db7f","627b61c4c9889116b827db8c"],"restaurantImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-Snapchat-367761390-1658830835768-630287.jpg"],"deliveryTime":45,"ratings":3.4,"state":"APPROVED","status":"ACTIVE","coordinates":[77.4730653,23.2436838],"restaurantName":"New Horizon Restaurant","rootCategory":[{"categoryName":"Indian"},{"categoryName":"Chinese"}]},{"_id":"62cfecbcf06973e552e25ddc","timings":{"isOpen":false},"restaurantId":"62cfecbcf06973e552e25ddb","rootCategoryIds":[],"restaurantImg":[],"deliveryTime":0,"ratings":0,"state":"PENDING","status":"DEACTIVE","rootCategory":[]},null]

class RestaurantModel {
  RestaurantModel({
    Meta? meta,
    List<RestaurantData>? data,}){
    _meta = meta;
    _data = data;
  }

  RestaurantModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RestaurantData.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<RestaurantData>? _data;
  RestaurantModel copyWith({  Meta? meta,
    List<RestaurantData>? data,
  }) => RestaurantModel(  meta: meta ?? _meta,
    data: data ?? _data,
  );
  Meta? get meta => _meta;
  List<RestaurantData>? get data => _data;

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

/// _id : "62945a0746f536ddafd14f9e"
/// timings : {"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"}
/// restaurantId : "62945a0746f536ddafd14f9d"
/// rootCategoryIds : ["627b6150c9889116b827db7f","627b61c4c9889116b827db8c"]
/// restaurantImg : ["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-Snapchat-367761390-1658830835768-630287.jpg"]
/// deliveryTime : 45
/// ratings : 3.4
/// state : "APPROVED"
/// status : "ACTIVE"
/// coordinates : [77.4730653,23.2436838]
/// restaurantName : "New Horizon Restaurant"
/// rootCategory : [{"categoryName":"Indian"},{"categoryName":"Chinese"}]

class RestaurantData {
  RestaurantData({
    String? id,
    Timings? timings,
    String? restaurantId,
    List<String>? rootCategoryIds,
    List<dynamic>? restaurantImg,
    num? deliveryTime,
    num? ratings,
    num? distance,
    String? state,
    String? status,
    List<num>? coordinates,
    String? restaurantName,
    String? openingTime,
    String? closingTime,
    String? totalDistance,
    List<RootCategory>? rootCategory, String? updateCategoryName,}){
    _id = id;
    _timings = timings;
    _restaurantId = restaurantId;
    _rootCategoryIds = rootCategoryIds;
    _restaurantImg = restaurantImg;
    _deliveryTime = deliveryTime;
    _distance = distance;
    _ratings = ratings;
    _state = state;
    _status = status;
    _coordinates = coordinates;
    _restaurantName = restaurantName;
    _rootCategory = rootCategory;
    _openingTime = openingTime;
    _closingTime = closingTime;
    _totalDistance = totalDistance;
  }

  RestaurantData.fromJson(dynamic json) {
    _id = json['_id'];
    _timings = json['timings'] != null ? Timings.fromJson(json['timings']) : null;
    _restaurantId = json['restaurantId'];
    _rootCategoryIds = json['rootCategoryIds'] != null ? json['rootCategoryIds'].cast<String>() : [];
    _restaurantImg = json['restaurantImg'] != null ? json['restaurantImg'].cast<String>() : [];
    _deliveryTime = json['deliveryTime'];
    _distance = json['distance'];
    _ratings = json['ratings'];
    _state = json['state'];
    _status = json['status'];
     _openingTime = json['openingTime'];
    _closingTime = json['closingTime'];
    _totalDistance = json['totalDistance'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    _restaurantName = json['restaurantName'];
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
  List<String>? _rootCategoryIds;
  List<dynamic>? _restaurantImg;
  num? _deliveryTime;
  num? _distance;
  num? _ratings;
  String? _state;
  String? _status;
  List<num>? _coordinates;
  String? _restaurantName;
  String? _updateCategoryName;
  String? _openingTime;
  String? _closingTime;
  String? _totalDistance;
  List<RootCategory>? _rootCategory;
  RestaurantData copyWith({  String? id,
    Timings? timings,
    String? restaurantId,
    List<String>? rootCategoryIds,
    List<String>? restaurantImg,
    num? deliveryTime,
    num? ratings,
    num? distance,
    String? state,
    String? status,
    List<num>? coordinates,
    String? restaurantName,
    String? updateCategoryName,
    String? openingTime,
    String? totalDistance,
    String? closingTime,
    List<RootCategory>? rootCategory,
  }) => RestaurantData(  id: id ?? _id,
    timings: timings ?? _timings,
    restaurantId: restaurantId ?? _restaurantId,
    rootCategoryIds: rootCategoryIds ?? _rootCategoryIds,
    restaurantImg: restaurantImg ?? _restaurantImg,
    deliveryTime: deliveryTime ?? _deliveryTime,
    distance: distance ?? _distance,
    ratings: ratings ?? _ratings,
    state: state ?? _state,
    status: status ?? _status,
    coordinates: coordinates ?? _coordinates,
    restaurantName: restaurantName ?? _restaurantName,
    updateCategoryName: updateCategoryName ?? _updateCategoryName,
    rootCategory: rootCategory ?? _rootCategory,
    openingTime: openingTime ?? _openingTime,
    closingTime: closingTime ?? _closingTime,
    totalDistance: totalDistance ?? _totalDistance,
  );
  String? get id => _id;
  Timings? get timings => _timings;
  String? get restaurantId => _restaurantId;
  List<String>? get rootCategoryIds => _rootCategoryIds;
  List<dynamic>? get restaurantImg => _restaurantImg;
  num? get deliveryTime => _deliveryTime;
  num? get distance => _distance;
  num? get ratings => _ratings;
  String? get state => _state;
  String? get status => _status;
  List<num>? get coordinates => _coordinates;
  String? get restaurantName => _restaurantName;
  String? get updateCategoryName => _updateCategoryName;
  String? get closingTime => _closingTime;
  String? get openingTime => _openingTime;
  String? get totalDistance => _totalDistance;
  List<RootCategory>? get rootCategory => _rootCategory;

  set setCategoryName(dynamic value){
    this._updateCategoryName = value;
  }

  set setOpeningTime(dynamic value){
    this._openingTime = value;
  }

  set setClosingTime(dynamic value){
    this._closingTime = value;
  }

  set setTotalDistance(dynamic value){
    this._totalDistance = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_timings != null) {
      map['timings'] = _timings?.toJson();
    }
    map['restaurantId'] = _restaurantId;
    map['rootCategoryIds'] = _rootCategoryIds;
    map['restaurantImg'] = _restaurantImg;
    map['deliveryTime'] = _deliveryTime;
    map['distance'] = _distance;
    map['ratings'] = _ratings;
    map['state'] = _state;
    map['status'] = _status;
    map['coordinates'] = _coordinates;
    map['restaurantName'] = _restaurantName;
    map['openingTime'] = _openingTime;
    map['closingTime'] = _closingTime;
    map['totalDistance'] = _totalDistance;
    map['updateCategoryName'] = _updateCategoryName;
    if (_rootCategory != null) {
      map['rootCategory'] = _rootCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// categoryName : "Indian"

class RootCategory {
  RootCategory({
    String? categoryName,}){
    _categoryName = categoryName;
  }

  RootCategory.fromJson(dynamic json) {
    _categoryName = json['categoryName'];
  }
  String? _categoryName;
  RootCategory copyWith({  String? categoryName,
  }) => RootCategory(  categoryName: categoryName ?? _categoryName,
  );
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = _categoryName;
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
    String? closingTime,
    bool? isOpen}){
    _day = day;
    _openingTime = openingTime;
    _closingTime = closingTime;
    _isOpen = isOpen;
  }

  Timings.fromJson(dynamic json) {
    _day = json['day'];
    _openingTime = json['openingTime'];
    _closingTime = json['closingTime'];
    _isOpen = json['isOpen'];
  }
  String? _day;
  String? _openingTime;
  String? _closingTime;
  bool? _isOpen;
  Timings copyWith({  String? day,
    String? openingTime,
    String? closingTime,
    bool? isOpen,
  }) => Timings(  day: day ?? _day,
    openingTime: openingTime ?? _openingTime,
    closingTime: closingTime ?? _closingTime,
    isOpen: isOpen ?? _isOpen,
  );
  String? get day => _day;
  String? get openingTime => _openingTime;
  String? get closingTime => _closingTime;
  bool? get isOpen => _isOpen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['openingTime'] = _openingTime;
    map['closingTime'] = _closingTime;
    map['isOpen'] = _isOpen;
    return map;
  }

}

/// msg : "Restaurant list found successfully"
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