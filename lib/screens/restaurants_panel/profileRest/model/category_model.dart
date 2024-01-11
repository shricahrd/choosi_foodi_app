/// meta : {"msg":"Category tree found successfully","status":true}
/// data : [{"_id":"627b6150c9889116b827db80","categoryId":"627b6150c9889116b827db7f","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Indian","url":"Indian cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.amazonaws.com/categoryImg-Indian%20Cusines-1652253008027-433082.jpg","createdAt":1652253008926,"updatedAt":1655812009240,"__v":0,"subcategory":[{"_id":"627b68dbc9889116b827dd6e","categoryId":"627b68dbc9889116b827dd6d","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b6150c9889116b827db7f","categoryName":"Butter chicken","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Butter%20chicken-1652254938593-890541.jpg","createdAt":1652254939298,"updatedAt":1652254939298,"__v":0,"subcategory":[]},{"_id":"627b6924c9889116b827dd9a","categoryId":"627b6924c9889116b827dd99","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b6150c9889116b827db7f","categoryName":"Palak paneer","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Palak%20paneer-1652255012287-135929.jpg","createdAt":1652255012699,"updatedAt":1655893715725,"__v":0,"subcategory":[]}]},{"_id":"627b61c4c9889116b827db8d","categoryId":"627b61c4c9889116b827db8c","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Chinese","url":"chinese cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-chinese%20cuisines-1652253123952-887614.jpg","createdAt":1652253124366,"updatedAt":1655812008313,"__v":0,"subcategory":[{"_id":"627b67c0c9889116b827dd0c","categoryId":"627b67c0c9889116b827dd0b","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b61c4c9889116b827db8c","categoryName":"Jiangsu","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Jiangsu-1652254656021-469699.jpg","createdAt":1652254656511,"updatedAt":1652254656511,"__v":0,"subcategory":[]},{"_id":"627b6858c9889116b827dd43","categoryId":"627b6858c9889116b827dd42","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b61c4c9889116b827db8c","categoryName":"Hunan","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Hunan-1652254808065-423549.jpg","createdAt":1652254808682,"updatedAt":1652254808682,"__v":0,"subcategory":[]}]},{"_id":"627b6222c9889116b827db9b","categoryId":"627b6222c9889116b827db9a","commission":0,"status":"ACTIVE","type":"ROOT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"categoryName":"Italian","url":"Italian cuisine url","tax":0,"categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Italian%20cuisines-1652253218353-406419.jpg","createdAt":1652253218812,"updatedAt":1656564305874,"__v":0,"subcategory":[{"_id":"627b632dc9889116b827dbec","categoryId":"627b632dc9889116b827dbeb","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b6222c9889116b827db9a","categoryName":"Pasta","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Pasta-1652253485343-618387.jpg","createdAt":1652253485871,"updatedAt":1652253485871,"__v":0,"subcategory":[]},{"_id":"627b6697c9889116b827dcc7","categoryId":"627b6697c9889116b827dcc6","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b6222c9889116b827db9a","categoryName":"Lasagna","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-lasagna-1652254358719-713088.jpg","createdAt":1652254359313,"updatedAt":1655893719598,"__v":0,"subcategory":[]}]}]

class CategoryModel {
  CategoryModel({
      Meta? meta, 
      List<Data>? data,}){
    _meta = meta;
    _data = data;
}

  CategoryModel.fromJson(dynamic json) {
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
CategoryModel copyWith({  Meta? meta,
  List<Data>? data,
}) => CategoryModel(  meta: meta ?? _meta,
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

/// _id : "627b6150c9889116b827db80"
/// categoryId : "627b6150c9889116b827db7f"
/// commission : 0
/// status : "ACTIVE"
/// type : "ROOT"
/// isCompare : false
/// isFeaturedWeb : false
/// isCategoryWebNav : false
/// isCategoryMobile : false
/// isCategoryMobileNav : false
/// categoryName : "Indian"
/// url : "Indian cuisine url"
/// tax : 0
/// categoryImg : "https://choosi-foodi-bucket.s3.amazonaws.com/categoryImg-Indian%20Cusines-1652253008027-433082.jpg"
/// createdAt : 1652253008926
/// updatedAt : 1655812009240
/// __v : 0
/// subcategory : [{"_id":"627b68dbc9889116b827dd6e","categoryId":"627b68dbc9889116b827dd6d","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b6150c9889116b827db7f","categoryName":"Butter chicken","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Butter%20chicken-1652254938593-890541.jpg","createdAt":1652254939298,"updatedAt":1652254939298,"__v":0,"subcategory":[]},{"_id":"627b6924c9889116b827dd9a","categoryId":"627b6924c9889116b827dd99","commission":0,"status":"ACTIVE","type":"PARENT","isCompare":false,"isFeaturedWeb":false,"isCategoryWebNav":false,"isCategoryMobile":false,"isCategoryMobileNav":false,"parentId":"627b6150c9889116b827db7f","categoryName":"Palak paneer","categoryImg":"https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Palak%20paneer-1652255012287-135929.jpg","createdAt":1652255012699,"updatedAt":1655893715725,"__v":0,"subcategory":[]}]

class Data {
  Data({
      String? id, 
      String? categoryId, 
      int? commission, 
      String? status, 
      String? type, 
      bool? isCompare, 
      bool? isFeaturedWeb, 
      bool? isCategoryWebNav, 
      bool? isCategoryMobile, 
      bool? isCategoryMobileNav, 
      String? categoryName, 
      String? url, 
      int? tax, 
      String? categoryImg, 
      int? createdAt, 
      int? updatedAt, 
      int? v, 
      List<Subcategory>? subcategory,
      bool? isCheckedRoot = false,
   }){
    _id = id;
    _categoryId = categoryId;
    _commission = commission;
    _status = status;
    _type = type;
    _isCompare = isCompare;
    _isFeaturedWeb = isFeaturedWeb;
    _isCategoryWebNav = isCategoryWebNav;
    _isCategoryMobile = isCategoryMobile;
    _isCategoryMobileNav = isCategoryMobileNav;
    _categoryName = categoryName;
    _url = url;
    _tax = tax;
    _categoryImg = categoryImg;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _subcategory = subcategory;
    _isCheckedRoot = isCheckedRoot;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _categoryId = json['categoryId'];
    _commission = json['commission'];
    _status = json['status'];
    _type = json['type'];
    _isCompare = json['isCompare'];
    _isFeaturedWeb = json['isFeaturedWeb'];
    _isCategoryWebNav = json['isCategoryWebNav'];
    _isCategoryMobile = json['isCategoryMobile'];
    _isCategoryMobileNav = json['isCategoryMobileNav'];
    _categoryName = json['categoryName'];
    _url = json['url'];
    _tax = json['tax'];
    _categoryImg = json['categoryImg'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    // _isCheckedRoot = json['isCheckedRoot'];
    _v = json['__v'];
    if (json['subcategory'] != null) {
      _subcategory = [];
      json['subcategory'].forEach((v) {
        _subcategory?.add(Subcategory.fromJson(v));
      });
    }
  }

  set setRootChecked(bool? isChecked){
    this._isCheckedRoot = isChecked;
    print("In Model _isCheckedRoot   $_isCheckedRoot");
  }

  String? _id;
  String? _categoryId;
  int? _commission;
  String? _status;
  String? _type;
  bool? _isCompare;
  bool? _isFeaturedWeb;
  bool? _isCategoryWebNav;
  bool? _isCategoryMobile;
  bool? _isCategoryMobileNav;
  String? _categoryName;
  String? _url;
  int? _tax;
  String? _categoryImg;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
  List<Subcategory>? _subcategory;
  bool? _isCheckedRoot = false;
Data copyWith({  String? id,
  String? categoryId,
  int? commission,
  String? status,
  String? type,
  bool? isCompare,
  bool? isFeaturedWeb,
  bool? isCategoryWebNav,
  bool? isCategoryMobile,
  bool? isCategoryMobileNav,
  String? categoryName,
  String? url,
  int? tax,
  String? categoryImg,
  int? createdAt,
  int? updatedAt,
  int? v,
  List<Subcategory>? subcategory,
  bool? isCheckedRoot,
}) => Data(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  commission: commission ?? _commission,
  status: status ?? _status,
  type: type ?? _type,
  isCompare: isCompare ?? _isCompare,
  isFeaturedWeb: isFeaturedWeb ?? _isFeaturedWeb,
  isCategoryWebNav: isCategoryWebNav ?? _isCategoryWebNav,
  isCategoryMobile: isCategoryMobile ?? _isCategoryMobile,
  isCategoryMobileNav: isCategoryMobileNav ?? _isCategoryMobileNav,
  categoryName: categoryName ?? _categoryName,
  url: url ?? _url,
  tax: tax ?? _tax,
  categoryImg: categoryImg ?? _categoryImg,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  subcategory: subcategory ?? _subcategory,
  isCheckedRoot: isCheckedRoot ?? _isCheckedRoot,
);
  String? get id => _id;
  String? get categoryId => _categoryId;
  int? get commission => _commission;
  String? get status => _status;
  String? get type => _type;
  bool? get isCompare => _isCompare;
  bool? get isFeaturedWeb => _isFeaturedWeb;
  bool? get isCategoryWebNav => _isCategoryWebNav;
  bool? get isCategoryMobile => _isCategoryMobile;
  bool? get isCategoryMobileNav => _isCategoryMobileNav;
  String? get categoryName => _categoryName;
  String? get url => _url;
  int? get tax => _tax;
  String? get categoryImg => _categoryImg;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;
  List<Subcategory>? get subcategory => _subcategory;
  bool? get isCheckedRoot => _isCheckedRoot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['categoryId'] = _categoryId;
    map['commission'] = _commission;
    map['status'] = _status;
    map['type'] = _type;
    map['isCompare'] = _isCompare;
    map['isFeaturedWeb'] = _isFeaturedWeb;
    map['isCategoryWebNav'] = _isCategoryWebNav;
    map['isCategoryMobile'] = _isCategoryMobile;
    map['isCategoryMobileNav'] = _isCategoryMobileNav;
    map['categoryName'] = _categoryName;
    map['url'] = _url;
    map['tax'] = _tax;
    map['categoryImg'] = _categoryImg;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['isCheckedRoot'] = _isCheckedRoot;
    if (_subcategory != null) {
      map['subcategory'] = _subcategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "627b68dbc9889116b827dd6e"
/// categoryId : "627b68dbc9889116b827dd6d"
/// commission : 0
/// status : "ACTIVE"
/// type : "PARENT"
/// isCompare : false
/// isFeaturedWeb : false
/// isCategoryWebNav : false
/// isCategoryMobile : false
/// isCategoryMobileNav : false
/// parentId : "627b6150c9889116b827db7f"
/// categoryName : "Butter chicken"
/// categoryImg : "https://choosi-foodi-bucket.s3.ap-southeast-1.amazonaws.com/categoryImg-Butter%20chicken-1652254938593-890541.jpg"
/// createdAt : 1652254939298
/// updatedAt : 1652254939298
/// __v : 0
/// subcategory : []

class Subcategory {
  Subcategory({
      String? id, 
      String? categoryId, 
      int? commission, 
      String? status, 
      String? type, 
      bool? isCompare, 
      bool? isFeaturedWeb, 
      bool? isCategoryWebNav, 
      bool? isCategoryMobile, 
      bool? isCategoryMobileNav, 
      bool? isCheckedSubCategory,
      String? parentId,
      String? categoryName, 
      String? categoryImg, 
      int? createdAt, 
      int? updatedAt, 
      int? v, 
      List<dynamic>? subcategory,}){
    _id = id;
    _categoryId = categoryId;
    _commission = commission;
    _status = status;
    _type = type;
    _isCompare = isCompare;
    _isFeaturedWeb = isFeaturedWeb;
    _isCategoryWebNav = isCategoryWebNav;
    _isCategoryMobile = isCategoryMobile;
    _isCategoryMobileNav = isCategoryMobileNav;
    _parentId = parentId;
    _categoryName = categoryName;
    _categoryImg = categoryImg;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _subcategory = subcategory;
    _isCheckedSubCategory = isCheckedSubCategory;
}

  set setSubCategoryChecked(bool? isChecked){
    this._isCheckedSubCategory = isChecked;
    print("In Model _isCheckedSubCategory   $_isCheckedSubCategory");
  }

  Subcategory.fromJson(dynamic json) {
    _id = json['_id'];
    _categoryId = json['categoryId'];
    _commission = json['commission'];
    _status = json['status'];
    _type = json['type'];
    _isCompare = json['isCompare'];
    _isFeaturedWeb = json['isFeaturedWeb'];
    _isCategoryWebNav = json['isCategoryWebNav'];
    _isCategoryMobile = json['isCategoryMobile'];
    _isCategoryMobileNav = json['isCategoryMobileNav'];
    _parentId = json['parentId'];
    _categoryName = json['categoryName'];
    _categoryImg = json['categoryImg'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _isCheckedSubCategory = false;
    // _isCheckedSubCategory = json['isCheckedSubCategory'];
  }
  String? _id;
  String? _categoryId;
  int? _commission;
  String? _status;
  String? _type;
  bool? _isCompare;
  bool? _isFeaturedWeb;
  bool? _isCategoryWebNav;
  bool? _isCategoryMobile;
  bool? _isCategoryMobileNav;
  bool? _isCheckedSubCategory;
  String? _parentId;
  String? _categoryName;
  String? _categoryImg;
  int? _createdAt;
  int? _updatedAt;
  int? _v;
  List<dynamic>? _subcategory;
Subcategory copyWith({  String? id,
  String? categoryId,
  int? commission,
  String? status,
  String? type,
  bool? isCompare,
  bool? isFeaturedWeb,
  bool? isCategoryWebNav,
  bool? isCategoryMobile,
  bool? isCategoryMobileNav,
  String? parentId,
  String? categoryName,
  String? categoryImg,
  int? createdAt,
  int? updatedAt,
  int? v,
  bool? isCheckedSubCategory,
  List<dynamic>? subcategory,
}) => Subcategory(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  commission: commission ?? _commission,
  status: status ?? _status,
  type: type ?? _type,
  isCompare: isCompare ?? _isCompare,
  isFeaturedWeb: isFeaturedWeb ?? _isFeaturedWeb,
  isCategoryWebNav: isCategoryWebNav ?? _isCategoryWebNav,
  isCategoryMobile: isCategoryMobile ?? _isCategoryMobile,
  isCategoryMobileNav: isCategoryMobileNav ?? _isCategoryMobileNav,
  parentId: parentId ?? _parentId,
  categoryName: categoryName ?? _categoryName,
  categoryImg: categoryImg ?? _categoryImg,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  subcategory: subcategory ?? _subcategory,
  isCheckedSubCategory: isCheckedSubCategory ?? _isCheckedSubCategory,
);
  String? get id => _id;
  String? get categoryId => _categoryId;
  int? get commission => _commission;
  String? get status => _status;
  String? get type => _type;
  bool? get isCompare => _isCompare;
  bool? get isFeaturedWeb => _isFeaturedWeb;
  bool? get isCategoryWebNav => _isCategoryWebNav;
  bool? get isCategoryMobile => _isCategoryMobile;
  bool? get isCategoryMobileNav => _isCategoryMobileNav;
  String? get parentId => _parentId;
  String? get categoryName => _categoryName;
  String? get categoryImg => _categoryImg;
  int? get createdAt => _createdAt;
  int? get updatedAt => _updatedAt;
  int? get v => _v;
  List<dynamic>? get subcategory => _subcategory;
  bool? get isCheckedSubCategory => _isCheckedSubCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['categoryId'] = _categoryId;
    map['commission'] = _commission;
    map['status'] = _status;
    map['type'] = _type;
    map['isCompare'] = _isCompare;
    map['isFeaturedWeb'] = _isFeaturedWeb;
    map['isCategoryWebNav'] = _isCategoryWebNav;
    map['isCategoryMobile'] = _isCategoryMobile;
    map['isCategoryMobileNav'] = _isCategoryMobileNav;
    map['parentId'] = _parentId;
    map['categoryName'] = _categoryName;
    map['categoryImg'] = _categoryImg;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['isCheckedSubCategory'] = _isCheckedSubCategory;
    if (_subcategory != null) {
      map['subcategory'] = _subcategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// msg : "Category tree found successfully"
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