/// meta : {"msg":"Review list found.","status":true}
/// data : [{"reviewId":"62d69ac4dc1228156cb11cff","rating":3.4,"status":"APPROVED","_id":"62d69ac4dc1228156cb11d00","restaurantId":"62945a0746f536ddafd14f9d","restaurantName":"New Horizon Restaurant","userId":"629461ef9ba9e2ddb6513ece","userName":"","review":"Good food","createdAt":1658231492618,"updatedAt":1658231709460,"__v":0}]

class ReviewListModel {
  ReviewListModel({
      Meta? meta, 
      List<Data>? data,}){
    _meta = meta;
    _data = data;
}

  ReviewListModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<Data>? _data;
ReviewListModel copyWith({  Meta? meta,
  List<Data>? data,
}) => ReviewListModel(  meta: meta ?? _meta,
  data: data ?? _data,
);
  Meta? get meta => _meta;
  List<Data>? get data => _data;

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

/// reviewId : "62d69ac4dc1228156cb11cff"
/// rating : 3.4
/// status : "APPROVED"
/// _id : "62d69ac4dc1228156cb11d00"
/// restaurantId : "62945a0746f536ddafd14f9d"
/// restaurantName : "New Horizon Restaurant"
/// userId : "629461ef9ba9e2ddb6513ece"
/// userName : ""
/// review : "Good food"
/// createdAt : 1658231492618
/// updatedAt : 1658231709460
/// __v : 0

class Data {
  Data({
      String? reviewId, 
      dynamic rating,
      String? status, 
      String? id, 
      String? restaurantId, 
      String? restaurantName, 
      String? userId, 
      String? userName, 
      String? review, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _reviewId = reviewId;
    _rating = rating;
    _status = status;
    _id = id;
    _restaurantId = restaurantId;
    _restaurantName = restaurantName;
    _userId = userId;
    _userName = userName;
    _review = review;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _reviewId = json['reviewId'];
    _rating = json['rating'];
    _status = json['status'];
    _id = json['_id'];
    _restaurantId = json['restaurantId'];
    _restaurantName = json['restaurantName'];
    _userId = json['userId'];
    _userName = json['userName'];
    _review = json['review'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _reviewId;
  dynamic _rating;
  String? _status;
  String? _id;
  String? _restaurantId;
  String? _restaurantName;
  String? _userId;
  String? _userName;
  String? _review;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? reviewId,
  dynamic rating,
  String? status,
  String? id,
  String? restaurantId,
  String? restaurantName,
  String? userId,
  String? userName,
  String? review,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  reviewId: reviewId ?? _reviewId,
  rating: rating ?? _rating,
  status: status ?? _status,
  id: id ?? _id,
  restaurantId: restaurantId ?? _restaurantId,
  restaurantName: restaurantName ?? _restaurantName,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  review: review ?? _review,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get reviewId => _reviewId;
  dynamic get rating => _rating;
  String? get status => _status;
  String? get id => _id;
  String? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get review => _review;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reviewId'] = _reviewId;
    map['rating'] = _rating;
    map['status'] = _status;
    map['_id'] = _id;
    map['restaurantId'] = _restaurantId;
    map['restaurantName'] = _restaurantName;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['review'] = _review;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "Review list found."
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