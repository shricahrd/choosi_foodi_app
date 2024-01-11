/// meta : {"msg":"Profile data found successfully","status":true}
/// data : {"userId":"629461ef9ba9e2ddb6513ece","gender":"N/A","userGoal":"LOSE WEIGHT","activityLevel":"LIGHT","status":"ACTIVE","firstName":"Anwarul","lastName":"Haque","email":"anwarul@test.com","mobile":"7491929040","createdAt":1653891567323,"updatedAt":1655456297377,"__v":0,"otp":null}

class UserProfile {
  UserProfile({
      Meta? meta,
      Data? data,}){
    _meta = meta;
    _data = data;
}

  UserProfile.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
UserProfile copyWith({  Meta? meta,
  Data? data,
}) => UserProfile(  meta: meta ?? _meta,
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

/// userId : "629461ef9ba9e2ddb6513ece"
/// gender : "N/A"
/// userGoal : "LOSE WEIGHT"
/// activityLevel : "LIGHT"
/// status : "ACTIVE"
/// firstName : "Anwarul"
/// lastName : "Haque"
/// email : "anwarul@test.com"
/// mobile : "7491929040"
/// createdAt : 1653891567323
/// updatedAt : 1655456297377
/// __v : 0
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
      int? v,
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
    _v = v;
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
    _v = json['__v'];
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
  int? _v;
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
  int? v,
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
  v: v ?? _v,
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
  int? get v => _v;
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
    map['otp'] = _otp;
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