import '../../../../core/utils/app_strings_constants.dart';
import '../../../home/model/safe_convert.dart';

class NormalRestOrderModel {
  final Meta? meta;
  final List<NormalRestDataList>? data;

  NormalRestOrderModel({
     this.meta,
     this.data,
  });

  factory NormalRestOrderModel.fromJson(Map<String, dynamic>? json) => NormalRestOrderModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => NormalRestDataList.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Meta {
  final String msg;
  final bool status;

  Meta({
    this.msg = "",
    this.status = false,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
    msg: asT<String>(json, 'msg'),
    status: asT<bool>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'msg': msg,
    'status': status,
  };
}


class NormalRestDataList {
  final String menuOrderId;
  final int orderStatus;
  final List<ProductDetailsItem> productDetails;
  final List<dynamic> coordinates;
  // late List<dynamic> statusList;
  final String id;
  final String orderType;
  late String selectedOrderStatus = selectOrderStatus;
  final String userId;
  final UserData userData;
  final int mobile;
  final String paymentMethod;
  final dynamic total;
  final int subTotal;
  final String menuOrderID;
  final int deliveryCharge;
  final int couponDiscount;
  final int deliveryDate;
  final String deviceType;
  final String specialRequest;
  final String restaurantId;
  final RestaurantData restaurantData;
  final int deliveryCharges;
  final int tax;
  final double taxAmount;
  final List<dynamic> dispute;
  final int createdAt;
  final int updatedAt;
  dynamic parseCreatedDate;
  String timeSlot;
  dynamic parseDeliveryDate;
  final int v;
  final String cancelReason;
  PaymentDetails? paymentDetails;

  NormalRestDataList({
    this.menuOrderId = "",
    this.orderStatus = 0,
    required this.productDetails,
    required this.coordinates,
    // required this.statusList,
    this.id = "",
    this.selectedOrderStatus = selectOrderStatus,
    this.orderType = "",
    this.userId = "",
    required this.userData,
    this.mobile = 0,
    this.paymentMethod = "",
    this.total = 0.0,
    this.subTotal = 0,
    this.menuOrderID = "",
    this.deliveryCharge = 0,
    this.couponDiscount = 0,
    this.deliveryDate = 0,
    this.deviceType = "",
    this.specialRequest = "",
    this.restaurantId = "",
    required this.restaurantData,
    this.deliveryCharges = 0,
    this.tax = 0,
    this.taxAmount = 0.0,
    required this.dispute,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.parseCreatedDate = "",
    this.timeSlot = "",
    this.parseDeliveryDate = "",
    this.v = 0,
    this.cancelReason = "",
    this.paymentDetails,
  });

  set setOrderStatus(String val){
    this.selectedOrderStatus = val;
  }

  factory NormalRestDataList.fromJson(Map<String, dynamic>? json) => NormalRestDataList(
    menuOrderId: asT<String>(json, 'menuOrderId'),
    orderStatus: asT<int>(json, 'orderStatus'),
    selectedOrderStatus: asT<String>(json, 'selectedOrderStatus'),
    productDetails: asT<List>(json, 'productDetails').map((e) => ProductDetailsItem.fromJson(e)).toList(),
    coordinates: asT<List>(json, 'coordinates').map((e) => e.toString()).toList(),
    // statusList: asT<List>(json, 'statusList').map((e) => e.toString()).toList(),
    id: asT<String>(json, '_id'),
    orderType: asT<String>(json, 'orderType'),
    userId: asT<String>(json, 'userId'),
    userData: UserData.fromJson(asT<Map<String, dynamic>>(json, 'userData')),
    mobile: asT<int>(json, 'mobile'),
    paymentMethod: asT<String>(json, 'paymentMethod'),
    total: asT<double>(json, 'total'),
    subTotal: asT<int>(json, 'subTotal'),
    menuOrderID: asT<String>(json, 'menuOrderID'),
    deliveryCharge: asT<int>(json, 'deliveryCharge'),
    couponDiscount: asT<int>(json, 'couponDiscount'),
    deliveryDate: asT<int>(json, 'deliveryDate'),
    deviceType: asT<String>(json, 'deviceType'),
    specialRequest: asT<String>(json, 'specialRequest'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    tax: asT<int>(json, 'tax'),
    taxAmount: asT<double>(json, 'taxAmount'),
    dispute: asT<List>(json, 'dispute').map((e) => e.toString()).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    timeSlot: asT<String>(json, 'timeSlot'),
    parseCreatedDate: asT<dynamic>(json, 'parseCreatedDate'),
    parseDeliveryDate: asT<dynamic>(json, 'parseDeliveryDate'),
    v: asT<int>(json, '__v'),
    cancelReason: asT<String>(json, 'cancelReason'),
    paymentDetails: PaymentDetails.fromJson(asT<Map<String, dynamic>>(json, 'paymentDetails')),
  );

  set setCreatedDate(dynamic value){
    this.parseCreatedDate = value;
  }

  set setDeliveryDate(dynamic value){
    this.parseDeliveryDate = value;
  }

  set setSelectedStatus(dynamic value){
    this.selectedOrderStatus = value;
  }

  Map<String, dynamic> toJson() => {
    'menuOrderId': menuOrderId,
    'orderStatus': orderStatus,
    'selectedOrderStatus': selectedOrderStatus,
    'productDetails': productDetails.map((e) => e.toJson()).toList(),
    'coordinates': coordinates.map((e) => e).toList(),
    // 'statusList': statusList.map((e) => e).toList(),
    '_id': id,
    'orderType': orderType,
    'userId': userId,
    'userData': userData.toJson(),
    'mobile': mobile,
    'paymentMethod': paymentMethod,
    'total': total,
    'subTotal': subTotal,
    'menuOrderID': menuOrderID,
    'deliveryCharge': deliveryCharge,
    'couponDiscount': couponDiscount,
    'deliveryDate': deliveryDate,
    'deviceType': deviceType,
    'specialRequest': specialRequest,
    'restaurantId': restaurantId,
    'restaurantData': restaurantData.toJson(),
    'deliveryCharges': deliveryCharges,
    'tax': tax,
    'taxAmount': taxAmount,
    'dispute': dispute.map((e) => e).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'timeSlot': timeSlot,
    'parseCreatedDate': parseCreatedDate,
    'parseDeliveryDate': parseDeliveryDate,
    '__v': v,
    'cancelReason': cancelReason,
    'paymentDetails': paymentDetails?.toJson(),
  };
}

class ProductDetailsItem {
  final String cartId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String id;
  final String menuId;
  final int selectQuantity;
  final String dishName;
  final String description;
  final String foodOffered;
  final int price;
  final int specialPrice;
  final String calories;
  final String carbs;
  final String fat;
  final String protein;

  ProductDetailsItem({
    this.cartId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.id = "",
    this.menuId = "",
    this.selectQuantity = 0,
    this.dishName = "",
    this.description = "",
    this.foodOffered = "",
    this.price = 0,
    this.specialPrice = 0,
    this.calories = "",
    this.carbs = "",
    this.fat = "",
    this.protein = "",
  });

  factory ProductDetailsItem.fromJson(Map<String, dynamic>? json) => ProductDetailsItem(
    cartId: asT<String>(json, 'cartId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    id: asT<String>(json, '_id'),
    menuId: asT<String>(json, 'menuId'),
    selectQuantity: asT<int>(json, 'selectQuantity'),
    dishName: asT<String>(json, 'dishName'),
    description: asT<String>(json, 'description'),
    foodOffered: asT<String>(json, 'foodOffered'),
    price: asT<int>(json, 'price'),
    specialPrice: asT<int>(json, 'specialPrice'),
    calories: asT<String>(json, 'calories'),
    carbs: asT<String>(json, 'carbs'),
    fat: asT<String>(json, 'fat'),
    protein: asT<String>(json, 'protein'),
  );

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e).toList(),
    '_id': id,
    'menuId': menuId,
    'selectQuantity': selectQuantity,
    'dishName': dishName,
    'description': description,
    'foodOffered': foodOffered,
    'price': price,
    'specialPrice': specialPrice,
    'calories': calories,
    'carbs': carbs,
    'fat': fat,
    'protein': protein,
  };
}

class PaymentDetails{
  final String receipt_url;

  PaymentDetails({this.receipt_url = ""});

  factory PaymentDetails.fromJson(Map<String, dynamic>? json) => PaymentDetails(
    receipt_url: asT<String>(json, 'receipt_url'),
  );

  Map<String, dynamic> toJson() => {
        'receipt_url': receipt_url,
  };
}

class UserData {
  final String userId;
  final bool isLogin;
  final String gender;
  final String userGoal;
  final String activityLevel;
  final String status;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String mobile;
  final int createdAt;
  final int updatedAt;
  final int v;
  final int otp;
  final String profilePic;

  UserData({
    this.userId = "",
    this.isLogin = false,
    this.gender = "",
    this.userGoal = "",
    this.activityLevel = "",
    this.status = "",
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.mobile = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.otp = 0,
    this.profilePic = "",
  });

  factory UserData.fromJson(Map<String, dynamic>? json) => UserData(
    userId: asT<String>(json, 'userId'),
    isLogin: asT<bool>(json, 'isLogin'),
    gender: asT<String>(json, 'gender'),
    userGoal: asT<String>(json, 'userGoal'),
    activityLevel: asT<String>(json, 'activityLevel'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    firstName: asT<String>(json, 'firstName'),
    lastName: asT<String>(json, 'lastName'),
    email: asT<String>(json, 'email'),
    password: asT<String>(json, 'password'),
    mobile: asT<String>(json, 'mobile'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    otp: asT<int>(json, 'otp'),
    profilePic: asT<String>(json, 'profilePic'),
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'isLogin': isLogin,
    'gender': gender,
    'userGoal': userGoal,
    'activityLevel': activityLevel,
    'status': status,
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'mobile': mobile,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'otp': otp,
    'profilePic': profilePic,
  };
}


class RestaurantData {
  final String id;
  final BankInformation bankInformation;
  final Timings timings;
  final String restaurantId;
  final List<String> menuIds;
  final bool isAssigned;
  final bool isAssignedToHotel;
  final int priceForTwo;
  final List<dynamic> menuImg;
  final List<dynamic> tree;
  final List<String> rootCategoryIds;
  final List<String> categoryIds;
  final List<String> foodTypes;
  final List<dynamic> subCategoryIds;
  final List<String> restaurantImg;
  final List<dynamic> restaurantDocument;
  final bool isTakeAway;
  final bool isChatRoom;
  final bool isShop;
  final bool isOffers;
  final bool otpVerified;
  final bool isLogin;
  final bool isAddedByAdmin;
  final bool isSignupComplete;
  final bool isProfileComplete;
  final int deliveryTime;
  final bool isPickup;
  final bool isDelivery;
  final int ratings;
  final int deliveryCharges;
  final String state;
  final String status;
  final String vendorId;
  final int mobile;
  final String vendorName;
  final String email;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String restaurantAddress;
  final String restaurantName;
  final List<dynamic> coordinates;
  final String managerMobile;
  final String managerName;

  RestaurantData({
    this.id = "",
    required this.bankInformation,
    required this.timings,
    this.restaurantId = "",
    required this.menuIds,
    this.isAssigned = false,
    this.isAssignedToHotel = false,
    this.priceForTwo = 0,
    required this.menuImg,
    required this.tree,
    required this.rootCategoryIds,
    required this.categoryIds,
    required this.foodTypes,
    required this.subCategoryIds,
    required this.restaurantImg,
    required this.restaurantDocument,
    this.isTakeAway = false,
    this.isChatRoom = false,
    this.isShop = false,
    this.isOffers = false,
    this.otpVerified = false,
    this.isLogin = false,
    this.isAddedByAdmin = false,
    this.isSignupComplete = false,
    this.isProfileComplete = false,
    this.deliveryTime = 0,
    this.isPickup = false,
    this.isDelivery = false,
    this.ratings = 0,
    this.deliveryCharges = 0,
    this.state = "",
    this.status = "",
    this.vendorId = "",
    this.mobile = 0,
    this.vendorName = "",
    this.email = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.restaurantAddress = "",
    this.restaurantName = "",
    required this.coordinates,
    this.managerMobile = "",
    this.managerName = "",
  });

  factory RestaurantData.fromJson(Map<String, dynamic>? json) => RestaurantData(
    id: asT<String>(json, '_id'),
    bankInformation: BankInformation.fromJson(asT<Map<String, dynamic>>(json, 'bankInformation')),
    timings: Timings.fromJson(asT<Map<String, dynamic>>(json, 'timings')),
    restaurantId: asT<String>(json, 'restaurantId'),
    menuIds: asT<List>(json, 'menuIds').map((e) => e.toString()).toList(),
    isAssigned: asT<bool>(json, 'isAssigned'),
    isAssignedToHotel: asT<bool>(json, 'isAssignedToHotel'),
    priceForTwo: asT<int>(json, 'priceForTwo'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    tree: asT<List>(json, 'tree').map((e) => e.toString()).toList(),
    rootCategoryIds: asT<List>(json, 'rootCategoryIds').map((e) => e.toString()).toList(),
    categoryIds: asT<List>(json, 'categoryIds').map((e) => e.toString()).toList(),
    foodTypes: asT<List>(json, 'foodTypes').map((e) => e.toString()).toList(),
    subCategoryIds: asT<List>(json, 'subCategoryIds').map((e) => e.toString()).toList(),
    restaurantImg: asT<List>(json, 'restaurantImg').map((e) => e.toString()).toList(),
    restaurantDocument: asT<List>(json, 'restaurantDocument').map((e) => e.toString()).toList(),
    isTakeAway: asT<bool>(json, 'isTakeAway'),
    isChatRoom: asT<bool>(json, 'isChatRoom'),
    isShop: asT<bool>(json, 'isShop'),
    isOffers: asT<bool>(json, 'isOffers'),
    otpVerified: asT<bool>(json, 'otpVerified'),
    isLogin: asT<bool>(json, 'isLogin'),
    isAddedByAdmin: asT<bool>(json, 'isAddedByAdmin'),
    isSignupComplete: asT<bool>(json, 'isSignupComplete'),
    isProfileComplete: asT<bool>(json, 'isProfileComplete'),
    deliveryTime: asT<int>(json, 'deliveryTime'),
    isPickup: asT<bool>(json, 'isPickup'),
    isDelivery: asT<bool>(json, 'isDelivery'),
    ratings: asT<int>(json, 'ratings'),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    vendorId: asT<String>(json, 'vendorId'),
    mobile: asT<int>(json, 'mobile'),
    vendorName: asT<String>(json, 'vendorName'),
    email: asT<String>(json, 'email'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    restaurantAddress: asT<String>(json, 'restaurantAddress'),
    restaurantName: asT<String>(json, 'restaurantName'),
    coordinates: asT<List>(json, 'coordinates').map((e) => double.tryParse(e.toString()) ?? 0.0).toList(),
    managerMobile: asT<String>(json, 'managerMobile'),
    managerName: asT<String>(json, 'managerName'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'bankInformation': bankInformation.toJson(),
    'timings': timings.toJson(),
    'restaurantId': restaurantId,
    'menuIds': menuIds.map((e) => e).toList(),
    'isAssigned': isAssigned,
    'isAssignedToHotel': isAssignedToHotel,
    'priceForTwo': priceForTwo,
    'menuImg': menuImg.map((e) => e).toList(),
    'tree': tree.map((e) => e).toList(),
    'rootCategoryIds': rootCategoryIds.map((e) => e).toList(),
    'categoryIds': categoryIds.map((e) => e).toList(),
    'foodTypes': foodTypes.map((e) => e).toList(),
    'subCategoryIds': subCategoryIds.map((e) => e).toList(),
    'restaurantImg': restaurantImg.map((e) => e).toList(),
    'restaurantDocument': restaurantDocument.map((e) => e).toList(),
    'isTakeAway': isTakeAway,
    'isChatRoom': isChatRoom,
    'isShop': isShop,
    'isOffers': isOffers,
    'otpVerified': otpVerified,
    'isLogin': isLogin,
    'isAddedByAdmin': isAddedByAdmin,
    'isSignupComplete': isSignupComplete,
    'isProfileComplete': isProfileComplete,
    'deliveryTime': deliveryTime,
    'isPickup': isPickup,
    'isDelivery': isDelivery,
    'ratings': ratings,
    'deliveryCharges': deliveryCharges,
    'state': state,
    'status': status,
    'vendorId': vendorId,
    'mobile': mobile,
    'vendorName': vendorName,
    'email': email,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'restaurantAddress': restaurantAddress,
    'restaurantName': restaurantName,
    'coordinates': coordinates.map((e) => e).toList(),
    'managerMobile': managerMobile,
    'managerName': managerName,
  };
}

class BankInformation {
  final String abaNumber;
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String holderName;
  final String routingNumber;

  BankInformation({
    this.abaNumber = "",
    this.accountNumber = "",
    this.bankName = "",
    this.branchName = "",
    this.holderName = "",
    this.routingNumber = "",
  });

  factory BankInformation.fromJson(Map<String, dynamic>? json) => BankInformation(
    abaNumber: asT<String>(json, 'abaNumber'),
    accountNumber: asT<String>(json, 'accountNumber'),
    bankName: asT<String>(json, 'bankName'),
    branchName: asT<String>(json, 'branchName'),
    holderName: asT<String>(json, 'holderName'),
    routingNumber: asT<String>(json, 'routingNumber'),
  );

  Map<String, dynamic> toJson() => {
    'abaNumber': abaNumber,
    'accountNumber': accountNumber,
    'bankName': bankName,
    'branchName': branchName,
    'holderName': holderName,
    'routingNumber': routingNumber,
  };
}


class Timings {
  final bool isOpen;

  Timings({
    this.isOpen = false,
  });

  factory Timings.fromJson(Map<String, dynamic>? json) => Timings(
    isOpen: asT<bool>(json, 'isOpen'),
  );

  Map<String, dynamic> toJson() => {
    'isOpen': isOpen,
  };
}

