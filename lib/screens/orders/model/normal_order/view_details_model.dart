/// meta : {"msg":"Order  details successfully found","status":true}
/// data : {"menuOrderId":"62b54be9066ae608ec41739d","orderStatus":5,"productDetails":[{"cartId":"62b44fa4066ae608ec416e63","isVegetarian":true,"menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"],"_id":"62b44fa4066ae608ec416e64","menuId":"6294617346f536ddafd15035","selectQuantity":1,"dishName":"Da Pizzeria","description":"<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>","foodOffered":"ALL","price":78,"specialPrice":78,"calories":"67","carbs":"23","fat":"45","protein":"12"},{"cartId":"62b45031066ae608ec416e72","isVegetarian":true,"menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-Palak%20paneer-1653891243966-393109.jpg"],"_id":"62b45031066ae608ec416e73","menuId":"6294609846f536ddafd14fff","selectQuantity":1,"dishName":"Palak Paneer","restaurantName":"","description":"<p>In some agencies in the 90 circulated a text called the \"yellow tram\" or \"yellow subway\" sensible replace Lorem Ipsum to give a more modern look to content. But too many people were looking to read the text when it was in French or English, the desired effect was not achieved. Working with readable text, containing directions can cause distractions and this can help to focus on the layout.</p><p>The advantage of Latin origin and nonsense content Lorem ipsum prevents the reader from being distracted by the content of the text and thus can focus its attention on graphic design. Indeed the text Lorem Ipsum has the advantage in contrast to a generic text using variable word length to simulate a normal occupancy of the model so that it matches the final product and to ensure future unaltered publication.</p>","foodOffered":"ALL","price":200,"specialPrice":200,"calories":"56","carbs":"76","fat":"54","protein":"87","metaDescription":"","metaKeyword":"","metaTitle":""}],"coordinates":[77.3307413,28.5883602],"_id":"62b54be9066ae608ec41739e","orderType":"DELIVERY","userId":"629461ef9ba9e2ddb6513ece","userData":{"userId":"629461ef9ba9e2ddb6513ece","isLogin":true,"gender":"N/A","userGoal":"LOSE WEIGHT","activityLevel":"LIGHT","status":"ACTIVE","_id":"629461ef9ba9e2ddb6513ecf","firstName":"Anwarul","lastName":"Haque","email":"anwarul@test.com","password":"$2a$10$RHN2kpnR1uaFLm0x.mB6xuYSnNeWgcc6k1jRnFyLYNqv6sr/tE/Iq","mobile":"7491929040","createdAt":1653891567323,"updatedAt":1656047826088,"__v":0,"otp":null,"profilePic":"https://choosi-foodi-bucket.s3.amazonaws.com/profilePic-download%20%284%29-1655970105457-255706.jfif"},"mobile":7491929040,"paymentMethod":"cod","shippingAddress":{"addressId":"629462e79ba9e2ddb6513fc6","addressType":"HOME","isDefault":true,"_id":"629462e79ba9e2ddb6513fc7","userId":"629461ef9ba9e2ddb6513ece","name":"Anwarul Haque","mobile":7491929040,"pincode":462022,"addressLine1":"B-7, B-Block, Shakari Parishar","landmark":"Piplani","cityId":"6177fa91bc7cd813b419152d","cityName":"Noida","stateId":"6177ed50bd56d215f06c6c55","stateName":"Uttar Pradesh","countryId":"6177e615bd56d215f06c6bac","countryName":"India","coordinates":[77.3307413,28.5883602],"createdAt":1653891815394,"updatedAt":1655980535761,"__v":0},"total":278,"subTotal":278,"menuOrderID":"CF-menu-004","deliveryCharge":0,"couponDiscount":0,"deliveryDate":1655894508532,"deviceType":"web","specialRequest":"make it good","restaurantId":"62945a0746f536ddafd14f9d","restaurantData":{"_id":"62945a0746f536ddafd14f9e","bankInformation":{"abaNumber":"ABA1111","accountNumber":"0987654321","bankName":"State Bank Of India","branchName":"Piplani","holderName":"Anwarul Haque","routingNumber":"routingnumber"},"timings":{"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"},"restaurantId":"62945a0746f536ddafd14f9d","menuIds":["6294609846f536ddafd14fff","6294617346f536ddafd15035"],"isAssigned":false,"isAssignedToHotel":false,"priceForTwo":0,"rootCategoryIds":["627b6150c9889116b827db7f","627b61c4c9889116b827db8c","627b6222c9889116b827db9a"],"categoryIds":["627b68dbc9889116b827dd6d","627b6924c9889116b827dd99","627b67c0c9889116b827dd0b"],"foodTypes":["Vegetarian","Vegan","Pescatarian","Keto"],"restaurantImg":["https://choosi-foodi-bucket.s3.amazonaws.com/restaurantImg-blob-1655879493488-104038"],"isTakeAway":false,"isChatRoom":false,"isShop":false,"isOffers":false,"otpVerified":false,"isLogin":false,"isAddedByAdmin":false,"isSignupComplete":true,"isProfileComplete":true,"deliveryTime":45,"isPickup":false,"isDelivery":true,"ratings":0,"state":"APPROVED","status":"ACTIVE","vendorId":"629459df46f536ddafd14f98","mobile":7491929040,"vendorName":"Anwarul Haque","email":"anwarul@test.com","createdAt":1653889543224,"updatedAt":1655891921314,"__v":0,"coordinates":[77.4730653,23.2436838],"managerMobile":"6264240632","managerName":"Anwarul Haque","restaurantAddress":"Piplani, BHEL, Bhopal, Madhya Pradesh 462022, India","restaurantName":"New Horizon Restaurant"},"createdAt":1656048617260,"updatedAt":1656067716153,"__v":0,"cancelReason":"Shipping Address Undeliverable"}

class ViewDetailsModel {
  ViewDetailsModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  ViewDetailsModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
ViewDetailsModel copyWith({  Meta? meta,
  Data? data,
}) => ViewDetailsModel(  meta: meta ?? _meta,
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

/// menuOrderId : "62b54be9066ae608ec41739d"
/// orderStatus : 5
/// productDetails : [{"cartId":"62b44fa4066ae608ec416e63","isVegetarian":true,"menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"],"_id":"62b44fa4066ae608ec416e64","menuId":"6294617346f536ddafd15035","selectQuantity":1,"dishName":"Da Pizzeria","description":"<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>","foodOffered":"ALL","price":78,"specialPrice":78,"calories":"67","carbs":"23","fat":"45","protein":"12"},{"cartId":"62b45031066ae608ec416e72","isVegetarian":true,"menuImg":["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-Palak%20paneer-1653891243966-393109.jpg"],"_id":"62b45031066ae608ec416e73","menuId":"6294609846f536ddafd14fff","selectQuantity":1,"dishName":"Palak Paneer","restaurantName":"","description":"<p>In some agencies in the 90 circulated a text called the \"yellow tram\" or \"yellow subway\" sensible replace Lorem Ipsum to give a more modern look to content. But too many people were looking to read the text when it was in French or English, the desired effect was not achieved. Working with readable text, containing directions can cause distractions and this can help to focus on the layout.</p><p>The advantage of Latin origin and nonsense content Lorem ipsum prevents the reader from being distracted by the content of the text and thus can focus its attention on graphic design. Indeed the text Lorem Ipsum has the advantage in contrast to a generic text using variable word length to simulate a normal occupancy of the model so that it matches the final product and to ensure future unaltered publication.</p>","foodOffered":"ALL","price":200,"specialPrice":200,"calories":"56","carbs":"76","fat":"54","protein":"87","metaDescription":"","metaKeyword":"","metaTitle":""}]
/// coordinates : [77.3307413,28.5883602]
/// _id : "62b54be9066ae608ec41739e"
/// orderType : "DELIVERY"
/// userId : "629461ef9ba9e2ddb6513ece"
/// userData : {"userId":"629461ef9ba9e2ddb6513ece","isLogin":true,"gender":"N/A","userGoal":"LOSE WEIGHT","activityLevel":"LIGHT","status":"ACTIVE","_id":"629461ef9ba9e2ddb6513ecf","firstName":"Anwarul","lastName":"Haque","email":"anwarul@test.com","password":"$2a$10$RHN2kpnR1uaFLm0x.mB6xuYSnNeWgcc6k1jRnFyLYNqv6sr/tE/Iq","mobile":"7491929040","createdAt":1653891567323,"updatedAt":1656047826088,"__v":0,"otp":null,"profilePic":"https://choosi-foodi-bucket.s3.amazonaws.com/profilePic-download%20%284%29-1655970105457-255706.jfif"}
/// mobile : 7491929040
/// paymentMethod : "cod"
/// shippingAddress : {"addressId":"629462e79ba9e2ddb6513fc6","addressType":"HOME","isDefault":true,"_id":"629462e79ba9e2ddb6513fc7","userId":"629461ef9ba9e2ddb6513ece","name":"Anwarul Haque","mobile":7491929040,"pincode":462022,"addressLine1":"B-7, B-Block, Shakari Parishar","landmark":"Piplani","cityId":"6177fa91bc7cd813b419152d","cityName":"Noida","stateId":"6177ed50bd56d215f06c6c55","stateName":"Uttar Pradesh","countryId":"6177e615bd56d215f06c6bac","countryName":"India","coordinates":[77.3307413,28.5883602],"createdAt":1653891815394,"updatedAt":1655980535761,"__v":0}
/// total : 278
/// subTotal : 278
/// menuOrderID : "CF-menu-004"
/// deliveryCharge : 0
/// couponDiscount : 0
/// deliveryDate : 1655894508532
/// deviceType : "web"
/// specialRequest : "make it good"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// restaurantData : {"_id":"62945a0746f536ddafd14f9e","bankInformation":{"abaNumber":"ABA1111","accountNumber":"0987654321","bankName":"State Bank Of India","branchName":"Piplani","holderName":"Anwarul Haque","routingNumber":"routingnumber"},"timings":{"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"},"restaurantId":"62945a0746f536ddafd14f9d","menuIds":["6294609846f536ddafd14fff","6294617346f536ddafd15035"],"isAssigned":false,"isAssignedToHotel":false,"priceForTwo":0,"rootCategoryIds":["627b6150c9889116b827db7f","627b61c4c9889116b827db8c","627b6222c9889116b827db9a"],"categoryIds":["627b68dbc9889116b827dd6d","627b6924c9889116b827dd99","627b67c0c9889116b827dd0b"],"foodTypes":["Vegetarian","Vegan","Pescatarian","Keto"],"restaurantImg":["https://choosi-foodi-bucket.s3.amazonaws.com/restaurantImg-blob-1655879493488-104038"],"isTakeAway":false,"isChatRoom":false,"isShop":false,"isOffers":false,"otpVerified":false,"isLogin":false,"isAddedByAdmin":false,"isSignupComplete":true,"isProfileComplete":true,"deliveryTime":45,"isPickup":false,"isDelivery":true,"ratings":0,"state":"APPROVED","status":"ACTIVE","vendorId":"629459df46f536ddafd14f98","mobile":7491929040,"vendorName":"Anwarul Haque","email":"anwarul@test.com","createdAt":1653889543224,"updatedAt":1655891921314,"__v":0,"coordinates":[77.4730653,23.2436838],"managerMobile":"6264240632","managerName":"Anwarul Haque","restaurantAddress":"Piplani, BHEL, Bhopal, Madhya Pradesh 462022, India","restaurantName":"New Horizon Restaurant"}
/// createdAt : 1656048617260
/// updatedAt : 1656067716153
/// __v : 0
/// cancelReason : "Shipping Address Undeliverable"

class Data {
  Data({
      String? menuOrderId, 
      int? orderStatus, 
      List<ProductDetails>? productDetails, 
      List<double>? coordinates, 
      String? id, 
      String? orderType, 
      String? userId, 
      UserData? userData, 
      int? mobile, 
      String? paymentMethod, 
      ShippingAddress? shippingAddress, 
      int? total, 
      int? subTotal, 
      String? menuOrderID, 
      int? deliveryCharge, 
      int? couponDiscount, 
      int? deliveryDate, 
      String? deviceType, 
      String? specialRequest, 
      String? restaurantId, 
      RestaurantData? restaurantData, 
      int? createdAt, 
      int? updatedAt, 
      int? v, 
      String? cancelReason,}){
    _menuOrderId = menuOrderId;
    _orderStatus = orderStatus;
    _productDetails = productDetails;
    _coordinates = coordinates;
    _id = id;
    _orderType = orderType;
    _userId = userId;
    _userData = userData;
    _mobile = mobile;
    _paymentMethod = paymentMethod;
    _shippingAddress = shippingAddress;
    _total = total;
    _subTotal = subTotal;
    _menuOrderID = menuOrderID;
    _deliveryCharge = deliveryCharge;
    _couponDiscount = couponDiscount;
    _deliveryDate = deliveryDate;
    _deviceType = deviceType;
    _specialRequest = specialRequest;
    _restaurantId = restaurantId;
    _restaurantData = restaurantData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _cancelReason = cancelReason;
}

  Data.fromJson(dynamic json) {
    _menuOrderId = json['menuOrderId'];
    _orderStatus = json['orderStatus'];
    if (json['productDetails'] != null) {
      _productDetails = [];
      json['productDetails'].forEach((v) {
        _productDetails?.add(ProductDetails.fromJson(v));
      });
    }
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    _id = json['_id'];
    _orderType = json['orderType'];
    _userId = json['userId'];
    _userData = json['userData'] != null ? UserData.fromJson(json['userData']) : null;
    _mobile = json['mobile'];
    _paymentMethod = json['paymentMethod'];
    _shippingAddress = json['shippingAddress'] != null ? ShippingAddress.fromJson(json['shippingAddress']) : null;
    _total = json['total'];
    _subTotal = json['subTotal'];
    _menuOrderID = json['menuOrderID'];
    _deliveryCharge = json['deliveryCharge'];
    _couponDiscount = json['couponDiscount'];
    _deliveryDate = json['deliveryDate'];
    _deviceType = json['deviceType'];
    _specialRequest = json['specialRequest'];
    _restaurantId = json['restaurantId'];
    _restaurantData = json['restaurantData'] != null ? RestaurantData.fromJson(json['restaurantData']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _cancelReason = json['cancelReason'];
  }
  String? _menuOrderId;
  int? _orderStatus;
  List<ProductDetails>? _productDetails;
  List<double>? _coordinates;
  String? _id;
  String? _orderType;
  String? _userId;
  UserData? _userData;
  int? _mobile;
  String? _paymentMethod;
  ShippingAddress? _shippingAddress;
  int? _total;
  int? _subTotal;
  String? _menuOrderID;
  int? _deliveryCharge;
  int? _couponDiscount;
  int? _deliveryDate;
  String? _deviceType;
  String? _specialRequest;
  String? _restaurantId;
  RestaurantData? _restaurantData;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
  String? _cancelReason;
Data copyWith({  String? menuOrderId,
  int? orderStatus,
  List<ProductDetails>? productDetails,
  List<double>? coordinates,
  String? id,
  String? orderType,
  String? userId,
  UserData? userData,
  int? mobile,
  String? paymentMethod,
  ShippingAddress? shippingAddress,
  int? total,
  int? subTotal,
  String? menuOrderID,
  int? deliveryCharge,
  int? couponDiscount,
  int? deliveryDate,
  String? deviceType,
  String? specialRequest,
  String? restaurantId,
  RestaurantData? restaurantData,
  int? createdAt,
  int? updatedAt,
  int? v,
  String? cancelReason,
}) => Data(  menuOrderId: menuOrderId ?? _menuOrderId,
  orderStatus: orderStatus ?? _orderStatus,
  productDetails: productDetails ?? _productDetails,
  coordinates: coordinates ?? _coordinates,
  id: id ?? _id,
  orderType: orderType ?? _orderType,
  userId: userId ?? _userId,
  userData: userData ?? _userData,
  mobile: mobile ?? _mobile,
  paymentMethod: paymentMethod ?? _paymentMethod,
  shippingAddress: shippingAddress ?? _shippingAddress,
  total: total ?? _total,
  subTotal: subTotal ?? _subTotal,
  menuOrderID: menuOrderID ?? _menuOrderID,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  couponDiscount: couponDiscount ?? _couponDiscount,
  deliveryDate: deliveryDate ?? _deliveryDate,
  deviceType: deviceType ?? _deviceType,
  specialRequest: specialRequest ?? _specialRequest,
  restaurantId: restaurantId ?? _restaurantId,
  restaurantData: restaurantData ?? _restaurantData,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  cancelReason: cancelReason ?? _cancelReason,
);
  String? get menuOrderId => _menuOrderId;
  int? get orderStatus => _orderStatus;
  List<ProductDetails>? get productDetails => _productDetails;
  List<double>? get coordinates => _coordinates;
  String? get id => _id;
  String? get orderType => _orderType;
  String? get userId => _userId;
  UserData? get userData => _userData;
  int? get mobile => _mobile;
  String? get paymentMethod => _paymentMethod;
  ShippingAddress? get shippingAddress => _shippingAddress;
  int? get total => _total;
  int? get subTotal => _subTotal;
  String? get menuOrderID => _menuOrderID;
  int? get deliveryCharge => _deliveryCharge;
  int? get couponDiscount => _couponDiscount;
  int? get deliveryDate => _deliveryDate;
  String? get deviceType => _deviceType;
  String? get specialRequest => _specialRequest;
  String? get restaurantId => _restaurantId;
  RestaurantData? get restaurantData => _restaurantData;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;
  String? get cancelReason => _cancelReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuOrderId'] = _menuOrderId;
    map['orderStatus'] = _orderStatus;
    if (_productDetails != null) {
      map['productDetails'] = _productDetails?.map((v) => v.toJson()).toList();
    }
    map['coordinates'] = _coordinates;
    map['_id'] = _id;
    map['orderType'] = _orderType;
    map['userId'] = _userId;
    if (_userData != null) {
      map['userData'] = _userData?.toJson();
    }
    map['mobile'] = _mobile;
    map['paymentMethod'] = _paymentMethod;
    if (_shippingAddress != null) {
      map['shippingAddress'] = _shippingAddress?.toJson();
    }
    map['total'] = _total;
    map['subTotal'] = _subTotal;
    map['menuOrderID'] = _menuOrderID;
    map['deliveryCharge'] = _deliveryCharge;
    map['couponDiscount'] = _couponDiscount;
    map['deliveryDate'] = _deliveryDate;
    map['deviceType'] = _deviceType;
    map['specialRequest'] = _specialRequest;
    map['restaurantId'] = _restaurantId;
    if (_restaurantData != null) {
      map['restaurantData'] = _restaurantData?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['cancelReason'] = _cancelReason;
    return map;
  }

}

/// _id : "62945a0746f536ddafd14f9e"
/// bankInformation : {"abaNumber":"ABA1111","accountNumber":"0987654321","bankName":"State Bank Of India","branchName":"Piplani","holderName":"Anwarul Haque","routingNumber":"routingnumber"}
/// timings : {"day":"SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY","openingTime":"11:00","closingTime":"23:59"}
/// restaurantId : "62945a0746f536ddafd14f9d"
/// menuIds : ["6294609846f536ddafd14fff","6294617346f536ddafd15035"]
/// isAssigned : false
/// isAssignedToHotel : false
/// priceForTwo : 0
/// rootCategoryIds : ["627b6150c9889116b827db7f","627b61c4c9889116b827db8c","627b6222c9889116b827db9a"]
/// categoryIds : ["627b68dbc9889116b827dd6d","627b6924c9889116b827dd99","627b67c0c9889116b827dd0b"]
/// foodTypes : ["Vegetarian","Vegan","Pescatarian","Keto"]
/// restaurantImg : ["https://choosi-foodi-bucket.s3.amazonaws.com/restaurantImg-blob-1655879493488-104038"]
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
/// isPickup : false
/// isDelivery : true
/// ratings : 0
/// state : "APPROVED"
/// status : "ACTIVE"
/// vendorId : "629459df46f536ddafd14f98"
/// mobile : 7491929040
/// vendorName : "Anwarul Haque"
/// email : "anwarul@test.com"
/// createdAt : 1653889543224
/// updatedAt : 1655891921314
/// __v : 0
/// coordinates : [77.4730653,23.2436838]
/// managerMobile : "6264240632"
/// managerName : "Anwarul Haque"
/// restaurantAddress : "Piplani, BHEL, Bhopal, Madhya Pradesh 462022, India"
/// restaurantName : "New Horizon Restaurant"

class RestaurantData {
  RestaurantData({
      String? id, 
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
      String? restaurantName,}){
    _id = id;
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
}

  RestaurantData.fromJson(dynamic json) {
    _id = json['_id'];
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
  }
  String? _id;
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
  int? _ratings;
  String? _state;
  String? _status;
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
RestaurantData copyWith({  String? id,
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
}) => RestaurantData(  id: id ?? _id,
  bankInformation: bankInformation ?? _bankInformation,
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
);
  String? get id => _id;
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
  int? get ratings => _ratings;
  String? get state => _state;
  String? get status => _status;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
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

/// abaNumber : "ABA1111"
/// accountNumber : "0987654321"
/// bankName : "State Bank Of India"
/// branchName : "Piplani"
/// holderName : "Anwarul Haque"
/// routingNumber : "routingnumber"

class BankInformation {
  BankInformation({
      String? abaNumber, 
      String? accountNumber, 
      String? bankName, 
      String? branchName, 
      String? holderName, 
      String? routingNumber,}){
    _abaNumber = abaNumber;
    _accountNumber = accountNumber;
    _bankName = bankName;
    _branchName = branchName;
    _holderName = holderName;
    _routingNumber = routingNumber;
}

  BankInformation.fromJson(dynamic json) {
    _abaNumber = json['abaNumber'];
    _accountNumber = json['accountNumber'];
    _bankName = json['bankName'];
    _branchName = json['branchName'];
    _holderName = json['holderName'];
    _routingNumber = json['routingNumber'];
  }
  String? _abaNumber;
  String? _accountNumber;
  String? _bankName;
  String? _branchName;
  String? _holderName;
  String? _routingNumber;
BankInformation copyWith({  String? abaNumber,
  String? accountNumber,
  String? bankName,
  String? branchName,
  String? holderName,
  String? routingNumber,
}) => BankInformation(  abaNumber: abaNumber ?? _abaNumber,
  accountNumber: accountNumber ?? _accountNumber,
  bankName: bankName ?? _bankName,
  branchName: branchName ?? _branchName,
  holderName: holderName ?? _holderName,
  routingNumber: routingNumber ?? _routingNumber,
);
  String? get abaNumber => _abaNumber;
  String? get accountNumber => _accountNumber;
  String? get bankName => _bankName;
  String? get branchName => _branchName;
  String? get holderName => _holderName;
  String? get routingNumber => _routingNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['abaNumber'] = _abaNumber;
    map['accountNumber'] = _accountNumber;
    map['bankName'] = _bankName;
    map['branchName'] = _branchName;
    map['holderName'] = _holderName;
    map['routingNumber'] = _routingNumber;
    return map;
  }

}

/// addressId : "629462e79ba9e2ddb6513fc6"
/// addressType : "HOME"
/// isDefault : true
/// _id : "629462e79ba9e2ddb6513fc7"
/// userId : "629461ef9ba9e2ddb6513ece"
/// name : "Anwarul Haque"
/// mobile : 7491929040
/// pincode : 462022
/// addressLine1 : "B-7, B-Block, Shakari Parishar"
/// landmark : "Piplani"
/// cityId : "6177fa91bc7cd813b419152d"
/// cityName : "Noida"
/// stateId : "6177ed50bd56d215f06c6c55"
/// stateName : "Uttar Pradesh"
/// countryId : "6177e615bd56d215f06c6bac"
/// countryName : "India"
/// coordinates : [77.3307413,28.5883602]
/// createdAt : 1653891815394
/// updatedAt : 1655980535761
/// __v : 0

class ShippingAddress {
  ShippingAddress({
      String? addressId, 
      String? addressType, 
      bool? isDefault, 
      String? id, 
      String? userId, 
      String? name, 
      int? mobile, 
      int? pincode, 
      String? addressLine1, 
      String? landmark, 
      String? cityId, 
      String? cityName, 
      String? stateId, 
      String? stateName, 
      String? countryId, 
      String? countryName, 
      List<double>? coordinates, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _addressId = addressId;
    _addressType = addressType;
    _isDefault = isDefault;
    _id = id;
    _userId = userId;
    _name = name;
    _mobile = mobile;
    _pincode = pincode;
    _addressLine1 = addressLine1;
    _landmark = landmark;
    _cityId = cityId;
    _cityName = cityName;
    _stateId = stateId;
    _stateName = stateName;
    _countryId = countryId;
    _countryName = countryName;
    _coordinates = coordinates;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  ShippingAddress.fromJson(dynamic json) {
    _addressId = json['addressId'];
    _addressType = json['addressType'];
    _isDefault = json['isDefault'];
    _id = json['_id'];
    _userId = json['userId'];
    _name = json['name'];
    _mobile = json['mobile'];
    _pincode = json['pincode'];
    _addressLine1 = json['addressLine1'];
    _landmark = json['landmark'];
    _cityId = json['cityId'];
    _cityName = json['cityName'];
    _stateId = json['stateId'];
    _stateName = json['stateName'];
    _countryId = json['countryId'];
    _countryName = json['countryName'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _addressId;
  String? _addressType;
  bool? _isDefault;
  String? _id;
  String? _userId;
  String? _name;
  int? _mobile;
  int? _pincode;
  String? _addressLine1;
  String? _landmark;
  String? _cityId;
  String? _cityName;
  String? _stateId;
  String? _stateName;
  String? _countryId;
  String? _countryName;
  List<double>? _coordinates;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
ShippingAddress copyWith({  String? addressId,
  String? addressType,
  bool? isDefault,
  String? id,
  String? userId,
  String? name,
  int? mobile,
  int? pincode,
  String? addressLine1,
  String? landmark,
  String? cityId,
  String? cityName,
  String? stateId,
  String? stateName,
  String? countryId,
  String? countryName,
  List<double>? coordinates,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => ShippingAddress(  addressId: addressId ?? _addressId,
  addressType: addressType ?? _addressType,
  isDefault: isDefault ?? _isDefault,
  id: id ?? _id,
  userId: userId ?? _userId,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  pincode: pincode ?? _pincode,
  addressLine1: addressLine1 ?? _addressLine1,
  landmark: landmark ?? _landmark,
  cityId: cityId ?? _cityId,
  cityName: cityName ?? _cityName,
  stateId: stateId ?? _stateId,
  stateName: stateName ?? _stateName,
  countryId: countryId ?? _countryId,
  countryName: countryName ?? _countryName,
  coordinates: coordinates ?? _coordinates,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get addressId => _addressId;
  String? get addressType => _addressType;
  bool? get isDefault => _isDefault;
  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  int? get mobile => _mobile;
  int? get pincode => _pincode;
  String? get addressLine1 => _addressLine1;
  String? get landmark => _landmark;
  String? get cityId => _cityId;
  String? get cityName => _cityName;
  String? get stateId => _stateId;
  String? get stateName => _stateName;
  String? get countryId => _countryId;
  String? get countryName => _countryName;
  List<double>? get coordinates => _coordinates;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addressId'] = _addressId;
    map['addressType'] = _addressType;
    map['isDefault'] = _isDefault;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['pincode'] = _pincode;
    map['addressLine1'] = _addressLine1;
    map['landmark'] = _landmark;
    map['cityId'] = _cityId;
    map['cityName'] = _cityName;
    map['stateId'] = _stateId;
    map['stateName'] = _stateName;
    map['countryId'] = _countryId;
    map['countryName'] = _countryName;
    map['coordinates'] = _coordinates;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// userId : "629461ef9ba9e2ddb6513ece"
/// isLogin : true
/// gender : "N/A"
/// userGoal : "LOSE WEIGHT"
/// activityLevel : "LIGHT"
/// status : "ACTIVE"
/// _id : "629461ef9ba9e2ddb6513ecf"
/// firstName : "Anwarul"
/// lastName : "Haque"
/// email : "anwarul@test.com"
/// password : "$2a$10$RHN2kpnR1uaFLm0x.mB6xuYSnNeWgcc6k1jRnFyLYNqv6sr/tE/Iq"
/// mobile : "7491929040"
/// createdAt : 1653891567323
/// updatedAt : 1656047826088
/// __v : 0
/// otp : null
/// profilePic : "https://choosi-foodi-bucket.s3.amazonaws.com/profilePic-download%20%284%29-1655970105457-255706.jfif"

class UserData {
  UserData({
      String? userId, 
      bool? isLogin, 
      String? gender, 
      String? userGoal, 
      String? activityLevel, 
      String? status, 
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? password, 
      String? mobile, 
      int? createdAt, 
      int? updatedAt, 
      int? v, 
      dynamic otp, 
      String? profilePic,}){
    _userId = userId;
    _isLogin = isLogin;
    _gender = gender;
    _userGoal = userGoal;
    _activityLevel = activityLevel;
    _status = status;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _mobile = mobile;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _otp = otp;
    _profilePic = profilePic;
}

  UserData.fromJson(dynamic json) {
    _userId = json['userId'];
    _isLogin = json['isLogin'];
    _gender = json['gender'];
    _userGoal = json['userGoal'];
    _activityLevel = json['activityLevel'];
    _status = json['status'];
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _password = json['password'];
    _mobile = json['mobile'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _otp = json['otp'];
    _profilePic = json['profilePic'];
  }
  String? _userId;
  bool? _isLogin;
  String? _gender;
  String? _userGoal;
  String? _activityLevel;
  String? _status;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _mobile;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
  dynamic _otp;
  String? _profilePic;
UserData copyWith({  String? userId,
  bool? isLogin,
  String? gender,
  String? userGoal,
  String? activityLevel,
  String? status,
  String? id,
  String? firstName,
  String? lastName,
  String? email,
  String? password,
  String? mobile,
  int? createdAt,
  int? updatedAt,
  int? v,
  dynamic otp,
  String? profilePic,
}) => UserData(  userId: userId ?? _userId,
  isLogin: isLogin ?? _isLogin,
  gender: gender ?? _gender,
  userGoal: userGoal ?? _userGoal,
  activityLevel: activityLevel ?? _activityLevel,
  status: status ?? _status,
  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  password: password ?? _password,
  mobile: mobile ?? _mobile,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  otp: otp ?? _otp,
  profilePic: profilePic ?? _profilePic,
);
  String? get userId => _userId;
  bool? get isLogin => _isLogin;
  String? get gender => _gender;
  String? get userGoal => _userGoal;
  String? get activityLevel => _activityLevel;
  String? get status => _status;
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  String? get mobile => _mobile;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;
  dynamic get otp => _otp;
  String? get profilePic => _profilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['isLogin'] = _isLogin;
    map['gender'] = _gender;
    map['userGoal'] = _userGoal;
    map['activityLevel'] = _activityLevel;
    map['status'] = _status;
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['password'] = _password;
    map['mobile'] = _mobile;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['otp'] = _otp;
    map['profilePic'] = _profilePic;
    return map;
  }

}

/// cartId : "62b44fa4066ae608ec416e63"
/// isVegetarian : true
/// menuImg : ["https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/menuImg-DaPizzeria-1653891449851-314216.jpg"]
/// _id : "62b44fa4066ae608ec416e64"
/// menuId : "6294617346f536ddafd15035"
/// selectQuantity : 1
/// dishName : "Da Pizzeria"
/// description : "<p>A Lipsum is a text used as a substitute in the absence of the final text of a model or a website. Lipsum comes from the contraction of the best known alternative texts: \"\" Lorem ipsum \"\". This type of text is also called white text, fake text, false, fill text replacement text.</p><p>The use of dummy text is common since the 16th century in the print media and composition. The false content has been democratized in the 60s when the company specialized in typo Letraset, published planks with Lorem Ipsum. In the computer age, many software for word processing or page layout using these texts as the default template, hence its presence on construction sites.</p>"
/// foodOffered : "ALL"
/// price : 78
/// specialPrice : 78
/// calories : "67"
/// carbs : "23"
/// fat : "45"
/// protein : "12"

class ProductDetails {
  ProductDetails({
      String? cartId, 
      bool? isVegetarian, 
      List<String>? menuImg, 
      String? id, 
      String? menuId, 
      int? selectQuantity, 
      String? dishName, 
      String? description, 
      String? foodOffered, 
      int? price, 
      int? specialPrice, 
      String? calories, 
      String? carbs, 
      String? fat, 
      String? protein,}){
    _cartId = cartId;
    _isVegetarian = isVegetarian;
    _menuImg = menuImg;
    _id = id;
    _menuId = menuId;
    _selectQuantity = selectQuantity;
    _dishName = dishName;
    _description = description;
    _foodOffered = foodOffered;
    _price = price;
    _specialPrice = specialPrice;
    _calories = calories;
    _carbs = carbs;
    _fat = fat;
    _protein = protein;
}

  ProductDetails.fromJson(dynamic json) {
    _cartId = json['cartId'];
    _isVegetarian = json['isVegetarian'];
    _menuImg = json['menuImg'] != null ? json['menuImg'].cast<String>() : [];
    _id = json['_id'];
    _menuId = json['menuId'];
    _selectQuantity = json['selectQuantity'];
    _dishName = json['dishName'];
    _description = json['description'];
    _foodOffered = json['foodOffered'];
    _price = json['price'];
    _specialPrice = json['specialPrice'];
    _calories = json['calories'];
    _carbs = json['carbs'];
    _fat = json['fat'];
    _protein = json['protein'];
  }
  String? _cartId;
  bool? _isVegetarian;
  List<String>? _menuImg;
  String? _id;
  String? _menuId;
  int? _selectQuantity;
  String? _dishName;
  String? _description;
  String? _foodOffered;
  int? _price;
  int? _specialPrice;
  String? _calories;
  String? _carbs;
  String? _fat;
  String? _protein;
ProductDetails copyWith({  String? cartId,
  bool? isVegetarian,
  List<String>? menuImg,
  String? id,
  String? menuId,
  int? selectQuantity,
  String? dishName,
  String? description,
  String? foodOffered,
  int? price,
  int? specialPrice,
  String? calories,
  String? carbs,
  String? fat,
  String? protein,
}) => ProductDetails(  cartId: cartId ?? _cartId,
  isVegetarian: isVegetarian ?? _isVegetarian,
  menuImg: menuImg ?? _menuImg,
  id: id ?? _id,
  menuId: menuId ?? _menuId,
  selectQuantity: selectQuantity ?? _selectQuantity,
  dishName: dishName ?? _dishName,
  description: description ?? _description,
  foodOffered: foodOffered ?? _foodOffered,
  price: price ?? _price,
  specialPrice: specialPrice ?? _specialPrice,
  calories: calories ?? _calories,
  carbs: carbs ?? _carbs,
  fat: fat ?? _fat,
  protein: protein ?? _protein,
);
  String? get cartId => _cartId;
  bool? get isVegetarian => _isVegetarian;
  List<String>? get menuImg => _menuImg;
  String? get id => _id;
  String? get menuId => _menuId;
  int? get selectQuantity => _selectQuantity;
  String? get dishName => _dishName;
  String? get description => _description;
  String? get foodOffered => _foodOffered;
  int? get price => _price;
  int? get specialPrice => _specialPrice;
  String? get calories => _calories;
  String? get carbs => _carbs;
  String? get fat => _fat;
  String? get protein => _protein;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cartId'] = _cartId;
    map['isVegetarian'] = _isVegetarian;
    map['menuImg'] = _menuImg;
    map['_id'] = _id;
    map['menuId'] = _menuId;
    map['selectQuantity'] = _selectQuantity;
    map['dishName'] = _dishName;
    map['description'] = _description;
    map['foodOffered'] = _foodOffered;
    map['price'] = _price;
    map['specialPrice'] = _specialPrice;
    map['calories'] = _calories;
    map['carbs'] = _carbs;
    map['fat'] = _fat;
    map['protein'] = _protein;
    return map;
  }

}

/// msg : "Order  details successfully found"
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