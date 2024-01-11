/// meta : {"msg":"Successfully get Vendor profile","status":true}
/// data : {"vendorId":"629459df46f536ddafd14f98","vendorDocument":["https://choosi-foodi-bucket.s3.amazonaws.com/vendorDocument-HGR27532140227E9G-1653889542698-721894.pdf"],"vendorImg":["https://choosi-foodi-bucket.s3.amazonaws.com/vendorImg-about-img%20-%20Copy-1653889542683-393245.png"],"otpVerified":true,"isLogin":true,"isAddedByAdmin":false,"isSignupComplete":true,"state":"PENDING","status":"ACTIVE","_id":"629459db19e22e36fcce42cc","mobile":"7491929040","__v":1,"createdAt":1653889499039,"mobileOtp":1234,"updatedAt":1655784882831,"email":"anwarul@test.com","vendorName":"Anwarul Haque","restaurantId":"62945a0746f536ddafd14f9d","restaurant":{"bankInformation":{"bankName":"State Bank Of India","branchName":"Piplani","accountNumber":"0987654321","holderName":"Anwarul Haque","abaNumber":"ABA0987","routingNumber":"R778"},"timings":{"isOpen":false,"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"},"restaurantId":"62945a0746f536ddafd14f9d","menuIds":["6294609846f536ddafd14fff","6294617346f536ddafd15035"],"isAssigned":false,"isAssignedToHotel":false,"priceForTwo":0,"rootCategoryIds":["627b6150c9889116b827db7f","627b61c4c9889116b827db8c","627b6222c9889116b827db9a"],"categoryIds":["627b68dbc9889116b827dd6d","627b6924c9889116b827dd99","627b67c0c9889116b827dd0b"],"foodTypes":["Vegetarian","Vegan","Pescatarian","Keto"],"restaurantImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-blob-1653889692444-153644"],"isTakeAway":false,"isChatRoom":false,"isShop":false,"isOffers":false,"otpVerified":false,"isLogin":false,"isAddedByAdmin":false,"isSignupComplete":true,"isProfileComplete":true,"deliveryTime":45,"isPickup":true,"isDelivery":true,"ratings":0,"state":"APPROVED","status":"ACTIVE","_id":"62945a0746f536ddafd14f9e","vendorId":"629459df46f536ddafd14f98","mobile":7491929040,"vendorName":"Anwarul Haque","email":"anwarul@test.com","createdAt":1653889543224,"updatedAt":1655377677086,"__v":0,"coordinates":[77.4730653,23.2436838],"managerMobile":"6264240632","managerName":"Anwarul Haque","restaurantAddress":"Piplani, BHEL, Bhopal, Madhya Pradesh 462022, India","restaurantName":"New Horizon Restaurant"},"id":"629459db19e22e36fcce42cc"}

class VendorProfileModel {
  VendorProfileModel({
      Meta? meta, 
      Data? data,
      int? reviewCount}){
    _meta = meta;
    _data = data;
    _reviewCount = reviewCount;
}

  VendorProfileModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _reviewCount =  json['reviewCount'];
  }
  Meta? _meta;
  Data? _data;
  int? _reviewCount;
VendorProfileModel copyWith({  Meta? meta,
  Data? data,
}) => VendorProfileModel(  meta: meta ?? _meta,
  data: data ?? _data,
  reviewCount: reviewCount ?? _reviewCount,
);
  Meta? get meta => _meta;
  Data? get data => _data;
  int? get reviewCount => _reviewCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['reviewCount'] = _reviewCount;
    return map;
  }

}

/// vendorId : "629459df46f536ddafd14f98"
/// vendorDocument : ["https://choosi-foodi-bucket.s3.amazonaws.com/vendorDocument-HGR27532140227E9G-1653889542698-721894.pdf"]
/// vendorImg : ["https://choosi-foodi-bucket.s3.amazonaws.com/vendorImg-about-img%20-%20Copy-1653889542683-393245.png"]
/// otpVerified : true
/// isLogin : true
/// isAddedByAdmin : false
/// isSignupComplete : true
/// state : "PENDING"
/// status : "ACTIVE"
/// _id : "629459db19e22e36fcce42cc"
/// mobile : "7491929040"
/// __v : 1
/// createdAt : 1653889499039
/// mobileOtp : 1234
/// updatedAt : 1655784882831
/// email : "anwarul@test.com"
/// vendorName : "Anwarul Haque"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// restaurant : {"bankInformation":{"bankName":"State Bank Of India","branchName":"Piplani","accountNumber":"0987654321","holderName":"Anwarul Haque","abaNumber":"ABA0987","routingNumber":"R778"},"timings":{"isOpen":false,"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"},"restaurantId":"62945a0746f536ddafd14f9d","menuIds":["6294609846f536ddafd14fff","6294617346f536ddafd15035"],"isAssigned":false,"isAssignedToHotel":false,"priceForTwo":0,"rootCategoryIds":["627b6150c9889116b827db7f","627b61c4c9889116b827db8c","627b6222c9889116b827db9a"],"categoryIds":["627b68dbc9889116b827dd6d","627b6924c9889116b827dd99","627b67c0c9889116b827dd0b"],"foodTypes":["Vegetarian","Vegan","Pescatarian","Keto"],"restaurantImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-blob-1653889692444-153644"],"isTakeAway":false,"isChatRoom":false,"isShop":false,"isOffers":false,"otpVerified":false,"isLogin":false,"isAddedByAdmin":false,"isSignupComplete":true,"isProfileComplete":true,"deliveryTime":45,"isPickup":true,"isDelivery":true,"ratings":0,"state":"APPROVED","status":"ACTIVE","_id":"62945a0746f536ddafd14f9e","vendorId":"629459df46f536ddafd14f98","mobile":7491929040,"vendorName":"Anwarul Haque","email":"anwarul@test.com","createdAt":1653889543224,"updatedAt":1655377677086,"__v":0,"coordinates":[77.4730653,23.2436838],"managerMobile":"6264240632","managerName":"Anwarul Haque","restaurantAddress":"Piplani, BHEL, Bhopal, Madhya Pradesh 462022, India","restaurantName":"New Horizon Restaurant"}
/// id : "629459db19e22e36fcce42cc"

class Data {
  Data({
      String? vendorId, 
      List<String>? vendorDocument, 
      List<String>? vendorImg, 
      bool? otpVerified, 
      bool? isLogin, 
      bool? isAddedByAdmin, 
      bool? isSignupComplete, 
      String? state, 
      String? status, 
      String? id, 
      String? mobile, 
      int? v, 
      int? createdAt, 
      int? mobileOtp, 
      int? updatedAt, 
      String? email, 
      String? vendorName, 
      String? restaurantId, 
      Restaurant? restaurant,}){
    _vendorId = vendorId;
    _vendorDocument = vendorDocument;
    _vendorImg = vendorImg;
    _otpVerified = otpVerified;
    _isLogin = isLogin;
    _isAddedByAdmin = isAddedByAdmin;
    _isSignupComplete = isSignupComplete;
    _state = state;
    _status = status;
    _id = id;
    _mobile = mobile;
    _v = v;
    _createdAt = createdAt;
    _mobileOtp = mobileOtp;
    _updatedAt = updatedAt;
    _email = email;
    _vendorName = vendorName;
    _restaurantId = restaurantId;
    _restaurant = restaurant;
}

  Data.fromJson(dynamic json) {
    _vendorId = json['vendorId'];
    _vendorDocument = json['vendorDocument'] != null ? json['vendorDocument'].cast<String>() : [];
    _vendorImg = json['vendorImg'] != null ? json['vendorImg'].cast<String>() : [];
    _otpVerified = json['otpVerified'];
    _isLogin = json['isLogin'];
    _isAddedByAdmin = json['isAddedByAdmin'];
    _isSignupComplete = json['isSignupComplete'];
    _state = json['state'];
    _status = json['status'];
    _mobile = json['mobile'];
    _v = json['__v'];
    _createdAt = json['createdAt'];
    _mobileOtp = json['mobileOtp'];
    _updatedAt = json['updatedAt'];
    _email = json['email'];
    _vendorName = json['vendorName'];
    _restaurantId = json['restaurantId'];
    _restaurant = json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null;
    _id = json['id'];
  }
  String? _vendorId;
  List<String>? _vendorDocument;
  List<String>? _vendorImg;
  bool? _otpVerified;
  bool? _isLogin;
  bool? _isAddedByAdmin;
  bool? _isSignupComplete;
  String? _state;
  String? _status;
  String? _id;
  String? _mobile;
  int? _v;
  int? _createdAt;
  int? _mobileOtp;
  int? _updatedAt;
  String? _email;
  String? _vendorName;
  String? _restaurantId;
  Restaurant? _restaurant;
Data copyWith({  String? vendorId,
  List<String>? vendorDocument,
  List<String>? vendorImg,
  bool? otpVerified,
  bool? isLogin,
  bool? isAddedByAdmin,
  bool? isSignupComplete,
  String? state,
  String? status,
  String? id,
  String? mobile,
  int? v,
  int? createdAt,
  int? mobileOtp,
  int? updatedAt,
  String? email,
  String? vendorName,
  String? restaurantId,
  Restaurant? restaurant,
}) => Data(  vendorId: vendorId ?? _vendorId,
  vendorDocument: vendorDocument ?? _vendorDocument,
  vendorImg: vendorImg ?? _vendorImg,
  otpVerified: otpVerified ?? _otpVerified,
  isLogin: isLogin ?? _isLogin,
  isAddedByAdmin: isAddedByAdmin ?? _isAddedByAdmin,
  isSignupComplete: isSignupComplete ?? _isSignupComplete,
  state: state ?? _state,
  status: status ?? _status,
  id: id ?? _id,
  mobile: mobile ?? _mobile,
  v: v ?? _v,
  createdAt: createdAt ?? _createdAt,
  mobileOtp: mobileOtp ?? _mobileOtp,
  updatedAt: updatedAt ?? _updatedAt,
  email: email ?? _email,
  vendorName: vendorName ?? _vendorName,
  restaurantId: restaurantId ?? _restaurantId,
  restaurant: restaurant ?? _restaurant,
);
  String? get vendorId => _vendorId;
  List<String>? get vendorDocument => _vendorDocument;
  List<String>? get vendorImg => _vendorImg;
  bool? get otpVerified => _otpVerified;
  bool? get isLogin => _isLogin;
  bool? get isAddedByAdmin => _isAddedByAdmin;
  bool? get isSignupComplete => _isSignupComplete;
  String? get state => _state;
  String? get status => _status;
  String? get id => _id;
  String? get mobile => _mobile;
  int? get v => _v;
  int? get createdAt => _createdAt;
  int? get mobileOtp => _mobileOtp;
  int? get updatedAt => _updatedAt;
  String? get email => _email;
  String? get vendorName => _vendorName;
  String? get restaurantId => _restaurantId;
  Restaurant? get restaurant => _restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorId'] = _vendorId;
    map['vendorDocument'] = _vendorDocument;
    map['vendorImg'] = _vendorImg;
    map['otpVerified'] = _otpVerified;
    map['isLogin'] = _isLogin;
    map['isAddedByAdmin'] = _isAddedByAdmin;
    map['isSignupComplete'] = _isSignupComplete;
    map['state'] = _state;
    map['status'] = _status;
    map['mobile'] = _mobile;
    map['__v'] = _v;
    map['createdAt'] = _createdAt;
    map['mobileOtp'] = _mobileOtp;
    map['updatedAt'] = _updatedAt;
    map['email'] = _email;
    map['vendorName'] = _vendorName;
    map['restaurantId'] = _restaurantId;
    if (_restaurant != null) {
      map['restaurant'] = _restaurant?.toJson();
    }
    map['id'] = _id;
    return map;
  }

}

/// bankInformation : {"bankName":"State Bank Of India","branchName":"Piplani","accountNumber":"0987654321","holderName":"Anwarul Haque","abaNumber":"ABA0987","routingNumber":"R778"}
/// timings : {"isOpen":false,"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"}
/// restaurantId : "62945a0746f536ddafd14f9d"
/// menuIds : ["6294609846f536ddafd14fff","6294617346f536ddafd15035"]
/// isAssigned : false
/// isAssignedToHotel : false
/// priceForTwo : 0
/// rootCategoryIds : ["627b6150c9889116b827db7f","627b61c4c9889116b827db8c","627b6222c9889116b827db9a"]
/// categoryIds : ["627b68dbc9889116b827dd6d","627b6924c9889116b827dd99","627b67c0c9889116b827dd0b"]
/// foodTypes : ["Vegetarian","Vegan","Pescatarian","Keto"]
/// restaurantImg : ["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/restaurantImg-blob-1653889692444-153644"]
/// isTakeAway : false
/// isChatRoom : false
/// isShop : false
/// isOffers : false
/// otpVerified : false
/// isLogin : false
/// isAddedByAdmin : false
/// isSignupComplete : true
/// isProfileComplete : true
/// deliveryTime : 45
/// isPickup : true
/// isDelivery : true
/// ratings : 0
/// state : "APPROVED"
/// status : "ACTIVE"
/// _id : "62945a0746f536ddafd14f9e"
/// vendorId : "629459df46f536ddafd14f98"
/// mobile : 7491929040
/// vendorName : "Anwarul Haque"
/// email : "anwarul@test.com"
/// createdAt : 1653889543224
/// updatedAt : 1655377677086
/// __v : 0
/// coordinates : [77.4730653,23.2436838]
/// managerMobile : "6264240632"
/// managerName : "Anwarul Haque"
/// restaurantAddress : "Piplani, BHEL, Bhopal, Madhya Pradesh 462022, India"
/// restaurantName : "New Horizon Restaurant"

class Restaurant {
  Restaurant({
      BankInformation? bankInformation, 
      Timings? timings, 
      String? restaurantId, 
      List<String>? menuIds, 
      bool? isAssigned, 
      bool? isAssignedToHotel, 
      int? priceForTwo, 
      List<String>? rootCategoryIds, 
      List<String>? categoryIds, 
      List<String>? foodTypes, 
      List<String>? restaurantImg, 
      List<String>? restaurantDocument,
      bool? isTakeAway,
      bool? isChatRoom, 
      bool? isShop, 
      bool? isOffers, 
      bool? otpVerified, 
      bool? isLogin, 
      bool? isAddedByAdmin, 
      bool? isSignupComplete, 
      bool? isProfileComplete, 
      int? deliveryTime, 
      bool? isPickup, 
      bool? isDelivery,
      dynamic ratings,
      String? state, 
      String? status, 
      String? id, 
      String? vendorId, 
      int? mobile, 
      String? vendorName, 
      String? email, 
      int? createdAt, 
      int? updatedAt, 
      int? v, 
      List<double>? coordinates, 
      String? managerMobile, 
      String? managerName, 
      String? restaurantAddress, 
      String? restaurantName,
      dynamic restaurantNumber,}){
    _bankInformation = bankInformation;
    _timings = timings;
    _restaurantId = restaurantId;
    _menuIds = menuIds;
    _isAssigned = isAssigned;
    _isAssignedToHotel = isAssignedToHotel;
    _priceForTwo = priceForTwo;
    _rootCategoryIds = rootCategoryIds;
    _categoryIds = categoryIds;
    _foodTypes = foodTypes;
    _restaurantImg = restaurantImg;
    _restaurantDocument = restaurantDocument;
    _isTakeAway = isTakeAway;
    _isChatRoom = isChatRoom;
    _isShop = isShop;
    _isOffers = isOffers;
    _otpVerified = otpVerified;
    _isLogin = isLogin;
    _isAddedByAdmin = isAddedByAdmin;
    _isSignupComplete = isSignupComplete;
    _isProfileComplete = isProfileComplete;
    _deliveryTime = deliveryTime;
    _isPickup = isPickup;
    _isDelivery = isDelivery;
    _ratings = ratings;
    _state = state;
    _status = status;
    _id = id;
    _vendorId = vendorId;
    _mobile = mobile;
    _vendorName = vendorName;
    _email = email;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _coordinates = coordinates;
    _managerMobile = managerMobile;
    _managerName = managerName;
    _restaurantAddress = restaurantAddress;
    _restaurantName = restaurantName;
    _restaurantNumber = restaurantNumber;
}

  Restaurant.fromJson(dynamic json) {
    _bankInformation = json['bankInformation'] != null ? BankInformation.fromJson(json['bankInformation']) : null;
    _timings = json['timings'] != null ? Timings.fromJson(json['timings']) : null;
    _restaurantId = json['restaurantId'];
    _menuIds = json['menuIds'] != null ? json['menuIds'].cast<String>() : [];
    _isAssigned = json['isAssigned'];
    _isAssignedToHotel = json['isAssignedToHotel'];
    _priceForTwo = json['priceForTwo'];
    _rootCategoryIds = json['rootCategoryIds'] != null ? json['rootCategoryIds'].cast<String>() : [];
    _categoryIds = json['categoryIds'] != null ? json['categoryIds'].cast<String>() : [];
    _foodTypes = json['foodTypes'] != null ? json['foodTypes'].cast<String>() : [];
    _restaurantImg = json['restaurantImg'] != null ? json['restaurantImg'].cast<String>() : [];
    _restaurantDocument = json['restaurantDocument'] != null ? json['restaurantDocument'].cast<String>() : [];
    _isTakeAway = json['isTakeAway'];
    _isChatRoom = json['isChatRoom'];
    _isShop = json['isShop'];
    _isOffers = json['isOffers'];
    _otpVerified = json['otpVerified'];
    _isLogin = json['isLogin'];
    _isAddedByAdmin = json['isAddedByAdmin'];
    _isSignupComplete = json['isSignupComplete'];
    _isProfileComplete = json['isProfileComplete'];
    _deliveryTime = json['deliveryTime'];
    _isPickup = json['isPickup'];
    _isDelivery = json['isDelivery'];
    _ratings = json['ratings'];
    _state = json['state'];
    _status = json['status'];
    _id = json['_id'];
    _vendorId = json['vendorId'];
    _mobile = json['mobile'];
    _vendorName = json['vendorName'];
    _email = json['email'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    _managerMobile = json['managerMobile'];
    _managerName = json['managerName'];
    _restaurantAddress = json['restaurantAddress'];
    _restaurantName = json['restaurantName'];
    _restaurantNumber = json['restaurantNumber'];
  }
  BankInformation? _bankInformation;
  Timings? _timings;
  String? _restaurantId;
  List<String>? _menuIds;
  bool? _isAssigned;
  bool? _isAssignedToHotel;
  int? _priceForTwo;
  List<String>? _rootCategoryIds;
  List<String>? _categoryIds;
  List<String>? _foodTypes;
  List<String>? _restaurantImg;
  List<String>? _restaurantDocument;
  bool? _isTakeAway;
  bool? _isChatRoom;
  bool? _isShop;
  bool? _isOffers;
  bool? _otpVerified;
  bool? _isLogin;
  bool? _isAddedByAdmin;
  bool? _isSignupComplete;
  bool? _isProfileComplete;
  int? _deliveryTime;
  bool? _isPickup;
  bool? _isDelivery;
  dynamic _ratings;
  String? _state;
  String? _status;
  String? _id;
  String? _vendorId;
  int? _mobile;
  String? _vendorName;
  String? _email;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
  List<double>? _coordinates;
  String? _managerMobile;
  String? _managerName;
  String? _restaurantAddress;
  String? _restaurantName;
  dynamic _restaurantNumber;
Restaurant copyWith({  BankInformation? bankInformation,
  Timings? timings,
  String? restaurantId,
  List<String>? menuIds,
  bool? isAssigned,
  bool? isAssignedToHotel,
  int? priceForTwo,
  List<String>? rootCategoryIds,
  List<String>? categoryIds,
  List<String>? foodTypes,
  List<String>? restaurantImg,
  List<String>? restaurantDocument,
  bool? isTakeAway,
  bool? isChatRoom,
  bool? isShop,
  bool? isOffers,
  bool? otpVerified,
  bool? isLogin,
  bool? isAddedByAdmin,
  bool? isSignupComplete,
  bool? isProfileComplete,
  int? deliveryTime,
  bool? isPickup,
  bool? isDelivery,
  int? ratings,
  String? state,
  String? status,
  String? id,
  String? vendorId,
  int? mobile,
  String? vendorName,
  String? email,
  int? createdAt,
  int? updatedAt,
  int? v,
  List<double>? coordinates,
  String? managerMobile,
  String? managerName,
  String? restaurantAddress,
  String? restaurantName,
  dynamic restaurantNumber,
}) => Restaurant(  bankInformation: bankInformation ?? _bankInformation,
  timings: timings ?? _timings,
  restaurantId: restaurantId ?? _restaurantId,
  menuIds: menuIds ?? _menuIds,
  isAssigned: isAssigned ?? _isAssigned,
  isAssignedToHotel: isAssignedToHotel ?? _isAssignedToHotel,
  priceForTwo: priceForTwo ?? _priceForTwo,
  rootCategoryIds: rootCategoryIds ?? _rootCategoryIds,
  categoryIds: categoryIds ?? _categoryIds,
  foodTypes: foodTypes ?? _foodTypes,
  restaurantImg: restaurantImg ?? _restaurantImg,
  restaurantDocument: restaurantDocument ?? _restaurantDocument,
  isTakeAway: isTakeAway ?? _isTakeAway,
  isChatRoom: isChatRoom ?? _isChatRoom,
  isShop: isShop ?? _isShop,
  isOffers: isOffers ?? _isOffers,
  otpVerified: otpVerified ?? _otpVerified,
  isLogin: isLogin ?? _isLogin,
  isAddedByAdmin: isAddedByAdmin ?? _isAddedByAdmin,
  isSignupComplete: isSignupComplete ?? _isSignupComplete,
  isProfileComplete: isProfileComplete ?? _isProfileComplete,
  deliveryTime: deliveryTime ?? _deliveryTime,
  isPickup: isPickup ?? _isPickup,
  isDelivery: isDelivery ?? _isDelivery,
  ratings: ratings ?? _ratings,
  state: state ?? _state,
  status: status ?? _status,
  id: id ?? _id,
  vendorId: vendorId ?? _vendorId,
  mobile: mobile ?? _mobile,
  vendorName: vendorName ?? _vendorName,
  email: email ?? _email,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  coordinates: coordinates ?? _coordinates,
  managerMobile: managerMobile ?? _managerMobile,
  managerName: managerName ?? _managerName,
  restaurantAddress: restaurantAddress ?? _restaurantAddress,
  restaurantName: restaurantName ?? _restaurantName,
  restaurantNumber: restaurantNumber ?? _restaurantNumber,
);
  BankInformation? get bankInformation => _bankInformation;
  Timings? get timings => _timings;
  String? get restaurantId => _restaurantId;
  List<String>? get menuIds => _menuIds;
  bool? get isAssigned => _isAssigned;
  bool? get isAssignedToHotel => _isAssignedToHotel;
  int? get priceForTwo => _priceForTwo;
  List<String>? get rootCategoryIds => _rootCategoryIds;
  List<String>? get categoryIds => _categoryIds;
  List<String>? get foodTypes => _foodTypes;
  List<String>? get restaurantImg => _restaurantImg;
  List<String>? get restaurantDocument => _restaurantDocument;
  bool? get isTakeAway => _isTakeAway;
  bool? get isChatRoom => _isChatRoom;
  bool? get isShop => _isShop;
  bool? get isOffers => _isOffers;
  bool? get otpVerified => _otpVerified;
  bool? get isLogin => _isLogin;
  bool? get isAddedByAdmin => _isAddedByAdmin;
  bool? get isSignupComplete => _isSignupComplete;
  bool? get isProfileComplete => _isProfileComplete;
  int? get deliveryTime => _deliveryTime;
  bool? get isPickup => _isPickup;
  bool? get isDelivery => _isDelivery;
  dynamic get ratings => _ratings;
  String? get state => _state;
  String? get status => _status;
  String? get id => _id;
  String? get vendorId => _vendorId;
  int? get mobile => _mobile;
  String? get vendorName => _vendorName;
  String? get email => _email;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;
  List<double>? get coordinates => _coordinates;
  String? get managerMobile => _managerMobile;
  String? get managerName => _managerName;
  String? get restaurantAddress => _restaurantAddress;
  String? get restaurantName => _restaurantName;
  dynamic get restaurantNumber => _restaurantNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bankInformation != null) {
      map['bankInformation'] = _bankInformation?.toJson();
    }
    if (_timings != null) {
      map['timings'] = _timings?.toJson();
    }
    map['restaurantId'] = _restaurantId;
    map['menuIds'] = _menuIds;
    map['isAssigned'] = _isAssigned;
    map['isAssignedToHotel'] = _isAssignedToHotel;
    map['priceForTwo'] = _priceForTwo;
    map['rootCategoryIds'] = _rootCategoryIds;
    map['categoryIds'] = _categoryIds;
    map['foodTypes'] = _foodTypes;
    map['restaurantImg'] = _restaurantImg;
    map['restaurantDocument'] = _restaurantDocument;
    map['isTakeAway'] = _isTakeAway;
    map['isChatRoom'] = _isChatRoom;
    map['isShop'] = _isShop;
    map['isOffers'] = _isOffers;
    map['otpVerified'] = _otpVerified;
    map['isLogin'] = _isLogin;
    map['isAddedByAdmin'] = _isAddedByAdmin;
    map['isSignupComplete'] = _isSignupComplete;
    map['isProfileComplete'] = _isProfileComplete;
    map['deliveryTime'] = _deliveryTime;
    map['isPickup'] = _isPickup;
    map['isDelivery'] = _isDelivery;
    map['ratings'] = _ratings;
    map['state'] = _state;
    map['status'] = _status;
    map['_id'] = _id;
    map['vendorId'] = _vendorId;
    map['mobile'] = _mobile;
    map['vendorName'] = _vendorName;
    map['email'] = _email;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['coordinates'] = _coordinates;
    map['managerMobile'] = _managerMobile;
    map['managerName'] = _managerName;
    map['restaurantAddress'] = _restaurantAddress;
    map['restaurantName'] = _restaurantName;
    map['restaurantNumber'] = _restaurantNumber;
    return map;
  }

}

/// isOpen : false
/// day : "SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY"
/// openingTime : "11:00"
/// closingTime : "23:59"

class Timings {
  Timings({
      bool? isOpen, 
      String? day, 
      String? openingTime, 
      String? closingTime,}){
    _isOpen = isOpen;
    _day = day;
    _openingTime = openingTime;
    _closingTime = closingTime;
}

  Timings.fromJson(dynamic json) {
    _isOpen = json['isOpen'];
    _day = json['day'];
    _openingTime = json['openingTime'];
    _closingTime = json['closingTime'];
  }
  bool? _isOpen;
  String? _day;
  String? _openingTime;
  String? _closingTime;
Timings copyWith({  bool? isOpen,
  String? day,
  String? openingTime,
  String? closingTime,
}) => Timings(  isOpen: isOpen ?? _isOpen,
  day: day ?? _day,
  openingTime: openingTime ?? _openingTime,
  closingTime: closingTime ?? _closingTime,
);
  bool? get isOpen => _isOpen;
  String? get day => _day;
  String? get openingTime => _openingTime;
  String? get closingTime => _closingTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isOpen'] = _isOpen;
    map['day'] = _day;
    map['openingTime'] = _openingTime;
    map['closingTime'] = _closingTime;
    return map;
  }

}

/// bankName : "State Bank Of India"
/// branchName : "Piplani"
/// accountNumber : "0987654321"
/// holderName : "Anwarul Haque"
/// abaNumber : "ABA0987"
/// routingNumber : "R778"

class BankInformation {
  BankInformation({
      String? bankName, 
      String? branchName, 
      String? accountNumber, 
      String? holderName, 
      String? abaNumber, 
      String? routingNumber,}){
    _bankName = bankName;
    _branchName = branchName;
    _accountNumber = accountNumber;
    _holderName = holderName;
    _abaNumber = abaNumber;
    _routingNumber = routingNumber;
}

  BankInformation.fromJson(dynamic json) {
    _bankName = json['bankName'];
    _branchName = json['branchName'];
    _accountNumber = json['accountNumber'];
    _holderName = json['holderName'];
    _abaNumber = json['abaNumber'];
    _routingNumber = json['routingNumber'];
  }
  String? _bankName;
  String? _branchName;
  String? _accountNumber;
  String? _holderName;
  String? _abaNumber;
  String? _routingNumber;
BankInformation copyWith({  String? bankName,
  String? branchName,
  String? accountNumber,
  String? holderName,
  String? abaNumber,
  String? routingNumber,
}) => BankInformation(  bankName: bankName ?? _bankName,
  branchName: branchName ?? _branchName,
  accountNumber: accountNumber ?? _accountNumber,
  holderName: holderName ?? _holderName,
  abaNumber: abaNumber ?? _abaNumber,
  routingNumber: routingNumber ?? _routingNumber,
);
  String? get bankName => _bankName;
  String? get branchName => _branchName;
  String? get accountNumber => _accountNumber;
  String? get holderName => _holderName;
  String? get abaNumber => _abaNumber;
  String? get routingNumber => _routingNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankName'] = _bankName;
    map['branchName'] = _branchName;
    map['accountNumber'] = _accountNumber;
    map['holderName'] = _holderName;
    map['abaNumber'] = _abaNumber;
    map['routingNumber'] = _routingNumber;
    return map;
  }

}

/// msg : "Successfully get Vendor profile"
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