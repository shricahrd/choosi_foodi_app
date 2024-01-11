

class ViewGroupCartModel {
  Meta? meta;
  ViewGroupCartData? data;

  ViewGroupCartModel({
    Meta? meta,
    ViewGroupCartData? data,});

  ViewGroupCartModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new ViewGroupCartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Meta {
  String? msg;
  bool? status;

  Meta({this.msg, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class ViewGroupCartData{
  String? id;
  String? groupCartId;
  String? groupId;
  String? groupName;
  String? restaurantId;
  String? restaurantName;



  ViewGroupCartData({this.id});

  ViewGroupCartData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    return data;
  }

}