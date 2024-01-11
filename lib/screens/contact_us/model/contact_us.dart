/// meta : {"msg":"Query submit successfully.","status":true}
/// data : {"contactUsId":"62b0246a1b63562268124ca7","status":"PENDING","_id":"62b0246a1b63562268124ca8","name":"Abhisek tomer","email":"test@gmail.com","mobile":"8899901817","message":"hello test","createdAt":1655710826444,"updatedAt":1655710826444,"__v":0}

class ContactUs {
  ContactUs({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  ContactUs.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
ContactUs copyWith({  Meta? meta,
  Data? data,
}) => ContactUs(  meta: meta ?? _meta,
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

/// contactUsId : "62b0246a1b63562268124ca7"
/// status : "PENDING"
/// _id : "62b0246a1b63562268124ca8"
/// name : "Abhisek tomer"
/// email : "test@gmail.com"
/// mobile : "8899901817"
/// message : "hello test"
/// createdAt : 1655710826444
/// updatedAt : 1655710826444
/// __v : 0

class Data {
  Data({
      String? contactUsId, 
      String? status, 
      String? id, 
      String? name, 
      String? email, 
      String? mobile, 
      String? message, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _contactUsId = contactUsId;
    _status = status;
    _id = id;
    _name = name;
    _email = email;
    _mobile = mobile;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _contactUsId = json['contactUsId'];
    _status = json['status'];
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _message = json['message'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _contactUsId;
  String? _status;
  String? _id;
  String? _name;
  String? _email;
  String? _mobile;
  String? _message;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? contactUsId,
  String? status,
  String? id,
  String? name,
  String? email,
  String? mobile,
  String? message,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  contactUsId: contactUsId ?? _contactUsId,
  status: status ?? _status,
  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  message: message ?? _message,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get contactUsId => _contactUsId;
  String? get status => _status;
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get message => _message;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactUsId'] = _contactUsId;
    map['status'] = _status;
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['message'] = _message;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "Query submit successfully."
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