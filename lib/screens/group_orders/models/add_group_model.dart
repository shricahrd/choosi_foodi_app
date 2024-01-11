/// meta : {"msg":"Group created successfully","status":true}
/// data : {"groupId":"62db705579d7a2fe7eb1db0a","orderType":"DELIVERY","paidBy":"ADMIN","_id":"62db705579d7a2fe7eb1db0b","userId":"629461ef9ba9e2ddb6513ece","name":"Anwarul","mobile":7491929040,"restaurantId":"62945a0746f536ddafd14f9d","restaurantName":"New Horizon Restaurant","groupName":"dummy's party 2","spendingLimit":50,"address":"253 street 4, los angeles 25514","createdAt":1658548309495,"updatedAt":1658548309495,"__v":0}

class AddGroupModel {
  AddGroupModel({
      Meta? meta, 
      Data? data,}){
    _meta = meta;
    _data = data;
}

  AddGroupModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
AddGroupModel copyWith({  Meta? meta,
  Data? data,
}) => AddGroupModel(  meta: meta ?? _meta,
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

/// groupId : "62db705579d7a2fe7eb1db0a"
/// orderType : "DELIVERY"
/// paidBy : "ADMIN"
/// _id : "62db705579d7a2fe7eb1db0b"
/// userId : "629461ef9ba9e2ddb6513ece"
/// name : "Anwarul"
/// mobile : 7491929040
/// restaurantId : "62945a0746f536ddafd14f9d"
/// restaurantName : "New Horizon Restaurant"
/// groupName : "dummy's party 2"
/// spendingLimit : 50
/// address : "253 street 4, los angeles 25514"
/// createdAt : 1658548309495
/// updatedAt : 1658548309495
/// __v : 0

class Data {
  Data({
      String? groupId, 
      String? orderType, 
      String? paidBy, 
      String? id, 
      String? userId, 
      String? name, 
      int? mobile, 
      String? restaurantId, 
      String? restaurantName, 
      String? groupName, 
      int? spendingLimit, 
      String? address, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _groupId = groupId;
    _orderType = orderType;
    _paidBy = paidBy;
    _id = id;
    _userId = userId;
    _name = name;
    _mobile = mobile;
    _restaurantId = restaurantId;
    _restaurantName = restaurantName;
    _groupName = groupName;
    _spendingLimit = spendingLimit;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _groupId = json['groupId'];
    _orderType = json['orderType'];
    _paidBy = json['paidBy'];
    _id = json['_id'];
    _userId = json['userId'];
    _name = json['name'];
    _mobile = json['mobile'];
    _restaurantId = json['restaurantId'];
    _restaurantName = json['restaurantName'];
    _groupName = json['groupName'];
    _spendingLimit = json['spendingLimit'];
    _address = json['address'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _groupId;
  String? _orderType;
  String? _paidBy;
  String? _id;
  String? _userId;
  String? _name;
  int? _mobile;
  String? _restaurantId;
  String? _restaurantName;
  String? _groupName;
  int? _spendingLimit;
  String? _address;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? groupId,
  String? orderType,
  String? paidBy,
  String? id,
  String? userId,
  String? name,
  int? mobile,
  String? restaurantId,
  String? restaurantName,
  String? groupName,
  int? spendingLimit,
  String? address,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  groupId: groupId ?? _groupId,
  orderType: orderType ?? _orderType,
  paidBy: paidBy ?? _paidBy,
  id: id ?? _id,
  userId: userId ?? _userId,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  restaurantId: restaurantId ?? _restaurantId,
  restaurantName: restaurantName ?? _restaurantName,
  groupName: groupName ?? _groupName,
  spendingLimit: spendingLimit ?? _spendingLimit,
  address: address ?? _address,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get groupId => _groupId;
  String? get orderType => _orderType;
  String? get paidBy => _paidBy;
  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  int? get mobile => _mobile;
  String? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;
  String? get groupName => _groupName;
  int? get spendingLimit => _spendingLimit;
  String? get address => _address;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupId'] = _groupId;
    map['orderType'] = _orderType;
    map['paidBy'] = _paidBy;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['restaurantId'] = _restaurantId;
    map['restaurantName'] = _restaurantName;
    map['groupName'] = _groupName;
    map['spendingLimit'] = _spendingLimit;
    map['address'] = _address;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "Group created successfully"
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