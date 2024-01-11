/// meta : {"msg":"Eligible users found.","status":true}
/// data : [{"userId":"62b29c0d1b6356226812539b","isLogin":true,"gender":"N/A","userGoal":"LOSE WEIGHT","activityLevel":"LIGHT","status":"ACTIVE","_id":"62b29c0d1b6356226812539c","firstName":"Chek","lastName":"Cheking","email":"cheking@gmail.com","password":"$2a$10$pPh0nqqm8Sei7Zvg2R/Gn.yiMsxf2cNAyRAql1ZdnczoPksJitSqy","mobile":"8888888888","createdAt":1655872525035,"updatedAt":1657355546152,"__v":0,"profilePic":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/profilePic-scaled_image_picker4224127170661334263-1657340872416-907314.jpg"}]

class GetUserListModel {
  GetUserListModel({
      Meta? meta, 
      List<GetUserDataList>? data,}){
    _meta = meta;
    _data = data;
}

  GetUserListModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetUserDataList.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<GetUserDataList>? _data;
GetUserListModel copyWith({  Meta? meta,
  List<GetUserDataList>? data,
}) => GetUserListModel(  meta: meta ?? _meta,
  data: data ?? _data,
);
  Meta? get meta => _meta;
  List<GetUserDataList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// userId : "62b29c0d1b6356226812539b"
/// isLogin : true
/// gender : "N/A"
/// userGoal : "LOSE WEIGHT"
/// activityLevel : "LIGHT"
/// status : "ACTIVE"
/// _id : "62b29c0d1b6356226812539c"
/// firstName : "Chek"
/// lastName : "Cheking"
/// email : "cheking@gmail.com"
/// password : "$2a$10$pPh0nqqm8Sei7Zvg2R/Gn.yiMsxf2cNAyRAql1ZdnczoPksJitSqy"
/// mobile : "8888888888"
/// createdAt : 1655872525035
/// updatedAt : 1657355546152
/// __v : 0
/// profilePic : "https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/profilePic-scaled_image_picker4224127170661334263-1657340872416-907314.jpg"

class GetUserDataList {
  GetUserDataList({
      String? userId, 
      bool? isLogin, 
      String? gender, 
      String? userGoal, 
      String? activityLevel, 
      String? status, 
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? password, 
      String? mobile, 
      bool isChecked = false,
      int? createdAt,
      int? updatedAt, 
      int? v, 
      String? profilePic,}){
    _userId = userId;
    _isLogin = isLogin;
    _gender = gender;
    _userGoal = userGoal;
    _activityLevel = activityLevel;
    _status = status;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _mobile = mobile;
    _isChecked = isChecked;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _profilePic = profilePic;
}

  GetUserDataList.fromJson(dynamic json) {
    _userId = json['userId'];
    _isLogin = json['isLogin'];
    _gender = json['gender'];
    _userGoal = json['userGoal'];
    _activityLevel = json['activityLevel'];
    _status = json['status'];
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _password = json['password'];
    _mobile = json['mobile'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _profilePic = json['profilePic'];
  }
  String? _userId;
  bool? _isLogin;
  String? _gender;
  String? _userGoal;
  String? _activityLevel;
  String? _status;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _mobile;
  bool _isChecked = false;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
  String? _profilePic;
  GetUserDataList copyWith({  String? userId,
  bool? isLogin,
  String? gender,
  String? userGoal,
  String? activityLevel,
  String? status,
  String? id,
  String? firstName,
  String? lastName,
  String? email,
  String? password,
  bool isChecked = false,
  String? mobile,
  int? createdAt,
  int? updatedAt,
  int? v,
  String? profilePic,
}) => GetUserDataList(  userId: userId ?? _userId,
  isLogin: isLogin ?? _isLogin,
  gender: gender ?? _gender,
  userGoal: userGoal ?? _userGoal,
  activityLevel: activityLevel ?? _activityLevel,
  status: status ?? _status,
  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  password: password ?? _password,
   isChecked: isChecked,
  mobile: mobile ?? _mobile,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  profilePic: profilePic ?? _profilePic,
);
  String? get userId => _userId;
  bool? get isLogin => _isLogin;
  String? get gender => _gender;
  String? get userGoal => _userGoal;
  String? get activityLevel => _activityLevel;
  String? get status => _status;
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  String? get mobile => _mobile;
  bool? get isChecked => _isChecked;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;
  String? get profilePic => _profilePic;

  set setChecked(bool value){
    this._isChecked = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['isLogin'] = _isLogin;
    map['gender'] = _gender;
    map['userGoal'] = _userGoal;
    map['activityLevel'] = _activityLevel;
    map['status'] = _status;
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['password'] = _password;
    map['mobile'] = _mobile;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['profilePic'] = _profilePic;
    return map;
  }

}

/// msg : "Eligible users found."
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