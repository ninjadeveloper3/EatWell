// ignore_for_file: prefer_void_to_null

class AutoGenerate {
  AutoGenerate({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String code;
  late final String message;
  late final ProfileModel data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = ProfileModel.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class ProfileModel {
  ProfileModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.dob,
    required this.phoneNumber,
    required this.email,
    required this.userType,
    this.imageUrl,
    this.completedOrderCount,
    required this.activeOrder,
    this.planName,
    this.planDuration,
  });
  late final int id;
  String? firstName;
  String? lastName;
  late final Null dob;
  late final String phoneNumber;
  late final String email;
  late final String userType;
  String? imageUrl;
  int? completedOrderCount;
  late final bool activeOrder;
  late final String? planName;
  late final int? planDuration;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = null;
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    userType = json['userType'];
    imageUrl = json['imageUrl'];
    completedOrderCount = json['completedOrderCount'];
    activeOrder = json['activeOrder'];
    planName = json['planName'];
    planDuration = json['planDuration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['dob'] = dob;
    _data['phoneNumber'] = phoneNumber;
    _data['email'] = email;
    _data['userType'] = userType;
    _data['imageUrl'] = imageUrl;
    _data['completedOrderCount'] = completedOrderCount;
    _data['activeOrder'] = activeOrder;
    _data['planName'] = planName;
    _data['planDuration'] = planDuration;
    return _data;
  }
}

// class UserProfile {
//   String? firstName;
//   String? lastName;
//   String? imageUrl;
//   String? email;
//   String? completedOrderCount;
//   String? planName;


//   UserProfile({
//     this.firstName,
//     this.lastName,
//   });
// }
