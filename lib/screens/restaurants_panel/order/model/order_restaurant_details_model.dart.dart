

import '../../../home/model/safe_convert.dart';

class OrderRestDetailsModel {
  final Meta? meta;
  final Data? data;

  OrderRestDetailsModel({
     this.meta,
     this.data,
  });

  factory OrderRestDetailsModel.fromJson(Map<String, dynamic>? json) => OrderRestDetailsModel(
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
  final String menuOrderId;
  final int orderStatus;
  final List<ProductDetailsItem> productDetails;
  final String id;
  final String orderType;
  final String userId;
  final UserData userData;
  final int mobile;
  final String paymentMethod;
  final double total;
  final int subTotal;
  final String menuOrderID;
  final int deliveryCharge;
  final int couponDiscount;
  final int deliveryDate;
  final String timeSlot;
  final String deviceType;
  final String restaurantId;
  final RestaurantData restaurantData;
  final PaymentDetails paymentDetails;
  final int deliveryCharges;
  final int tax;
  final double taxAmount;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String cancelReason;

  Data({
    this.menuOrderId = "",
    this.orderStatus = 0,
    required this.productDetails,
    this.id = "",
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
    this.timeSlot = "",
    this.deviceType = "",
    this.restaurantId = "",
    required this.restaurantData,
    required this.paymentDetails,
    this.deliveryCharges = 0,
    this.tax = 0,
    this.taxAmount = 0.0,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.cancelReason = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    menuOrderId: asT<String>(json, 'menuOrderId'),
    orderStatus: asT<int>(json, 'orderStatus'),
    productDetails: asT<List>(json, 'productDetails').map((e) => ProductDetailsItem.fromJson(e)).toList(),
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
    timeSlot: asT<String>(json, 'timeSlot'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    paymentDetails: PaymentDetails.fromJson(asT<Map<String, dynamic>>(json, 'paymentDetails')),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    tax: asT<int>(json, 'tax'),
    taxAmount: asT<double>(json, 'taxAmount'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    cancelReason: asT<String>(json, 'cancelReason'),
  );

  Map<String, dynamic> toJson() => {
    'menuOrderId': menuOrderId,
    'orderStatus': orderStatus,
    'productDetails': productDetails.map((e) => e.toJson()).toList(),
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
    'timeSlot': timeSlot,
    'restaurantId': restaurantId,
    'restaurantData': restaurantData.toJson(),
    'paymentDetails': paymentDetails.toJson(),
    'deliveryCharges': deliveryCharges,
    'tax': tax,
    'taxAmount': taxAmount,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'cancelReason': cancelReason,
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
  int price;
  final int specialPrice;

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
    'specialPrice': specialPrice,
  };
}


class UserData {
  final String userId;
  final bool isLogin;
  final bool isMobileOtpValid;
  final bool otpVerified;
  final String activityLevel;
  final String status;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String deviceToken;

  UserData({
    this.userId = "",
    this.isLogin = false,
    this.isMobileOtpValid = false,
    this.otpVerified = false,
    this.activityLevel = "",
    this.status = "",
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.mobile = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.deviceToken = "",
  });

  factory UserData.fromJson(Map<String, dynamic>? json) => UserData(
    userId: asT<String>(json, 'userId'),
    isLogin: asT<bool>(json, 'isLogin'),
    isMobileOtpValid: asT<bool>(json, 'isMobileOtpValid'),
    otpVerified: asT<bool>(json, 'otpVerified'),
    activityLevel: asT<String>(json, 'activityLevel'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    firstName: asT<String>(json, 'firstName'),
    lastName: asT<String>(json, 'lastName'),
    email: asT<String>(json, 'email'),
    mobile: asT<String>(json, 'mobile'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    deviceToken: asT<String>(json, 'deviceToken'),
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'isLogin': isLogin,
    'isMobileOtpValid': isMobileOtpValid,
    'otpVerified': otpVerified,
    'activityLevel': activityLevel,
    'status': status,
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'mobile': mobile,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'deviceToken': deviceToken,
  };
}


class RestaurantData {
  final String id;
  final String restaurantId;
  final List<String> restaurantImg;
  final List<dynamic> restaurantDocument;
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
  final List<dynamic> coordinates;
  final String managerMobile;
  final String managerName;
  final String restaurantAddress;
  final String restaurantName;
  final int deliveryCharges;

  RestaurantData({
    this.id = "",
    this.restaurantId = "",
    required this.restaurantImg,
    required this.restaurantDocument,
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
  });

  factory RestaurantData.fromJson(Map<String, dynamic>? json) => RestaurantData(
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantImg: asT<List>(json, 'restaurantImg').map((e) => e.toString()).toList(),
    restaurantDocument: asT<List>(json, 'restaurantDocument').map((e) => e.toString()).toList(),
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
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'restaurantId': restaurantId,
    'restaurantImg': restaurantImg.map((e) => e).toList(),
    'restaurantDocument': restaurantDocument.map((e) => e).toList(),
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
  };
}


class PaymentDetails {
  final String id;
  final String object;
  final int amount;
  final int amountCaptured;
  final int amountRefunded;
  final String balanceTransaction;
  final BillingDetails billingDetails;
  final String calculatedStatementDescriptor;
  final bool captured;
  final int created;
  final String currency;
  final String customer;
  final String description;
  final dynamic order;
  final Outcome outcome;
  final bool paid;
  final String paymentMethod;
  final String receiptUrl;

  PaymentDetails({
    this.id = "",
    this.object = "",
    this.amount = 0,
    this.amountCaptured = 0,
    this.amountRefunded = 0,
    this.balanceTransaction = "",
    required this.billingDetails,
    this.calculatedStatementDescriptor = "",
    this.captured = false,
    this.created = 0,
    this.currency = "",
    this.customer = "",
    this.description = "",
    this.order,
    required this.outcome,
    this.paid = false,
    this.paymentMethod = "",
    this.receiptUrl = "",
  });

  factory PaymentDetails.fromJson(Map<String, dynamic>? json) => PaymentDetails(
    id: asT<String>(json, 'id'),
    object: asT<String>(json, 'object'),
    amount: asT<int>(json, 'amount'),
    amountCaptured: asT<int>(json, 'amount_captured'),
    amountRefunded: asT<int>(json, 'amount_refunded'),
    balanceTransaction: asT<String>(json, 'balance_transaction'),
    billingDetails: BillingDetails.fromJson(asT<Map<String, dynamic>>(json, 'billing_details')),
    calculatedStatementDescriptor: asT<String>(json, 'calculated_statement_descriptor'),
    captured: asT<bool>(json, 'captured'),
    created: asT<int>(json, 'created'),
    currency: asT<String>(json, 'currency'),
    customer: asT<String>(json, 'customer'),
    description: asT<String>(json, 'description'),
    order: asT<dynamic>(json, 'order'),
    outcome: Outcome.fromJson(asT<Map<String, dynamic>>(json, 'outcome')),
    paid: asT<bool>(json, 'paid'),
    paymentMethod: asT<String>(json, 'payment_method'),
    receiptUrl: asT<String>(json, 'receipt_url'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'object': object,
    'amount': amount,
    'amount_captured': amountCaptured,
    'amount_refunded': amountRefunded,
    'balance_transaction': balanceTransaction,
    'billing_details': billingDetails.toJson(),
    'calculated_statement_descriptor': calculatedStatementDescriptor,
    'captured': captured,
    'created': created,
    'currency': currency,
    'customer': customer,
    'description': description,
    'order': order,
    'outcome': outcome.toJson(),
    'paid': paid,
    'payment_method': paymentMethod,
    'receipt_url': receiptUrl,
  };
}

class BillingDetails {
  final Address address;

  BillingDetails({
    required this.address,
  });

  factory BillingDetails.fromJson(Map<String, dynamic>? json) => BillingDetails(
    address: Address.fromJson(asT<Map<String, dynamic>>(json, 'address')),
  );

  Map<String, dynamic> toJson() => {
    'address': address.toJson(),
  };
}

class Address {
  final String city;
  final String country;
  final String line1;
  final String line2;
  final String postalCode;
  final String state;

  Address({
    this.city = "",
    this.country = "",
    this.line1 = "",
    this.line2 = "",
    this.postalCode = "",
    this.state = "",
  });

  factory Address.fromJson(Map<String, dynamic>? json) => Address(
    city: asT<String>(json, 'city'),
    country: asT<String>(json, 'country'),
    line1: asT<String>(json, 'line1'),
    line2: asT<String>(json, 'line2'),
    postalCode: asT<String>(json, 'postal_code'),
    state: asT<String>(json, 'state'),
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

