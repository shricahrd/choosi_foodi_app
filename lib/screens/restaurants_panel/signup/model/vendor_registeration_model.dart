/// meta : {"msg":"Vendor added Successfully.","status":true}
/// data : {"vendorId":"62c977c7f06973e552e22d4b","otpVerified":true,"isLogin":false,"isAddedByAdmin":false,"isSignupComplete":true,"state":"PENDING","status":"DEACTIVE","_id":"62c977c0d22e352807dfae2a","mobile":"1111111111","__v":1,"createdAt":1657370560106,"mobileOtp":1234,"updatedAt":1657370572266,"email":"test@test.com","password":"$2a$10$ejh5GTuwyDya9wefG5QIeO/3a0izl2H4aU/rdByy41GttWe2ewilm","vendorName":"Aman","restaurantId":"62c977ccf06973e552e22d50","id":"62c977c0d22e352807dfae2a"}

class VendorRegisterationModel {
  VendorRegisterationModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  VendorRegisterationModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
VendorRegisterationModel copyWith({  Meta? meta,
  Data? data,
}) => VendorRegisterationModel(  meta: meta ?? _meta,
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

/// vendorId : "62c977c7f06973e552e22d4b"
/// otpVerified : true
/// isLogin : false
/// isAddedByAdmin : false
/// isSignupComplete : true
/// state : "PENDING"
/// status : "DEACTIVE"
/// _id : "62c977c0d22e352807dfae2a"
/// mobile : "1111111111"
/// __v : 1
/// createdAt : 1657370560106
/// mobileOtp : 1234
/// updatedAt : 1657370572266
/// email : "test@test.com"
/// password : "$2a$10$ejh5GTuwyDya9wefG5QIeO/3a0izl2H4aU/rdByy41GttWe2ewilm"
/// vendorName : "Aman"
/// restaurantId : "62c977ccf06973e552e22d50"
/// id : "62c977c0d22e352807dfae2a"

class Data {
  Data({
      String? vendorId, 
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
      String? password, 
      String? vendorName, 
      String? restaurantId, 
  }){
    _vendorId = vendorId;
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
    _password = password;
    _vendorName = vendorName;
    _restaurantId = restaurantId;
}

  Data.fromJson(dynamic json) {
    _vendorId = json['vendorId'];
    _otpVerified = json['otpVerified'];
    _isLogin = json['isLogin'];
    _isAddedByAdmin = json['isAddedByAdmin'];
    _isSignupComplete = json['isSignupComplete'];
    _state = json['state'];
    _status = json['status'];
    _id = json['_id'];
    _mobile = json['mobile'];
    _v = json['__v'];
    _createdAt = json['createdAt'];
    _mobileOtp = json['mobileOtp'];
    _updatedAt = json['updatedAt'];
    _email = json['email'];
    _password = json['password'];
    _vendorName = json['vendorName'];
    _restaurantId = json['restaurantId'];
  }
  String? _vendorId;
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
  String? _password;
  String? _vendorName;
  String? _restaurantId;
Data copyWith({  String? vendorId,
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
  String? password,
  String? vendorName,
  String? restaurantId,
}) => Data(  vendorId: vendorId ?? _vendorId,
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
  password: password ?? _password,
  vendorName: vendorName ?? _vendorName,
  restaurantId: restaurantId ?? _restaurantId,
);
  String? get vendorId => _vendorId;
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
  String? get password => _password;
  String? get vendorName => _vendorName;
  String? get restaurantId => _restaurantId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorId'] = _vendorId;
    map['otpVerified'] = _otpVerified;
    map['isLogin'] = _isLogin;
    map['isAddedByAdmin'] = _isAddedByAdmin;
    map['isSignupComplete'] = _isSignupComplete;
    map['state'] = _state;
    map['status'] = _status;
    map['_id'] = _id;
    map['mobile'] = _mobile;
    map['__v'] = _v;
    map['createdAt'] = _createdAt;
    map['mobileOtp'] = _mobileOtp;
    map['updatedAt'] = _updatedAt;
    map['email'] = _email;
    map['password'] = _password;
    map['vendorName'] = _vendorName;
    map['restaurantId'] = _restaurantId;
    return map;
  }

}

/// msg : "Vendor added Successfully."
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