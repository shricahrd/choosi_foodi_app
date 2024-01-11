/// meta : {"msg":"Profile data found successfully","status":true}
/// data : {"userId":"62a9b0049ba9e2ddb65144a3","gender":"N/A","userGoal":"LOSE WEIGHT","activityLevel":"LIGHT","status":"ACTIVE","firstName":"Sandip","lastName":"Gohil","email":"sandip.mobisharnam@gmail.com","mobile":"8200970294","createdAt":1655287812688,"updatedAt":1655710752157,"__v":0,"profilePic":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/profilePic-Screenshot%202022-06-15%20at%207.19.37%20PM-1655357976939-737802.png","otp":null}

class UserProfileModel {
  UserProfileModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  UserProfileModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
UserProfileModel copyWith({  Meta? meta,
  Data? data,
}) => UserProfileModel(  meta: meta ?? _meta,
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

/// userId : "62a9b0049ba9e2ddb65144a3"
/// gender : "N/A"
/// userGoal : "LOSE WEIGHT"
/// activityLevel : "LIGHT"
/// status : "ACTIVE"
/// firstName : "Sandip"
/// lastName : "Gohil"
/// email : "sandip.mobisharnam@gmail.com"
/// mobile : "8200970294"
/// createdAt : 1655287812688
/// updatedAt : 1655710752157
/// __v : 0
/// profilePic : "https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/profilePic-Screenshot%202022-06-15%20at%207.19.37%20PM-1655357976939-737802.png"
/// otp : null

class Data {
  Data({
      String? userId, 
      String? gender, 
      String? userGoal, 
      String? activityLevel, 
      String? status, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile,
      int? createdAt,
      int? updatedAt, 
      int? totalMenuOrder,
      int? v,
      String? profilePic, 
      dynamic otp,}){
    _userId = userId;
    _gender = gender;
    _userGoal = userGoal;
    _activityLevel = activityLevel;
    _status = status;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _totalMenuOrder = totalMenuOrder;
    _v = v;
    _profilePic = profilePic;
    _otp = otp;
}

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _gender = json['gender'];
    _userGoal = json['userGoal'];
    _activityLevel = json['activityLevel'];
    _status = json['status'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _mobile = json['mobile'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _totalMenuOrder = json['totalMenuOrder'];
    _v = json['__v'];
    _profilePic = json['profilePic'];
    _otp = json['otp'];
  }
  String? _userId;
  String? _gender;
  String? _userGoal;
  String? _activityLevel;
  String? _status;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  int? _createdAt;
  int? _updatedAt;
  int? _totalMenuOrder;
  int? _v;
  String? _profilePic;
  dynamic _otp;
Data copyWith({  String? userId,
  String? gender,
  String? userGoal,
  String? activityLevel,
  String? status,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  int? createdAt,
  int? updatedAt,
  int? totalMenuOrder,
  int? v,
  String? profilePic,
  dynamic otp,
}) => Data(  userId: userId ?? _userId,
  gender: gender ?? _gender,
  userGoal: userGoal ?? _userGoal,
  activityLevel: activityLevel ?? _activityLevel,
  status: status ?? _status,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  totalMenuOrder: totalMenuOrder ?? _totalMenuOrder,
  v: v ?? _v,
  profilePic: profilePic ?? _profilePic,
  otp: otp ?? _otp,
);
  String? get userId => _userId;
  String? get gender => _gender;
  String? get userGoal => _userGoal;
  String? get activityLevel => _activityLevel;
  String? get status => _status;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get totalMenuOrder => _totalMenuOrder;
  int? get v => _v;
  String? get profilePic => _profilePic;
  dynamic get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['gender'] = _gender;
    map['userGoal'] = _userGoal;
    map['activityLevel'] = _activityLevel;
    map['status'] = _status;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['profilePic'] = _profilePic;
    map['otp'] = _otp;
    map['totalMenuOrder'] = _totalMenuOrder;
    return map;
  }

}

/// msg : "Profile data found successfully"
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