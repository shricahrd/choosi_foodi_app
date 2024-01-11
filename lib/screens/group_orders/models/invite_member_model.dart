
class InviteMemberModel{
  String userId = "";
  String name = "";
  String mobile = "";

  InviteMemberModel({required this.userId, required this.name, required this.mobile,});

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'name': this.name,
      'mobile': this.mobile,
    };
  }

  factory InviteMemberModel.fromMap(Map<String, dynamic> map) {
    return InviteMemberModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      mobile: map['mobile'] as String,
    );
  }
}