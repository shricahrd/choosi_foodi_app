import '../../../home/model/safe_convert.dart';

class GORestDetailsModel {
  final Meta? meta;
  final GORestDetailsData? data;

  GORestDetailsModel({
     this.meta,
     this.data,
  });

  factory GORestDetailsModel.fromJson(Map<String, dynamic>? json) => GORestDetailsModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: GORestDetailsData.fromJson(asT<Map<String, dynamic>>(json, 'data')),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.toJson(),
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


class GORestDetailsData {
  final String groupOrderId;
  final int orderStatus;
  final List<ProductDetailsItem> productDetails;
  final List<dynamic> coordinates;
  final int deliveryCharges;
  final String id;
  final String orderType;
  final String groupId;
  final GroupData groupData;
  final String userId;
  final UserData userData;
  final int mobile;
  final String paymentMethod;
  final String shippingAddress;
  final double total;
  final int subTotal;
  final String groupOrderID;
  final int couponDiscount;
  final String restaurantId;
  final RestaurantData restaurantData;
  final PaymentDetails paymentDetails;
  final int tax;
  final double taxAmount;
  final int deliveryDate;
  final String timeSlot;
  final String cancelReason;
  final int createdAt;
  final int updatedAt;
  final int v;

  GORestDetailsData({
    this.groupOrderId = "",
    this.orderStatus = 0,
    required this.productDetails,
    required this.coordinates,
    this.deliveryCharges = 0,
    this.id = "",
    this.orderType = "",
    this.groupId = "",
    required this.groupData,
    this.userId = "",
    required this.userData,
    this.mobile = 0,
    this.paymentMethod = "",
    this.shippingAddress = "",
    this.total = 0.0,
    this.subTotal = 0,
    this.groupOrderID = "",
    this.couponDiscount = 0,
    this.restaurantId = "",
    required this.restaurantData,
    required this.paymentDetails,
    this.tax = 0,
    this.taxAmount = 0.0,
    this.deliveryDate = 0,
    this.timeSlot = "",
    this.cancelReason = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory GORestDetailsData.fromJson(Map<String, dynamic>? json) => GORestDetailsData(
    groupOrderId: asT<String>(json, 'groupOrderId'),
    orderStatus: asT<int>(json, 'orderStatus'),
    productDetails: asT<List>(json, 'productDetails').map((e) => ProductDetailsItem.fromJson(e)).toList(),
    coordinates: asT<List>(json, 'coordinates').map((e) => e.toString()).toList(),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    id: asT<String>(json, '_id'),
    orderType: asT<String>(json, 'orderType'),
    groupId: asT<String>(json, 'groupId'),
    groupData: GroupData.fromJson(asT<Map<String, dynamic>>(json, 'groupData')),
    userId: asT<String>(json, 'userId'),
    userData: UserData.fromJson(asT<Map<String, dynamic>>(json, 'userData')),
    mobile: asT<int>(json, 'mobile'),
    paymentMethod: asT<String>(json, 'paymentMethod'),
    shippingAddress: asT<String>(json, 'shippingAddress'),
    total: asT<double>(json, 'total'),
    subTotal: asT<int>(json, 'subTotal'),
    groupOrderID: asT<String>(json, 'groupOrderID'),
    couponDiscount: asT<int>(json, 'couponDiscount'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    paymentDetails: PaymentDetails.fromJson(asT<Map<String, dynamic>>(json, 'paymentDetails')),
    tax: asT<int>(json, 'tax'),
    taxAmount: asT<double>(json, 'taxAmount'),
    deliveryDate: asT<int>(json, 'deliveryDate'),
    timeSlot: asT<String>(json, 'timeSlot'),
    cancelReason: asT<String>(json, 'cancelReason'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'groupOrderId': groupOrderId,
    'orderStatus': orderStatus,
    'productDetails': productDetails.map((e) => e.toJson()).toList(),
    'coordinates': coordinates.map((e) => e).toList(),
    'deliveryCharges': deliveryCharges,
    '_id': id,
    'orderType': orderType,
    'groupId': groupId,
    'groupData': groupData.toJson(),
    'userId': userId,
    'userData': userData.toJson(),
    'mobile': mobile,
    'paymentMethod': paymentMethod,
    'shippingAddress': shippingAddress,
    'total': total,
    'subTotal': subTotal,
    'groupOrderID': groupOrderID,
    'couponDiscount': couponDiscount,
    'restaurantId': restaurantId,
    'restaurantData': restaurantData.toJson(),
    'paymentDetails': paymentDetails.toJson(),
    'tax': tax,
    'taxAmount': taxAmount,
    'deliveryDate': deliveryDate,
    'timeSlot': timeSlot,
    'cancelReason': cancelReason,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class ProductDetailsItem {
  final String id;
  final String groupCartId;
  final String couponName;
  final bool isDelivery;
  final String adminUserId;
  final String adminUserName;
  final String userId;
  final String name;
  final String groupId;
  final String groupName;
  final String restaurantId;
  final String restaurantName;
  final List<CartMenuItem> cartMenu;
  final int createdAt;
  final int updatedAt;
  final int v;

  ProductDetailsItem({
    this.id = "",
    this.groupCartId = "",
    this.couponName = "",
    this.isDelivery = false,
    this.adminUserId = "",
    this.adminUserName = "",
    this.userId = "",
    this.name = "",
    this.groupId = "",
    this.groupName = "",
    this.restaurantId = "",
    this.restaurantName = "",
    required this.cartMenu,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory ProductDetailsItem.fromJson(Map<String, dynamic>? json) => ProductDetailsItem(
    id: asT<String>(json, '_id'),
    groupCartId: asT<String>(json, 'groupCartId'),
    couponName: asT<String>(json, 'couponName'),
    isDelivery: asT<bool>(json, 'isDelivery'),
    adminUserId: asT<String>(json, 'adminUserId'),
    adminUserName: asT<String>(json, 'adminUserName'),
    userId: asT<String>(json, 'userId'),
    name: asT<String>(json, 'name'),
    groupId: asT<String>(json, 'groupId'),
    groupName: asT<String>(json, 'groupName'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
    cartMenu: asT<List>(json, 'cartMenu').map((e) => CartMenuItem.fromJson(e)).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'groupCartId': groupCartId,
    'couponName': couponName,
    'isDelivery': isDelivery,
    'adminUserId': adminUserId,
    'adminUserName': adminUserName,
    'userId': userId,
    'name': name,
    'groupId': groupId,
    'groupName': groupName,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'cartMenu': cartMenu.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class CartMenuItem {
  final String cartId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String id;
  final String menuId;
  final int selectQuantity;
  final String dishName;
  final String description;
  final String foodOffered;
  late int price;
  final String calories;
  final String carbs;
  final String fat;
  final String protein;
  final List<dynamic> otherAddons;

  CartMenuItem({
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
    this.calories = "",
    this.carbs = "",
    this.fat = "",
    this.protein = "",
    required this.otherAddons,
  });

  factory CartMenuItem.fromJson(Map<String, dynamic>? json) => CartMenuItem(
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
    calories: asT<String>(json, 'calories'),
    carbs: asT<String>(json, 'carbs'),
    fat: asT<String>(json, 'fat'),
    protein: asT<String>(json, 'protein'),
    otherAddons: asT<List>(json, 'otherAddons').map((e) => e.toString()).toList(),
  );

  set setPrice(dynamic value){
    this.price = value;
  }

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
    'calories': calories,
    'carbs': carbs,
    'fat': fat,
    'protein': protein,
    'otherAddons': otherAddons.map((e) => e).toList(),
  };
}


class GroupData {
  final String groupId;
  final String orderType;
  final String paidBy;
  final List<double> coordinates;
  final String id;
  final String userId;
  final String name;
  final int mobile;
  final String restaurantId;
  final String restaurantName;
  final String groupName;
  final int spendingLimit;
  final String address;
  final List<InvitedMemberItem> invitedMember;
  final List<dynamic> joinedMember;
  final int createdAt;
  final int updatedAt;
  final int v;

  GroupData({
    this.groupId = "",
    this.orderType = "",
    this.paidBy = "",
    required this.coordinates,
    this.id = "",
    this.userId = "",
    this.name = "",
    this.mobile = 0,
    this.restaurantId = "",
    this.restaurantName = "",
    this.groupName = "",
    this.spendingLimit = 0,
    this.address = "",
    required this.invitedMember,
    required this.joinedMember,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory GroupData.fromJson(Map<String, dynamic>? json) => GroupData(
    groupId: asT<String>(json, 'groupId'),
    orderType: asT<String>(json, 'orderType'),
    paidBy: asT<String>(json, 'paidBy'),
    coordinates: asT<List>(json, 'coordinates').map((e) => double.tryParse(e.toString()) ?? 0.0).toList(),
    id: asT<String>(json, '_id'),
    userId: asT<String>(json, 'userId'),
    name: asT<String>(json, 'name'),
    mobile: asT<int>(json, 'mobile'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
    groupName: asT<String>(json, 'groupName'),
    spendingLimit: asT<int>(json, 'spendingLimit'),
    address: asT<String>(json, 'address'),
    invitedMember: asT<List>(json, 'invitedMember').map((e) => InvitedMemberItem.fromJson(e)).toList(),
    joinedMember: asT<List>(json, 'joinedMember').map((e) => e.toString()).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'orderType': orderType,
    'paidBy': paidBy,
    'coordinates': coordinates.map((e) => e).toList(),
    '_id': id,
    'userId': userId,
    'name': name,
    'mobile': mobile,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'groupName': groupName,
    'spendingLimit': spendingLimit,
    'address': address,
    'invitedMember': invitedMember.map((e) => e.toJson()).toList(),
    'joinedMember': joinedMember.map((e) => e).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class InvitedMemberItem {
  final String id;
  final String userId;
  final String mobile;

  InvitedMemberItem({
    this.id = "",
    this.userId = "",
    this.mobile = "",
  });

  factory InvitedMemberItem.fromJson(Map<String, dynamic>? json) => InvitedMemberItem(
    id: asT<String>(json, '_id'),
    userId: asT<String>(json, 'userId'),
    mobile: asT<String>(json, 'mobile'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'mobile': mobile,
  };
}


class UserData {
  final String userId;
  final bool isLogin;
  final bool isMobileOtpValid;
  final bool otpVerified;
  final bool newUser;
  final String gender;
  final String userGoal;
  final String activityLevel;
  final String loginType;
  final String status;
  final String id;
  final String email;
  final String password;
  final String mobile;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String firstName;
  final String lastName;
  final String deviceToken;
  final int age;
  final int height;
  final int meals;
  final int weight;

  UserData({
    this.userId = "",
    this.isLogin = false,
    this.isMobileOtpValid = false,
    this.otpVerified = false,
    this.newUser = false,
    this.gender = "",
    this.userGoal = "",
    this.activityLevel = "",
    this.loginType = "",
    this.status = "",
    this.id = "",
    this.email = "",
    this.password = "",
    this.mobile = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.firstName = "",
    this.lastName = "",
    this.deviceToken = "",
    this.age = 0,
    this.height = 0,
    this.meals = 0,
    this.weight = 0,
  });

  factory UserData.fromJson(Map<String, dynamic>? json) => UserData(
    userId: asT<String>(json, 'userId'),
    isLogin: asT<bool>(json, 'isLogin'),
    isMobileOtpValid: asT<bool>(json, 'isMobileOtpValid'),
    otpVerified: asT<bool>(json, 'otpVerified'),
    newUser: asT<bool>(json, 'newUser'),
    gender: asT<String>(json, 'gender'),
    userGoal: asT<String>(json, 'userGoal'),
    activityLevel: asT<String>(json, 'activityLevel'),
    loginType: asT<String>(json, 'loginType'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    email: asT<String>(json, 'email'),
    password: asT<String>(json, 'password'),
    mobile: asT<String>(json, 'mobile'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    firstName: asT<String>(json, 'firstName'),
    lastName: asT<String>(json, 'lastName'),
    deviceToken: asT<String>(json, 'deviceToken'),
    age: asT<int>(json, 'age'),
    height: asT<int>(json, 'height'),
    meals: asT<int>(json, 'meals'),
    weight: asT<int>(json, 'weight'),
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'isLogin': isLogin,
    'isMobileOtpValid': isMobileOtpValid,
    'otpVerified': otpVerified,
    'newUser': newUser,
    'gender': gender,
    'userGoal': userGoal,
    'activityLevel': activityLevel,
    'loginType': loginType,
    'status': status,
    '_id': id,
    'email': email,
    'password': password,
    'mobile': mobile,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'firstName': firstName,
    'lastName': lastName,
    'deviceToken': deviceToken,
    'age': age,
    'height': height,
    'meals': meals,
    'weight': weight,
  };
}


class RestaurantData {
  final String id;
  final BankInformation bankInformation;
  final Timings timings;
  final String restaurantId;
  final bool isAssigned;
  final bool isAssignedToHotel;
  final int priceForTwo;
  final List<dynamic> menuImg;
  final List<String> foodTypes;
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
  final double ratings;
  final String state;
  final String status;
  final String vendorId;
  final int mobile;
  final String vendorName;
  final String email;
  final int createdAt;
  final int updatedAt;
  final int v;
  final List<double> coordinates;
  final String managerMobile;
  final String managerName;
  final String restaurantAddress;
  final String restaurantName;
  final int deliveryCharges;
  final int minimumOrderValue;
  final int restaurantNumber;
  final String restaurantEmail;

  RestaurantData({
    this.id = "",
    required this.bankInformation,
    required this.timings,
    this.restaurantId = "",
    this.isAssigned = false,
    this.isAssignedToHotel = false,
    this.priceForTwo = 0,
    required this.menuImg,
    required this.foodTypes,
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
    this.ratings = 0.0,
    this.state = "",
    this.status = "",
    this.vendorId = "",
    this.mobile = 0,
    this.vendorName = "",
    this.email = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    required this.coordinates,
    this.managerMobile = "",
    this.managerName = "",
    this.restaurantAddress = "",
    this.restaurantName = "",
    this.deliveryCharges = 0,
    this.minimumOrderValue = 0,
    this.restaurantNumber = 0,
    this.restaurantEmail = "",
  });

  factory RestaurantData.fromJson(Map<String, dynamic>? json) => RestaurantData(
    id: asT<String>(json, '_id'),
    bankInformation: BankInformation.fromJson(asT<Map<String, dynamic>>(json, 'bankInformation')),
    timings: Timings.fromJson(asT<Map<String, dynamic>>(json, 'timings')),
    restaurantId: asT<String>(json, 'restaurantId'),
    isAssigned: asT<bool>(json, 'isAssigned'),
    isAssignedToHotel: asT<bool>(json, 'isAssignedToHotel'),
    priceForTwo: asT<int>(json, 'priceForTwo'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    foodTypes: asT<List>(json, 'foodTypes').map((e) => e.toString()).toList(),
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
    ratings: asT<double>(json, 'ratings'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    vendorId: asT<String>(json, 'vendorId'),
    mobile: asT<int>(json, 'mobile'),
    vendorName: asT<String>(json, 'vendorName'),
    email: asT<String>(json, 'email'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    coordinates: asT<List>(json, 'coordinates').map((e) => double.tryParse(e.toString()) ?? 0.0).toList(),
    managerMobile: asT<String>(json, 'managerMobile'),
    managerName: asT<String>(json, 'managerName'),
    restaurantAddress: asT<String>(json, 'restaurantAddress'),
    restaurantName: asT<String>(json, 'restaurantName'),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    minimumOrderValue: asT<int>(json, 'minimumOrderValue'),
    restaurantNumber: asT<int>(json, 'restaurantNumber'),
    restaurantEmail: asT<String>(json, 'restaurantEmail'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'bankInformation': bankInformation.toJson(),
    'timings': timings.toJson(),
    'restaurantId': restaurantId,
    'isAssigned': isAssigned,
    'isAssignedToHotel': isAssignedToHotel,
    'priceForTwo': priceForTwo,
    'menuImg': menuImg.map((e) => e).toList(),
    'foodTypes': foodTypes.map((e) => e).toList(),
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
    'state': state,
    'status': status,
    'vendorId': vendorId,
    'mobile': mobile,
    'vendorName': vendorName,
    'email': email,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'coordinates': coordinates.map((e) => e).toList(),
    'managerMobile': managerMobile,
    'managerName': managerName,
    'restaurantAddress': restaurantAddress,
    'restaurantName': restaurantName,
    'deliveryCharges': deliveryCharges,
    'minimumOrderValue': minimumOrderValue,
    'restaurantNumber': restaurantNumber,
    'restaurantEmail': restaurantEmail,
  };
}

class BankInformation {
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String holderName;
  final String routingNumber;

  BankInformation({
    this.accountNumber = "",
    this.bankName = "",
    this.branchName = "",
    this.holderName = "",
    this.routingNumber = "",
  });

  factory BankInformation.fromJson(Map<String, dynamic>? json) => BankInformation(
    accountNumber: asT<String>(json, 'accountNumber'),
    bankName: asT<String>(json, 'bankName'),
    branchName: asT<String>(json, 'branchName'),
    holderName: asT<String>(json, 'holderName'),
    routingNumber: asT<String>(json, 'routingNumber'),
  );

  Map<String, dynamic> toJson() => {
    'accountNumber': accountNumber,
    'bankName': bankName,
    'branchName': branchName,
    'holderName': holderName,
    'routingNumber': routingNumber,
  };
}


class Timings {
  final String day;
  final String openingTime;
  final String closingTime;

  Timings({
    this.day = "",
    this.openingTime = "",
    this.closingTime = "",
  });

  factory Timings.fromJson(Map<String, dynamic>? json) => Timings(
    day: asT<String>(json, 'day'),
    openingTime: asT<String>(json, 'openingTime'),
    closingTime: asT<String>(json, 'closingTime'),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'openingTime': openingTime,
    'closingTime': closingTime,
  };
}


class PaymentDetails {
  final String id;
  final String object;
  final int amount;
  final int amountCaptured;
  final int amountRefunded;
  final dynamic application;
  final dynamic applicationFee;
  final dynamic applicationFeeAmount;
  final String balanceTransaction;
  final BillingDetails billingDetails;
  final String calculatedStatementDescriptor;
  final bool captured;
  final int created;
  final String currency;
  final String customer;
  final String description;
  final dynamic destination;
  final dynamic dispute;
  final bool disputed;
  final dynamic failureBalanceTransaction;
  final dynamic failureCode;
  final dynamic failureMessage;
  final dynamic invoice;
  final bool livemode;
  final dynamic onBehalfOf;
  final dynamic order;
  final Outcome outcome;
  final bool paid;
  final dynamic paymentIntent;
  final String paymentMethod;
  final PaymentMethodDetails paymentMethodDetails;
  final dynamic receiptEmail;
  final dynamic receiptNumber;
  final String receiptUrl;
  final bool refunded;
  final Refunds refunds;
  final dynamic review;
  final dynamic shipping;
  final Source source;
  final dynamic sourceTransfer;
  final dynamic statementDescriptor;
  final dynamic statementDescriptorSuffix;
  final String status;
  final dynamic transferData;
  final dynamic transferGroup;

  PaymentDetails({
    this.id = "",
    this.object = "",
    this.amount = 0,
    this.amountCaptured = 0,
    this.amountRefunded = 0,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    this.balanceTransaction = "",
    required this.billingDetails,
    this.calculatedStatementDescriptor = "",
    this.captured = false,
    this.created = 0,
    this.currency = "",
    this.customer = "",
    this.description = "",
    this.destination,
    this.dispute,
    this.disputed = false,
    this.failureBalanceTransaction,
    this.failureCode,
    this.failureMessage,
    this.invoice,
    this.livemode = false,
    this.onBehalfOf,
    this.order,
    required this.outcome,
    this.paid = false,
    this.paymentIntent,
    this.paymentMethod = "",
    required this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    this.receiptUrl = "",
    this.refunded = false,
    required this.refunds,
    this.review,
    this.shipping,
    required this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status = "",
    this.transferData,
    this.transferGroup,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic>? json) => PaymentDetails(
    id: asT<String>(json, 'id'),
    object: asT<String>(json, 'object'),
    amount: asT<int>(json, 'amount'),
    amountCaptured: asT<int>(json, 'amount_captured'),
    amountRefunded: asT<int>(json, 'amount_refunded'),
    application: asT<dynamic>(json, 'application'),
    applicationFee: asT<dynamic>(json, 'application_fee'),
    applicationFeeAmount: asT<dynamic>(json, 'application_fee_amount'),
    balanceTransaction: asT<String>(json, 'balance_transaction'),
    billingDetails: BillingDetails.fromJson(asT<Map<String, dynamic>>(json, 'billing_details')),
    calculatedStatementDescriptor: asT<String>(json, 'calculated_statement_descriptor'),
    captured: asT<bool>(json, 'captured'),
    created: asT<int>(json, 'created'),
    currency: asT<String>(json, 'currency'),
    customer: asT<String>(json, 'customer'),
    description: asT<String>(json, 'description'),
    destination: asT<dynamic>(json, 'destination'),
    dispute: asT<dynamic>(json, 'dispute'),
    disputed: asT<bool>(json, 'disputed'),
    failureBalanceTransaction: asT<dynamic>(json, 'failure_balance_transaction'),
    failureCode: asT<dynamic>(json, 'failure_code'),
    failureMessage: asT<dynamic>(json, 'failure_message'),
    invoice: asT<dynamic>(json, 'invoice'),
    livemode: asT<bool>(json, 'livemode'),
    onBehalfOf: asT<dynamic>(json, 'on_behalf_of'),
    order: asT<dynamic>(json, 'order'),
    outcome: Outcome.fromJson(asT<Map<String, dynamic>>(json, 'outcome')),
    paid: asT<bool>(json, 'paid'),
    paymentIntent: asT<dynamic>(json, 'payment_intent'),
    paymentMethod: asT<String>(json, 'payment_method'),
    paymentMethodDetails: PaymentMethodDetails.fromJson(asT<Map<String, dynamic>>(json, 'payment_method_details')),
    receiptEmail: asT<dynamic>(json, 'receipt_email'),
    receiptNumber: asT<dynamic>(json, 'receipt_number'),
    receiptUrl: asT<String>(json, 'receipt_url'),
    refunded: asT<bool>(json, 'refunded'),
    refunds: Refunds.fromJson(asT<Map<String, dynamic>>(json, 'refunds')),
    review: asT<dynamic>(json, 'review'),
    shipping: asT<dynamic>(json, 'shipping'),
    source: Source.fromJson(asT<Map<String, dynamic>>(json, 'source')),
    sourceTransfer: asT<dynamic>(json, 'source_transfer'),
    statementDescriptor: asT<dynamic>(json, 'statement_descriptor'),
    statementDescriptorSuffix: asT<dynamic>(json, 'statement_descriptor_suffix'),
    status: asT<String>(json, 'status'),
    transferData: asT<dynamic>(json, 'transfer_data'),
    transferGroup: asT<dynamic>(json, 'transfer_group'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'object': object,
    'amount': amount,
    'amount_captured': amountCaptured,
    'amount_refunded': amountRefunded,
    'application': application,
    'application_fee': applicationFee,
    'application_fee_amount': applicationFeeAmount,
    'balance_transaction': balanceTransaction,
    'billing_details': billingDetails.toJson(),
    'calculated_statement_descriptor': calculatedStatementDescriptor,
    'captured': captured,
    'created': created,
    'currency': currency,
    'customer': customer,
    'description': description,
    'destination': destination,
    'dispute': dispute,
    'disputed': disputed,
    'failure_balance_transaction': failureBalanceTransaction,
    'failure_code': failureCode,
    'failure_message': failureMessage,
    'invoice': invoice,
    'livemode': livemode,
    'on_behalf_of': onBehalfOf,
    'order': order,
    'outcome': outcome.toJson(),
    'paid': paid,
    'payment_intent': paymentIntent,
    'payment_method': paymentMethod,
    'payment_method_details': paymentMethodDetails.toJson(),
    'receipt_email': receiptEmail,
    'receipt_number': receiptNumber,
    'receipt_url': receiptUrl,
    'refunded': refunded,
    'refunds': refunds.toJson(),
    'review': review,
    'shipping': shipping,
    'source': source.toJson(),
    'source_transfer': sourceTransfer,
    'statement_descriptor': statementDescriptor,
    'statement_descriptor_suffix': statementDescriptorSuffix,
    'status': status,
    'transfer_data': transferData,
    'transfer_group': transferGroup,
  };
}

class BillingDetails {
  final Address address;
  final dynamic email;
  final String name;
  final dynamic phone;

  BillingDetails({
    required this.address,
    this.email,
    this.name = "",
    this.phone,
  });

  factory BillingDetails.fromJson(Map<String, dynamic>? json) => BillingDetails(
    address: Address.fromJson(asT<Map<String, dynamic>>(json, 'address')),
    email: asT<dynamic>(json, 'email'),
    name: asT<String>(json, 'name'),
    phone: asT<dynamic>(json, 'phone'),
  );

  Map<String, dynamic> toJson() => {
    'address': address.toJson(),
    'email': email,
    'name': name,
    'phone': phone,
  };
}

class Address {
  final dynamic city;
  final dynamic country;
  final dynamic line1;
  final dynamic line2;
  final dynamic postalCode;
  final dynamic state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic>? json) => Address(
    city: asT<dynamic>(json, 'city'),
    country: asT<dynamic>(json, 'country'),
    line1: asT<dynamic>(json, 'line1'),
    line2: asT<dynamic>(json, 'line2'),
    postalCode: asT<dynamic>(json, 'postal_code'),
    state: asT<dynamic>(json, 'state'),
  );

  Map<String, dynamic> toJson() => {
    'city': city,
    'country': country,
    'line1': line1,
    'line2': line2,
    'postal_code': postalCode,
    'state': state,
  };
}


class Outcome {
  final String networkStatus;
  final dynamic reason;
  final String riskLevel;
  final int riskScore;
  final String sellerMessage;
  final String type;

  Outcome({
    this.networkStatus = "",
    this.reason,
    this.riskLevel = "",
    this.riskScore = 0,
    this.sellerMessage = "",
    this.type = "",
  });

  factory Outcome.fromJson(Map<String, dynamic>? json) => Outcome(
    networkStatus: asT<String>(json, 'network_status'),
    reason: asT<dynamic>(json, 'reason'),
    riskLevel: asT<String>(json, 'risk_level'),
    riskScore: asT<int>(json, 'risk_score'),
    sellerMessage: asT<String>(json, 'seller_message'),
    type: asT<String>(json, 'type'),
  );

  Map<String, dynamic> toJson() => {
    'network_status': networkStatus,
    'reason': reason,
    'risk_level': riskLevel,
    'risk_score': riskScore,
    'seller_message': sellerMessage,
    'type': type,
  };
}


class PaymentMethodDetails {
  final Card card;
  final String type;

  PaymentMethodDetails({
    required this.card,
    this.type = "",
  });

  factory PaymentMethodDetails.fromJson(Map<String, dynamic>? json) => PaymentMethodDetails(
    card: Card.fromJson(asT<Map<String, dynamic>>(json, 'card')),
    type: asT<String>(json, 'type'),
  );

  Map<String, dynamic> toJson() => {
    'card': card.toJson(),
    'type': type,
  };
}

class Card {
  final int amountAuthorized;
  final String brand;
  final Checks checks;
  final String country;
  final int expMonth;
  final int expYear;
  final ExtendedAuthorization extendedAuthorization;
  final String fingerprint;
  final String funding;
  final IncrementalAuthorization incrementalAuthorization;
  final dynamic installments;
  final String last4;
  final dynamic mandate;
  final Multicapture multicapture;
  final String network;
  final NetworkToken networkToken;
  final Overcapture overcapture;
  final dynamic threeDSecure;
  final dynamic wallet;

  Card({
    this.amountAuthorized = 0,
    this.brand = "",
    required this.checks,
    this.country = "",
    this.expMonth = 0,
    this.expYear = 0,
    required this.extendedAuthorization,
    this.fingerprint = "",
    this.funding = "",
    required this.incrementalAuthorization,
    this.installments,
    this.last4 = "",
    this.mandate,
    required this.multicapture,
    this.network = "",
    required this.networkToken,
    required this.overcapture,
    this.threeDSecure,
    this.wallet,
  });

  factory Card.fromJson(Map<String, dynamic>? json) => Card(
    amountAuthorized: asT<int>(json, 'amount_authorized'),
    brand: asT<String>(json, 'brand'),
    checks: Checks.fromJson(asT<Map<String, dynamic>>(json, 'checks')),
    country: asT<String>(json, 'country'),
    expMonth: asT<int>(json, 'exp_month'),
    expYear: asT<int>(json, 'exp_year'),
    extendedAuthorization: ExtendedAuthorization.fromJson(asT<Map<String, dynamic>>(json, 'extended_authorization')),
    fingerprint: asT<String>(json, 'fingerprint'),
    funding: asT<String>(json, 'funding'),
    incrementalAuthorization: IncrementalAuthorization.fromJson(asT<Map<String, dynamic>>(json, 'incremental_authorization')),
    installments: asT<dynamic>(json, 'installments'),
    last4: asT<String>(json, 'last4'),
    mandate: asT<dynamic>(json, 'mandate'),
    multicapture: Multicapture.fromJson(asT<Map<String, dynamic>>(json, 'multicapture')),
    network: asT<String>(json, 'network'),
    networkToken: NetworkToken.fromJson(asT<Map<String, dynamic>>(json, 'network_token')),
    overcapture: Overcapture.fromJson(asT<Map<String, dynamic>>(json, 'overcapture')),
    threeDSecure: asT<dynamic>(json, 'three_d_secure'),
    wallet: asT<dynamic>(json, 'wallet'),
  );

  Map<String, dynamic> toJson() => {
    'amount_authorized': amountAuthorized,
    'brand': brand,
    'checks': checks.toJson(),
    'country': country,
    'exp_month': expMonth,
    'exp_year': expYear,
    'extended_authorization': extendedAuthorization.toJson(),
    'fingerprint': fingerprint,
    'funding': funding,
    'incremental_authorization': incrementalAuthorization.toJson(),
    'installments': installments,
    'last4': last4,
    'mandate': mandate,
    'multicapture': multicapture.toJson(),
    'network': network,
    'network_token': networkToken.toJson(),
    'overcapture': overcapture.toJson(),
    'three_d_secure': threeDSecure,
    'wallet': wallet,
  };
}

class Checks {
  final dynamic addressLine1Check;
  final dynamic addressPostalCodeCheck;
  final String cvcCheck;

  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck = "",
  });

  factory Checks.fromJson(Map<String, dynamic>? json) => Checks(
    addressLine1Check: asT<dynamic>(json, 'address_line1_check'),
    addressPostalCodeCheck: asT<dynamic>(json, 'address_postal_code_check'),
    cvcCheck: asT<String>(json, 'cvc_check'),
  );

  Map<String, dynamic> toJson() => {
    'address_line1_check': addressLine1Check,
    'address_postal_code_check': addressPostalCodeCheck,
    'cvc_check': cvcCheck,
  };
}


class ExtendedAuthorization {
  final String status;

  ExtendedAuthorization({
    this.status = "",
  });

  factory ExtendedAuthorization.fromJson(Map<String, dynamic>? json) => ExtendedAuthorization(
    status: asT<String>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
  };
}


class IncrementalAuthorization {
  final String status;

  IncrementalAuthorization({
    this.status = "",
  });

  factory IncrementalAuthorization.fromJson(Map<String, dynamic>? json) => IncrementalAuthorization(
    status: asT<String>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
  };
}


class Multicapture {
  final String status;

  Multicapture({
    this.status = "",
  });

  factory Multicapture.fromJson(Map<String, dynamic>? json) => Multicapture(
    status: asT<String>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
  };
}


class NetworkToken {
  final bool used;

  NetworkToken({
    this.used = false,
  });

  factory NetworkToken.fromJson(Map<String, dynamic>? json) => NetworkToken(
    used: asT<bool>(json, 'used'),
  );

  Map<String, dynamic> toJson() => {
    'used': used,
  };
}


class Overcapture {
  final int maximumAmountCapturable;
  final String status;

  Overcapture({
    this.maximumAmountCapturable = 0,
    this.status = "",
  });

  factory Overcapture.fromJson(Map<String, dynamic>? json) => Overcapture(
    maximumAmountCapturable: asT<int>(json, 'maximum_amount_capturable'),
    status: asT<String>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'maximum_amount_capturable': maximumAmountCapturable,
    'status': status,
  };
}


class Refunds {
  final String object;
  final List<dynamic> data;
  final bool hasMore;
  final int totalCount;
  final String url;

  Refunds({
    this.object = "",
    required this.data,
    this.hasMore = false,
    this.totalCount = 0,
    this.url = "",
  });

  factory Refunds.fromJson(Map<String, dynamic>? json) => Refunds(
    object: asT<String>(json, 'object'),
    data: asT<List>(json, 'data').map((e) => e.toString()).toList(),
    hasMore: asT<bool>(json, 'has_more'),
    totalCount: asT<int>(json, 'total_count'),
    url: asT<String>(json, 'url'),
  );

  Map<String, dynamic> toJson() => {
    'object': object,
    'data': data.map((e) => e).toList(),
    'has_more': hasMore,
    'total_count': totalCount,
    'url': url,
  };
}


class Source {
  final String id;
  final String object;
  final dynamic addressCity;
  final dynamic addressCountry;
  final dynamic addressLine1;
  final dynamic addressLine1Check;
  final dynamic addressLine2;
  final dynamic addressState;
  final dynamic addressZip;
  final dynamic addressZipCheck;
  final String brand;
  final String country;
  final String customer;
  final String cvcCheck;
  final dynamic dynamicLast4;
  final int expMonth;
  final int expYear;
  final String fingerprint;
  final String funding;
  final String last4;
  final String name;
  final dynamic tokenizationMethod;
  final dynamic wallet;

  Source({
    this.id = "",
    this.object = "",
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    this.brand = "",
    this.country = "",
    this.customer = "",
    this.cvcCheck = "",
    this.dynamicLast4,
    this.expMonth = 0,
    this.expYear = 0,
    this.fingerprint = "",
    this.funding = "",
    this.last4 = "",
    this.name = "",
    this.tokenizationMethod,
    this.wallet,
  });

  factory Source.fromJson(Map<String, dynamic>? json) => Source(
    id: asT<String>(json, 'id'),
    object: asT<String>(json, 'object'),
    addressCity: asT<dynamic>(json, 'address_city'),
    addressCountry: asT<dynamic>(json, 'address_country'),
    addressLine1: asT<dynamic>(json, 'address_line1'),
    addressLine1Check: asT<dynamic>(json, 'address_line1_check'),
    addressLine2: asT<dynamic>(json, 'address_line2'),
    addressState: asT<dynamic>(json, 'address_state'),
    addressZip: asT<dynamic>(json, 'address_zip'),
    addressZipCheck: asT<dynamic>(json, 'address_zip_check'),
    brand: asT<String>(json, 'brand'),
    country: asT<String>(json, 'country'),
    customer: asT<String>(json, 'customer'),
    cvcCheck: asT<String>(json, 'cvc_check'),
    dynamicLast4: asT<dynamic>(json, 'dynamic_last4'),
    expMonth: asT<int>(json, 'exp_month'),
    expYear: asT<int>(json, 'exp_year'),
    fingerprint: asT<String>(json, 'fingerprint'),
    funding: asT<String>(json, 'funding'),
    last4: asT<String>(json, 'last4'),
    name: asT<String>(json, 'name'),
    tokenizationMethod: asT<dynamic>(json, 'tokenization_method'),
    wallet: asT<dynamic>(json, 'wallet'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'object': object,
    'address_city': addressCity,
    'address_country': addressCountry,
    'address_line1': addressLine1,
    'address_line1_check': addressLine1Check,
    'address_line2': addressLine2,
    'address_state': addressState,
    'address_zip': addressZip,
    'address_zip_check': addressZipCheck,
    'brand': brand,
    'country': country,
    'customer': customer,
    'cvc_check': cvcCheck,
    'dynamic_last4': dynamicLast4,
    'exp_month': expMonth,
    'exp_year': expYear,
    'fingerprint': fingerprint,
    'funding': funding,
    'last4': last4,
    'name': name,
    'tokenization_method': tokenizationMethod,
    'wallet': wallet,
  };
}

