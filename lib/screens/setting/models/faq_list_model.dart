/// meta : {"msg":"faq list found successfully","status":true}
/// data : [{"faqId":"62d6a1ea55869518147efaa0","status":"ACTIVE","_id":"62d6a1ea55869518147efaa1","question":"test question 2 ","answer":"test answer 2","createdAt":1658233322205,"updatedAt":1658233431825,"__v":0}]

class FaqListModel {
  FaqListModel({
      Meta? meta, 
      List<Data>? data,}){
    _meta = meta;
    _data = data;
}

  FaqListModel.fromJson(dynamic json) {
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
FaqListModel copyWith({  Meta? meta,
  List<Data>? data,
}) => FaqListModel(  meta: meta ?? _meta,
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

/// faqId : "62d6a1ea55869518147efaa0"
/// status : "ACTIVE"
/// _id : "62d6a1ea55869518147efaa1"
/// question : "test question 2 "
/// answer : "test answer 2"
/// createdAt : 1658233322205
/// updatedAt : 1658233431825
/// __v : 0

class Data {
  Data({
      String? faqId, 
      String? status, 
      String? id, 
      String? question, 
      String? answer, 
      int? createdAt, 
      int? updatedAt, 
      int? v,}){
    _faqId = faqId;
    _status = status;
    _id = id;
    _question = question;
    _answer = answer;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _faqId = json['faqId'];
    _status = json['status'];
    _id = json['_id'];
    _question = json['question'];
    _answer = json['answer'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _faqId;
  String? _status;
  String? _id;
  String? _question;
  String? _answer;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
Data copyWith({  String? faqId,
  String? status,
  String? id,
  String? question,
  String? answer,
  int? createdAt,
  int? updatedAt,
  int? v,
}) => Data(  faqId: faqId ?? _faqId,
  status: status ?? _status,
  id: id ?? _id,
  question: question ?? _question,
  answer: answer ?? _answer,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get faqId => _faqId;
  String? get status => _status;
  String? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['faqId'] = _faqId;
    map['status'] = _status;
    map['_id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// msg : "faq list found successfully"
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