import '../../../home/model/safe_convert.dart';

class SaleHistoryModel {
  final Meta? meta;
  final List<DataItem>? data;
  final int pages;
  final int total;

  SaleHistoryModel({
     this.meta,
     this.data,
    this.pages = 0,
    this.total = 0,
  });

  factory SaleHistoryModel.fromJson(Map<String, dynamic>? json) => SaleHistoryModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => DataItem.fromJson(e)).toList(),
    pages: asT<int>(json, 'pages'),
    total: asT<int>(json, 'total'),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
    'pages': pages,
    'total': total,
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


class DataItem {
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
  final String deviceType;
  final String restaurantId;
  final RestaurantData restaurantData;
  final int deliveryCharges;
  final int tax;
  final double taxAmount;
  final int createdAt;
  final int updatedAt;
  final int v;

  DataItem({
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
    this.deviceType = "",
    this.restaurantId = "",
    required this.restaurantData,
    this.deliveryCharges = 0,
    this.tax = 0,
    this.taxAmount = 0.0,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
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
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    tax: asT<int>(json, 'tax'),
    taxAmount: asT<double>(json, 'taxAmount'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
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
    'restaurantId': restaurantId,
    'restaurantData': restaurantData.toJson(),
    'deliveryCharges': deliveryCharges,
    'tax': tax,
    'taxAmount': taxAmount,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class ProductDetailsItem {
  final String cartId;
  final String id;
  final String menuId;
  final int selectQuantity;
  final String dishName;
  final int price;
  final int specialPrice;

  ProductDetailsItem({
    this.cartId = "",
    this.id = "",
    this.menuId = "",
    this.selectQuantity = 0,
    this.dishName = "",
    this.price = 0,
    this.specialPrice = 0,
  });

  factory ProductDetailsItem.fromJson(Map<String, dynamic>? json) => ProductDetailsItem(
    cartId: asT<String>(json, 'cartId'),
    id: asT<String>(json, '_id'),
    menuId: asT<String>(json, 'menuId'),
    selectQuantity: asT<int>(json, 'selectQuantity'),
    dishName: asT<String>(json, 'dishName'),
    price: asT<int>(json, 'price'),
    specialPrice: asT<int>(json, 'specialPrice'),
  );

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    '_id': id,
    'menuId': menuId,
    'selectQuantity': selectQuantity,
    'dishName': dishName,
    'price': price,
    'specialPrice': specialPrice,
  };
}


class UserData {
  final String userId;
  final String id;
  final String firstName;
  final String lastName;
  final String paymentMethod;
  final ShippingAddress shippingAddress;
  final int total;
  final int subTotal;
  final String menuOrderID;
  final int deliveryCharge;
  final int couponDiscount;
  final int deliveryDate;
  final String specialRequest;
  final String deviceType;
  final String restaurantId;
  final RestaurantData restaurantData;
  final PaymentDetails paymentDetails;
  final int deliveryCharges;
  final int tax;
  final int taxAmount;
  final int createdAt;
  final int updatedAt;
  final int v;

  UserData({
    this.userId = "",
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.paymentMethod = "",
    required this.shippingAddress,
    this.total = 0,
    this.subTotal = 0,
    this.menuOrderID = "",
    this.deliveryCharge = 0,
    this.couponDiscount = 0,
    this.deliveryDate = 0,
    this.specialRequest = "",
    this.deviceType = "",
    this.restaurantId = "",
    required this.restaurantData,
    required this.paymentDetails,
    this.deliveryCharges = 0,
    this.tax = 0,
    this.taxAmount = 0,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory UserData.fromJson(Map<String, dynamic>? json) => UserData(
    userId: asT<String>(json, 'userId'),
    id: asT<String>(json, '_id'),
    firstName: asT<String>(json, 'firstName'),
    lastName: asT<String>(json, 'lastName'),
    paymentMethod: asT<String>(json, 'paymentMethod'),
    shippingAddress: ShippingAddress.fromJson(asT<Map<String, dynamic>>(json, 'shippingAddress')),
    total: asT<int>(json, 'total'),
    subTotal: asT<int>(json, 'subTotal'),
    menuOrderID: asT<String>(json, 'menuOrderID'),
    deliveryCharge: asT<int>(json, 'deliveryCharge'),
    couponDiscount: asT<int>(json, 'couponDiscount'),
    deliveryDate: asT<int>(json, 'deliveryDate'),
    specialRequest: asT<String>(json, 'specialRequest'),
    deviceType: asT<String>(json, 'deviceType'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    paymentDetails: PaymentDetails.fromJson(asT<Map<String, dynamic>>(json, 'paymentDetails')),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    tax: asT<int>(json, 'tax'),
    taxAmount: asT<int>(json, 'taxAmount'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'paymentMethod': paymentMethod,
    'shippingAddress': shippingAddress.toJson(),
    'total': total,
    'subTotal': subTotal,
    'menuOrderID': menuOrderID,
    'deliveryCharge': deliveryCharge,
    'couponDiscount': couponDiscount,
    'deliveryDate': deliveryDate,
    'specialRequest': specialRequest,
    'deviceType': deviceType,
    'restaurantId': restaurantId,
    'restaurantData': restaurantData.toJson(),
    'paymentDetails': paymentDetails.toJson(),
    'deliveryCharges': deliveryCharges,
    'tax': tax,
    'taxAmount': taxAmount,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class ShippingAddress {
  final String addressId;
  final String id;
  final String userId;
  final int pincode;
  final String cityName;
  final int createdAt;
  final int updatedAt;
  final int v;

  ShippingAddress({
    this.addressId = "",
    this.id = "",
    this.userId = "",
    this.pincode = 0,
    this.cityName = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic>? json) => ShippingAddress(
    addressId: asT<String>(json, 'addressId'),
    id: asT<String>(json, '_id'),
    userId: asT<String>(json, 'userId'),
    pincode: asT<int>(json, 'pincode'),
    cityName: asT<String>(json, 'cityName'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'addressId': addressId,
    '_id': id,
    'userId': userId,
    'pincode': pincode,
    'cityName': cityName,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}


class RestaurantData {
  final String id;
  final String restaurantId;
  final String state;
  final String status;
  final String vendorId;
  final int mobile;
  final String vendorName;
  final String email;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String restaurantName;
  final int deliveryCharges;

  RestaurantData({
    this.id = "",
    this.restaurantId = "",
    this.state = "",
    this.status = "",
    this.vendorId = "",
    this.mobile = 0,
    this.vendorName = "",
    this.email = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.restaurantName = "",
    this.deliveryCharges = 0,
  });

  factory RestaurantData.fromJson(Map<String, dynamic>? json) => RestaurantData(
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    vendorId: asT<String>(json, 'vendorId'),
    mobile: asT<int>(json, 'mobile'),
    vendorName: asT<String>(json, 'vendorName'),
    email: asT<String>(json, 'email'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    restaurantName: asT<String>(json, 'restaurantName'),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'restaurantId': restaurantId,
    'state': state,
    'status': status,
    'vendorId': vendorId,
    'mobile': mobile,
    'vendorName': vendorName,
    'email': email,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'restaurantName': restaurantName,
    'deliveryCharges': deliveryCharges,
  };
}


class PaymentDetails {
  final String receiptUrl;

  PaymentDetails({
    this.receiptUrl = "",
  });

  factory PaymentDetails.fromJson(Map<String, dynamic>? json) => PaymentDetails(
    receiptUrl: asT<String>(json, 'receipt_url'),
  );

  Map<String, dynamic> toJson() => {
    'receipt_url': receiptUrl,
  };
}


