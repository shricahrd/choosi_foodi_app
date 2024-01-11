/// meta : {"msg":" Updated Successfully ","status":true}
/// data : {"vendorId":"629459df46f536ddafd14f98","vendorDocument":["https://choosi-foodi-bucket.s3.amazonaws.com/vendorDocument-HGR27532140227E9G-1653889542698-721894.pdf"],"vendorImg":["https://choosi-foodi-bucket.s3.amazonaws.com/vendorImg-about-img%20-%20Copy-1653889542683-393245.png"],"otpVerified":true,"isLogin":true,"isAddedByAdmin":false,"isSignupComplete":true,"state":"PENDING","status":"ACTIVE","_id":"629459db19e22e36fcce42cc","mobile":"7491929040","__v":1,"createdAt":1653889499039,"mobileOtp":1234,"updatedAt":1657021580766,"email":"anwarul@test.com","password":"$2a$10$.ZNaHOFlMEWkdkPd6vbJZu7GMmAlvmzBa5CNSXZeyo1wyfgWZOHTC","vendorName":"Anwarul Haque","restaurantId":"62945a0746f536ddafd14f9d","id":"629459db19e22e36fcce42cc"}

class UpdateRestProfileModel {
  UpdateRestProfileModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  UpdateRestProfileModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
UpdateRestProfileModel copyWith({  Meta? meta,
  Data? data,
}) => UpdateRestProfileModel(  meta: meta ?? _meta,
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
/// updatedAt : 1657021580766
/// email : "anwarul@test.com"
/// password : "$2a$10$.ZNaHOFlMEWkdkPd6vbJZu7GMmAlvmzBa5CNSXZeyo1wyfgWZOHTC"
/// vendorName : "Anwarul Haque"
/// restaurantId : "62945a0746f536ddafd14f9d"
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
      String? password, 
      String? vendorName, 
      String? restaurantId, 
  }){
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
    _password = password;
    _vendorName = vendorName;
    _restaurantId = restaurantId;
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
  String? _password;
  String? _vendorName;
  String? _restaurantId;
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
  String? password,
  String? vendorName,
  String? restaurantId,
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
  password: password ?? _password,
  vendorName: vendorName ?? _vendorName,
  restaurantId: restaurantId ?? _restaurantId,
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
  String? get password => _password;
  String? get vendorName => _vendorName;
  String? get restaurantId => _restaurantId;

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

/// msg : " Updated Successfully "
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