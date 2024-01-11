

import 'safe_convert.dart';

class GetGODetailsModel {
  final Meta? meta;
  final Data? data;

  GetGODetailsModel({
     this.meta,
     this.data,
  });

  factory GetGODetailsModel.fromJson(Map<String, dynamic>? json) => GetGODetailsModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: Data.fromJson(asT<Map<String, dynamic>>(json, 'data')),
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


class Data {
  final String id;
  final String groupOrderId;
  final int orderStatus;
  // final ProductDetails productDetails;
  final List<ProductDetails> productDetails;
  final List<dynamic> coordinates;
  final int deliveryCharges;
  final String orderType;
  final String groupId;
  final GroupData groupData;
  final String userId;
  final UserData userData;
  final int mobile;
  final String paymentMethod;
  final String shippingAddress;
  final dynamic total;
  final dynamic subTotal;
  final String groupOrderID;
  final int couponDiscount;
  final String deviceType;
  final String restaurantId;
  final String cancelReason;
  final RestaurantData? restaurantData;
  final int tax;
  final int taxAmount;
  final int createdAt;
  final int deliveryDate;
  final int updatedAt;
  final int participants;

  Data({
    this.id = "",
    this.groupOrderId = "",
    this.orderStatus = 0,
    required this.productDetails,
    required this.coordinates,
    this.deliveryCharges = 0,
    this.orderType = "",
    this.groupId = "",
    required this.groupData,
    this.userId = "",
    required this.userData,
    this.mobile = 0,
    this.paymentMethod = "",
    this.shippingAddress = "",
    this.total = 0,
    this.subTotal = 0,
    this.groupOrderID = "",
    this.couponDiscount = 0,
    this.deviceType = "",
    this.restaurantId = "",
    this.cancelReason = "",
    this.restaurantData,
    this.tax = 0,
    this.taxAmount = 0,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.deliveryDate = 0,
    this.participants = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    id: asT<String>(json, '_id'),
    groupOrderId: asT<String>(json, 'groupOrderId'),
    orderStatus: asT<int>(json, 'orderStatus'),
    // productDetails: ProductDetails.fromJson(asT<Map<String, dynamic>>(json, 'productDetails')),
    productDetails: asT<List>(json, 'productDetails').map((e) => ProductDetails.fromJson(e)).toList(),
    coordinates: asT<List>(json, 'coordinates').map((e) => e.toString()).toList(),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    orderType: asT<String>(json, 'orderType'),
    groupId: asT<String>(json, 'groupId'),
    groupData: GroupData.fromJson(asT<Map<String, dynamic>>(json, 'groupData')),
    userId: asT<String>(json, 'userId'),
    userData: UserData.fromJson(asT<Map<String, dynamic>>(json, 'userData')),
    mobile: asT<int>(json, 'mobile'),
    paymentMethod: asT<String>(json, 'paymentMethod'),
    shippingAddress: asT<String>(json, 'shippingAddress'),
    total: asT<int>(json, 'total'),
    subTotal: asT<int>(json, 'subTotal'),
    groupOrderID: asT<String>(json, 'groupOrderID'),
    couponDiscount: asT<int>(json, 'couponDiscount'),
    deviceType: asT<String>(json, 'deviceType'),
    restaurantId: asT<String>(json, 'restaurantId'),
    cancelReason: asT<String>(json, 'cancelReason'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    tax: asT<int>(json, 'tax'),
    taxAmount: asT<int>(json, 'taxAmount'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    deliveryDate: asT<int>(json, 'deliveryDate'),
    participants: asT<int>(json, 'participants'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'groupOrderId': groupOrderId,
    'orderStatus': orderStatus,
    // 'productDetails': productDetails.toJson(),
    'productDetails': productDetails.map((e) => e.toJson()),
    'coordinates': coordinates.map((e) => e),
    'deliveryCharges': deliveryCharges,
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
    'deviceType': deviceType,
    'restaurantId': restaurantId,
    'cancelReason': cancelReason,
    'restaurantData': restaurantData?.toJson(),
    'tax': tax,
    'taxAmount': taxAmount,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deliveryDate': deliveryDate,
    'participants': participants,
  };
}

class ProductDetails {
  final String id;
  final String groupCartId;
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

  ProductDetails({
    this.id = "",
    this.groupCartId = "",
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

  factory ProductDetails.fromJson(Map<String, dynamic>? json) => ProductDetails(
    id: asT<String>(json, '_id'),
    groupCartId: asT<String>(json, 'groupCartId'),
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
    'adminUserId': adminUserId,
    'adminUserName': adminUserName,
    'userId': userId,
    'name': name,
    'groupId': groupId,
    'groupName': groupName,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'cartMenu': cartMenu.map((e) => e.toJson()),
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
  final int price;
  final String calories;
  final String carbs;
  final String fat;
  final String protein;
  dynamic caloriesTotal;
  dynamic fatTotal;
  dynamic carbsTotal;
  dynamic proteinTotal;

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
    this.caloriesTotal = 0.0,
    this.fatTotal = 0.0,
    this.carbsTotal = 0.0,
    this.proteinTotal = 0.0,
  });

  set setCaloriesTotal(dynamic value){
    this.caloriesTotal = value;
  }

  set setCarbsTotal(dynamic value){
    this.carbsTotal = value;
  }

  set setProteinTotal(dynamic value){
    this.proteinTotal = value;
  }
  set setFatTotal(dynamic value){
    this.fatTotal = value;
  }


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
    caloriesTotal: asT<dynamic>(json, 'caloriesTotal'),
    carbsTotal: asT<dynamic>(json, 'carbsTotal'),
    proteinTotal: asT<dynamic>(json, 'proteinTotal'),
    fatTotal: asT<dynamic>(json, 'fatTotal'),
  );

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e),
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
    'caloriesTotal' :caloriesTotal,
    'carbsTotal' :carbsTotal,
    'proteinTotal' :proteinTotal,
    'fatTotal' :fatTotal,
  };
}


class GroupData {
  final String groupId;
  final String orderType;
  final String paidBy;
  final String id;
  final String userId;
  final String name;
  final int mobile;
  final String restaurantId;
  final String restaurantName;
  final String groupName;
  final int spendingLimit;
  final String address;
  final List<InvitedMemberItem>? invitedMember;
  final List<JoinMemberItem>? joinedMember;
  final int createdAt;
  final int updatedAt;
  final int v;

  GroupData({
    this.groupId = "",
    this.orderType = "",
    this.paidBy = "",
    this.id = "",
    this.userId = "",
    this.name = "",
    this.mobile = 0,
    this.restaurantId = "",
    this.restaurantName = "",
    this.groupName = "",
    this.spendingLimit = 0,
    this.address = "",
    this.invitedMember,
    this.joinedMember,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory GroupData.fromJson(Map<String, dynamic>? json) => GroupData(
    groupId: asT<String>(json, 'groupId'),
    orderType: asT<String>(json, 'orderType'),
    paidBy: asT<String>(json, 'paidBy'),
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
    joinedMember: asT<List>(json, 'joinedMember').map((e) => JoinMemberItem.fromJson(e)).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'orderType': orderType,
    'paidBy': paidBy,
    '_id': id,
    'userId': userId,
    'name': name,
    'mobile': mobile,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'groupName': groupName,
    'spendingLimit': spendingLimit,
    'address': address,
    'invitedMember': invitedMember?.map((e) => e.toJson()),
    'joinedMember': joinedMember?.map((e) => e.toJson()),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class InvitedMemberItem {
  final String id;
  final String userId;
  final String name;
  final String mobile;

  InvitedMemberItem({
    this.id = "",
    this.userId = "",
    this.name = "",
    this.mobile = "",
  });

  factory InvitedMemberItem.fromJson(Map<String, dynamic>? json) => InvitedMemberItem(
    id: asT<String>(json, '_id'),
    userId: asT<String>(json, 'userId'),
    name: asT<String>(json, 'name'),
    mobile: asT<String>(json, 'mobile'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'name': name,
    'mobile': mobile,
  };
}

class JoinMemberItem {
  final String id;
  final String userId;
  final String name;
  final String mobile;

  JoinMemberItem({
    this.id = "",
    this.userId = "",
    this.name = "",
    this.mobile = "",
  });

  factory JoinMemberItem.fromJson(Map<String, dynamic>? json) => JoinMemberItem(
    id: asT<String>(json, '_id'),
    userId: asT<String>(json, 'userId'),
    name: asT<String>(json, 'name'),
    mobile: asT<String>(json, 'mobile'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'name': name,
    'mobile': mobile,
  };
}


class UserData {
  final String userId;
  final bool isLogin;
  final bool isMobileOtpValid;
  final bool otpVerified;
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
  final String profilePic;
  final dynamic otp;

  UserData({
    this.userId = "",
    this.isLogin = false,
    this.isMobileOtpValid = false,
    this.otpVerified = false,
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
    this.profilePic = "",
    this.otp,
  });

  factory UserData.fromJson(Map<String, dynamic>? json) => UserData(
    userId: asT<String>(json, 'userId'),
    isLogin: asT<bool>(json, 'isLogin'),
    isMobileOtpValid: asT<bool>(json, 'isMobileOtpValid'),
    otpVerified: asT<bool>(json, 'otpVerified'),
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
    profilePic: asT<String>(json, 'profilePic'),
    otp: asT<dynamic>(json, 'otp'),
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'isLogin': isLogin,
    'isMobileOtpValid': isMobileOtpValid,
    'otpVerified': otpVerified,
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
    'profilePic': profilePic,
    'otp': otp,
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
  final List<TreeItem> tree;
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
  final String managerMobile;
  final String managerName;
  final String restaurantAddress;
  final String restaurantName;

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
    this.managerMobile = "",
    this.managerName = "",
    this.restaurantAddress = "",
    this.restaurantName = "",
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
    tree: asT<List>(json, 'tree').map((e) => TreeItem.fromJson(e)).toList(),
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
    managerMobile: asT<String>(json, 'managerMobile'),
    managerName: asT<String>(json, 'managerName'),
    restaurantAddress: asT<String>(json, 'restaurantAddress'),
    restaurantName: asT<String>(json, 'restaurantName'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'bankInformation': bankInformation.toJson(),
    'timings': timings.toJson(),
    'restaurantId': restaurantId,
    'menuIds': menuIds.map((e) => e),
    'isAssigned': isAssigned,
    'isAssignedToHotel': isAssignedToHotel,
    'priceForTwo': priceForTwo,
    'menuImg': menuImg.map((e) => e),
    'tree': tree.map((e) => e.toJson()),
    'rootCategoryIds': rootCategoryIds.map((e) => e),
    'categoryIds': categoryIds.map((e) => e),
    'foodTypes': foodTypes.map((e) => e),
    'subCategoryIds': subCategoryIds.map((e) => e),
    'restaurantImg': restaurantImg.map((e) => e),
    'restaurantDocument': restaurantDocument.map((e) => e),
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
    'managerMobile': managerMobile,
    'managerName': managerName,
    'restaurantAddress': restaurantAddress,
    'restaurantName': restaurantName,
  };
}

class BankInformation {
  final String bankName;
  final String branchName;
  final String accountNumber;
  final String holderName;
  final String abaNumber;
  final String routingNumber;

  BankInformation({
    this.bankName = "",
    this.branchName = "",
    this.accountNumber = "",
    this.holderName = "",
    this.abaNumber = "",
    this.routingNumber = "",
  });

  factory BankInformation.fromJson(Map<String, dynamic>? json) => BankInformation(
    bankName: asT<String>(json, 'bankName'),
    branchName: asT<String>(json, 'branchName'),
    accountNumber: asT<String>(json, 'accountNumber'),
    holderName: asT<String>(json, 'holderName'),
    abaNumber: asT<String>(json, 'abaNumber'),
    routingNumber: asT<String>(json, 'routingNumber'),
  );

  Map<String, dynamic> toJson() => {
    'bankName': bankName,
    'branchName': branchName,
    'accountNumber': accountNumber,
    'holderName': holderName,
    'abaNumber': abaNumber,
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


class TreeItem {
  final String id;
  final String categoryId;
  final int commission;
  final String status;
  final String type;
  final bool isCompare;
  final bool isFeaturedWeb;
  final bool isCategoryWebNav;
  final bool isCategoryMobile;
  final bool isCategoryMobileNav;
  final String categoryName;
  final String url;
  final int tax;
  final String categoryImg;
  final int createdAt;
  final int updatedAt;
  final int v;
  final List<SubcategoryItem> subcategory;
  final bool checked;

  TreeItem({
    this.id = "",
    this.categoryId = "",
    this.commission = 0,
    this.status = "",
    this.type = "",
    this.isCompare = false,
    this.isFeaturedWeb = false,
    this.isCategoryWebNav = false,
    this.isCategoryMobile = false,
    this.isCategoryMobileNav = false,
    this.categoryName = "",
    this.url = "",
    this.tax = 0,
    this.categoryImg = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    required this.subcategory,
    this.checked = false,
  });

  factory TreeItem.fromJson(Map<String, dynamic>? json) => TreeItem(
    id: asT<String>(json, '_id'),
    categoryId: asT<String>(json, 'categoryId'),
    commission: asT<int>(json, 'commission'),
    status: asT<String>(json, 'status'),
    type: asT<String>(json, 'type'),
    isCompare: asT<bool>(json, 'isCompare'),
    isFeaturedWeb: asT<bool>(json, 'isFeaturedWeb'),
    isCategoryWebNav: asT<bool>(json, 'isCategoryWebNav'),
    isCategoryMobile: asT<bool>(json, 'isCategoryMobile'),
    isCategoryMobileNav: asT<bool>(json, 'isCategoryMobileNav'),
    categoryName: asT<String>(json, 'categoryName'),
    url: asT<String>(json, 'url'),
    tax: asT<int>(json, 'tax'),
    categoryImg: asT<String>(json, 'categoryImg'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    subcategory: asT<List>(json, 'subcategory').map((e) => SubcategoryItem.fromJson(e)).toList(),
    checked: asT<bool>(json, 'checked'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'categoryId': categoryId,
    'commission': commission,
    'status': status,
    'type': type,
    'isCompare': isCompare,
    'isFeaturedWeb': isFeaturedWeb,
    'isCategoryWebNav': isCategoryWebNav,
    'isCategoryMobile': isCategoryMobile,
    'isCategoryMobileNav': isCategoryMobileNav,
    'categoryName': categoryName,
    'url': url,
    'tax': tax,
    'categoryImg': categoryImg,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'subcategory': subcategory.map((e) => e.toJson()),
    'checked': checked,
  };
}

class SubcategoryItem {
  final String id;
  final String categoryId;
  final int commission;
  final String status;
  final String type;
  final bool isCompare;
  final bool isFeaturedWeb;
  final bool isCategoryWebNav;
  final bool isCategoryMobile;
  final bool isCategoryMobileNav;
  final String parentId;
  final String categoryName;
  final String categoryImg;
  final int createdAt;
  final int updatedAt;
  final int v;
  final List<dynamic> subcategory;

  SubcategoryItem({
    this.id = "",
    this.categoryId = "",
    this.commission = 0,
    this.status = "",
    this.type = "",
    this.isCompare = false,
    this.isFeaturedWeb = false,
    this.isCategoryWebNav = false,
    this.isCategoryMobile = false,
    this.isCategoryMobileNav = false,
    this.parentId = "",
    this.categoryName = "",
    this.categoryImg = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    required this.subcategory,
  });

  factory SubcategoryItem.fromJson(Map<String, dynamic>? json) => SubcategoryItem(
    id: asT<String>(json, '_id'),
    categoryId: asT<String>(json, 'categoryId'),
    commission: asT<int>(json, 'commission'),
    status: asT<String>(json, 'status'),
    type: asT<String>(json, 'type'),
    isCompare: asT<bool>(json, 'isCompare'),
    isFeaturedWeb: asT<bool>(json, 'isFeaturedWeb'),
    isCategoryWebNav: asT<bool>(json, 'isCategoryWebNav'),
    isCategoryMobile: asT<bool>(json, 'isCategoryMobile'),
    isCategoryMobileNav: asT<bool>(json, 'isCategoryMobileNav'),
    parentId: asT<String>(json, 'parentId'),
    categoryName: asT<String>(json, 'categoryName'),
    categoryImg: asT<String>(json, 'categoryImg'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    subcategory: asT<List>(json, 'subcategory').map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'categoryId': categoryId,
    'commission': commission,
    'status': status,
    'type': type,
    'isCompare': isCompare,
    'isFeaturedWeb': isFeaturedWeb,
    'isCategoryWebNav': isCategoryWebNav,
    'isCategoryMobile': isCategoryMobile,
    'isCategoryMobileNav': isCategoryMobileNav,
    'parentId': parentId,
    'categoryName': categoryName,
    'categoryImg': categoryImg,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'subcategory': subcategory.map((e) => e),
  };
}

