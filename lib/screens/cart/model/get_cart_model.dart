class GetCartModel {
  Meta? meta;
  Data? data;
  dynamic total;
  // dynamic calculateSubTotal;
  int? subTotal;
  int? tax;
  dynamic taxAmount;
  dynamic discount;
  dynamic deliveryCharges;
  CouponData? couponData;

  GetCartModel({this.meta, this.data, this.total, this.subTotal, this.discount, this.deliveryCharges,this.tax, this.taxAmount, this.couponData, /*this.calculateSubTotal*/});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    total = json['total'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    deliveryCharges = json['deliveryCharges'];
    tax = json['tax'];
    taxAmount = json['taxAmount'];
    couponData = json['couponData'] != null ? new CouponData.fromJson(json['couponData']) : null;
  }

 /* set setSubTotal(dynamic value){
    this.calculateSubTotal = value;
  }*/

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = this.total;
    data['subTotal'] = this.subTotal;
    data['discount'] = this.discount;
    data['deliveryCharges'] = this.deliveryCharges;
    data['tax'] = this.tax;
    data['taxAmount'] = this.taxAmount;
    if (this.couponData != null) {
      data['couponData'] = this.couponData!.toJson();
    }
    return data;
  }
}

class Meta {
  String? msg;
  bool? status;

  Meta({this.msg, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? sId;
  String? couponName;
  String? userId;
  String? restaurantId;
  List<CartMenu>? cartMenu;
  int? createdAt;
  int? updatedAt;
  int? iV;
  Restaurant? restaurant;
  Coupon? coupon;

  Data({this.sId, this.couponName, this.userId, this.restaurantId, this.cartMenu, this.createdAt, this.updatedAt, this.iV, this.restaurant, this.coupon});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponName = json['couponName'];
    userId = json['userId'];
    restaurantId = json['restaurantId'];
    if (json['cartMenu'] != null) {
      cartMenu = <CartMenu>[];
      json['cartMenu'].forEach((v) { cartMenu!.add(new CartMenu.fromJson(v)); });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
    coupon = json['coupon'] != null ? new Coupon.fromJson(json['coupon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['couponName'] = this.couponName;
    data['userId'] = this.userId;
    data['restaurantId'] = this.restaurantId;
    if (this.cartMenu != null) {
      data['cartMenu'] = this.cartMenu!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.coupon != null) {
      data['coupon'] = this.coupon!.toJson();
    }
    return data;
  }
}

class CartMenu {
  bool? itemDelete;
  String? cartId;
  bool? isVegetarian;
  List<String>? menuImg;
  String? sId;
  String? menuId;
  int? selectQuantity;
  String? dishName;
  String? description;
  String? foodOffered;
  int? price;
  int? specialPrice;
  String? calories;
  String? carbs;
  String? fat;
  String? protein;
  String? restaurantName;
  String? metaDescription;
  String? metaKeyword;
  String? metaTitle;
  dynamic calclulateCalary = 0.0;
  dynamic calclulateFat = 0.0;
  dynamic calclulateCarbs = 0.0;
  dynamic calclulateProtein = 0.0;
  dynamic calclulatePrice = 0;

  CartMenu({this.cartId, this.isVegetarian, this.menuImg, this.sId, this.menuId, this.selectQuantity, this.dishName, this.description, this.foodOffered, this.price, this.specialPrice, this.calories, this.carbs, this.fat, this.protein, this.restaurantName, this.metaDescription, this.metaKeyword, this.metaTitle,this.itemDelete
  , this.calclulateCalary,this.calclulateFat,this.calclulateCarbs,this.calclulateProtein,this.calclulatePrice,});

  CartMenu.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    isVegetarian = json['isVegetarian'];
    menuImg = json['menuImg'].cast<String>();
    sId = json['_id'];
    menuId = json['menuId'];
    selectQuantity = json['selectQuantity'];
    dishName = json['dishName'];
    description = json['description'];
    foodOffered = json['foodOffered'];
    price = json['price'];
    specialPrice = json['specialPrice'];
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    protein = json['protein'];
    restaurantName = json['restaurantName'];
    metaDescription = json['metaDescription'];
    metaKeyword = json['metaKeyword'];
    metaTitle = json['metaTitle'];
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    protein = json['protein'];
    itemDelete = false;
  }

  set setQuantity(int selectQuantity){
    this.selectQuantity = selectQuantity;
  }

  set setPrice(dynamic value){
    this.calclulatePrice = value;
  }

  set setCalories(dynamic value){
    this.calclulateCalary = value;
  }

  set setFat(dynamic value){
    this.calclulateFat = value;
  }
  set setCarbs(dynamic value){
    this.calclulateCarbs = value;
  }
  set setProtein(dynamic value){
    this.calclulateProtein = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['isVegetarian'] = this.isVegetarian;
    data['menuImg'] = this.menuImg;
    data['_id'] = this.sId;
    data['menuId'] = this.menuId;
    data['selectQuantity'] = this.selectQuantity;
    data['dishName'] = this.dishName;
    data['description'] = this.description;
    data['foodOffered'] = this.foodOffered;
    data['price'] = this.price;
    data['specialPrice'] = this.specialPrice;
    data['calories'] = this.calories;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['protein'] = this.protein;
    data['restaurantName'] = this.restaurantName;
    data['metaDescription'] = this.metaDescription;
    data['metaKeyword'] = this.metaKeyword;
    data['metaTitle'] = this.metaTitle;
    data['itemDelete'] = this.itemDelete;
    return data;
  }
}

class Restaurant {
  String? sId;
  BankInformation? bankInformation;
  Timings? timings;
  String? restaurantId;
  List<String>? menuIds;
  bool? isAssigned;
  bool? isAssignedToHotel;
  int? priceForTwo;
  List<String>? rootCategoryIds;
  List<String>? categoryIds;
  List<String>? foodTypes;
  List<String>? restaurantImg;
  bool? isTakeAway;
  bool? isChatRoom;
  bool? isShop;
  bool? isOffers;
  bool? otpVerified;
  bool? isLogin;
  bool? isAddedByAdmin;
  bool? isSignupComplete;
  bool? isProfileComplete;
  int? deliveryTime;
  bool? isPickup;
  bool? isDelivery;
  dynamic ratings;
  String? state;
  String? status;
  String? vendorId;
  int? mobile;
  String? vendorName;
  String? email;
  int? createdAt;
  int? updatedAt;
  int? iV;
  // List<double>? coordinates;
  String? managerMobile;
  String? managerName;
  String? restaurantAddress;
  String? restaurantName;

  Restaurant({this.sId, this.bankInformation, this.timings, this.restaurantId, this.menuIds, this.isAssigned, this.isAssignedToHotel, this.priceForTwo, this.rootCategoryIds, this.categoryIds, this.foodTypes, this.restaurantImg, this.isTakeAway, this.isChatRoom, this.isShop, this.isOffers, this.otpVerified, this.isLogin, this.isAddedByAdmin, this.isSignupComplete, this.isProfileComplete, this.deliveryTime, this.isPickup, this.isDelivery, this.ratings, this.state, this.status, this.vendorId, this.mobile, this.vendorName, this.email, this.createdAt, this.updatedAt, this.iV, /*this.coordinates,*/ this.managerMobile, this.managerName, this.restaurantAddress, this.restaurantName});

  Restaurant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bankInformation = json['bankInformation'] != null ? new BankInformation.fromJson(json['bankInformation']) : null;
    timings = json['timings'] != null ? new Timings.fromJson(json['timings']) : null;
    restaurantId = json['restaurantId'];
    menuIds = json['menuIds'].cast<String>();
    isAssigned = json['isAssigned'];
    isAssignedToHotel = json['isAssignedToHotel'];
    priceForTwo = json['priceForTwo'];
    rootCategoryIds = json['rootCategoryIds'].cast<String>();
    categoryIds = json['categoryIds'].cast<String>();
    foodTypes = json['foodTypes'].cast<String>();
    restaurantImg = json['restaurantImg'].cast<String>();
    isTakeAway = json['isTakeAway'];
    isChatRoom = json['isChatRoom'];
    isShop = json['isShop'];
    isOffers = json['isOffers'];
    otpVerified = json['otpVerified'];
    isLogin = json['isLogin'];
    isAddedByAdmin = json['isAddedByAdmin'];
    isSignupComplete = json['isSignupComplete'];
    isProfileComplete = json['isProfileComplete'];
    deliveryTime = json['deliveryTime'];
    isPickup = json['isPickup'];
    isDelivery = json['isDelivery'];
    ratings = json['ratings'];
    state = json['state'];
    status = json['status'];
    vendorId = json['vendorId'];
    mobile = json['mobile'];
    vendorName = json['vendorName'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    // coordinates = json['coordinates'].cast<double>();
    managerMobile = json['managerMobile'];
    managerName = json['managerName'];
    restaurantAddress = json['restaurantAddress'];
    restaurantName = json['restaurantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.bankInformation != null) {
      data['bankInformation'] = this.bankInformation!.toJson();
    }
    if (this.timings != null) {
      data['timings'] = this.timings!.toJson();
    }
    data['restaurantId'] = this.restaurantId;
    data['menuIds'] = this.menuIds;
    data['isAssigned'] = this.isAssigned;
    data['isAssignedToHotel'] = this.isAssignedToHotel;
    data['priceForTwo'] = this.priceForTwo;
    data['rootCategoryIds'] = this.rootCategoryIds;
    data['categoryIds'] = this.categoryIds;
    data['foodTypes'] = this.foodTypes;
    data['restaurantImg'] = this.restaurantImg;
    data['isTakeAway'] = this.isTakeAway;
    data['isChatRoom'] = this.isChatRoom;
    data['isShop'] = this.isShop;
    data['isOffers'] = this.isOffers;
    data['otpVerified'] = this.otpVerified;
    data['isLogin'] = this.isLogin;
    data['isAddedByAdmin'] = this.isAddedByAdmin;
    data['isSignupComplete'] = this.isSignupComplete;
    data['isProfileComplete'] = this.isProfileComplete;
    data['deliveryTime'] = this.deliveryTime;
    data['isPickup'] = this.isPickup;
    data['isDelivery'] = this.isDelivery;
    data['ratings'] = this.ratings;
    data['state'] = this.state;
    data['status'] = this.status;
    data['vendorId'] = this.vendorId;
    data['mobile'] = this.mobile;
    data['vendorName'] = this.vendorName;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    // data['coordinates'] = this.coordinates;
    data['managerMobile'] = this.managerMobile;
    data['managerName'] = this.managerName;
    data['restaurantAddress'] = this.restaurantAddress;
    data['restaurantName'] = this.restaurantName;
    return data;
  }
}

class Coupon{
  String? couponName;

  Coupon({this.couponName});

  Coupon.fromJson(Map<String, dynamic> json) {
    couponName = json['couponName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponName'] = this.couponName;
    return data;
  }
}

class BankInformation {
  String? abaNumber;
  String? accountNumber;
  String? bankName;
  String? branchName;
  String? holderName;
  String? routingNumber;

  BankInformation({this.abaNumber, this.accountNumber, this.bankName, this.branchName, this.holderName, this.routingNumber});

  BankInformation.fromJson(Map<String, dynamic> json) {
    abaNumber = json['abaNumber'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    holderName = json['holderName'];
    routingNumber = json['routingNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abaNumber'] = this.abaNumber;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['branchName'] = this.branchName;
    data['holderName'] = this.holderName;
    data['routingNumber'] = this.routingNumber;
    return data;
  }
}

class Timings {
  String? day;
  String? openingTime;
  String? closingTime;

  Timings({this.day, this.openingTime, this.closingTime});

  Timings.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    return data;
  }
}

class CouponData {

  CouponData();

CouponData.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}
