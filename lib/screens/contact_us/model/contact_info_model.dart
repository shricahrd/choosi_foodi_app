/// meta : {"msg":"contact info details found.","status":true}
/// data : {"contactInfoId":"62ab121c337ebe01784e6758","_id":"62ab121c337ebe01784e6759","address":"mumbai","mobile":"+919411892285","email":"test@gmail.com","website":"www.test.com","facebookLink":"www.test.com","twitterLink":"www.test.com","instagramLink":"www.test.com","linkedInLink":"www.test.com","createdAt":1655378460600,"updatedAt":1655709579131,"__v":0}

class ContactInfoModel {
  ContactInfoModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  ContactInfoModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
ContactInfoModel copyWith({  Meta? meta,
  Data? data,
}) => ContactInfoModel(  meta: meta ?? _meta,
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

/// contactInfoId : "62ab121c337ebe01784e6758"
/// _id : "62ab121c337ebe01784e6759"
/// address : "mumbai"
/// mobile : "+919411892285"
/// email : "test@gmail.com"
/// website : "www.test.com"
/// facebookLink : "www.test.com"
/// twitterLink : "www.test.com"
/// instagramLink : "www.test.com"
/// linkedInLink : "www.test.com"
/// createdAt : 1655378460600
/// updatedAt : 1655709579131
/// __v : 0

class Data {
  Data({
      String? contactInfoId, 
      String? id, 
      String? address, 
      String? mobile, 
      String? email, 
      String? website, 
      String? facebookLink, 
      String? twitterLink, 
      String? instagramLink, 
      String? linkedInLink, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _contactInfoId = contactInfoId;
    _id = id;
    _address = address;
    _mobile = mobile;
    _email = email;
    _website = website;
    _facebookLink = facebookLink;
    _twitterLink = twitterLink;
    _instagramLink = instagramLink;
    _linkedInLink = linkedInLink;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _contactInfoId = json['contactInfoId'];
    _id = json['_id'];
    _address = json['address'];
    _mobile = json['mobile'];
    _email = json['email'];
    _website = json['website'];
    _facebookLink = json['facebookLink'];
    _twitterLink = json['twitterLink'];
    _instagramLink = json['instagramLink'];
    _linkedInLink = json['linkedInLink'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _contactInfoId;
  String? _id;
  String? _address;
  String? _mobile;
  String? _email;
  String? _website;
  String? _facebookLink;
  String? _twitterLink;
  String? _instagramLink;
  String? _linkedInLink;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? contactInfoId,
  String? id,
  String? address,
  String? mobile,
  String? email,
  String? website,
  String? facebookLink,
  String? twitterLink,
  String? instagramLink,
  String? linkedInLink,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  contactInfoId: contactInfoId ?? _contactInfoId,
  id: id ?? _id,
  address: address ?? _address,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  website: website ?? _website,
  facebookLink: facebookLink ?? _facebookLink,
  twitterLink: twitterLink ?? _twitterLink,
  instagramLink: instagramLink ?? _instagramLink,
  linkedInLink: linkedInLink ?? _linkedInLink,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get contactInfoId => _contactInfoId;
  String? get id => _id;
  String? get address => _address;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get website => _website;
  String? get facebookLink => _facebookLink;
  String? get twitterLink => _twitterLink;
  String? get instagramLink => _instagramLink;
  String? get linkedInLink => _linkedInLink;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactInfoId'] = _contactInfoId;
    map['_id'] = _id;
    map['address'] = _address;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['website'] = _website;
    map['facebookLink'] = _facebookLink;
    map['twitterLink'] = _twitterLink;
    map['instagramLink'] = _instagramLink;
    map['linkedInLink'] = _linkedInLink;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "contact info details found."
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