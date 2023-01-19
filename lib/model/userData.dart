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
  late final Data data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = Data.fromJson(json['data']);
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

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    // this.middleName,
    required this.displayName,
    required this.prefix,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.accessToken,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  // late final void middleName;
  late final String displayName;
  late final String prefix;
  late final String dob;
  late final String phoneNumber;
  late final String email;
  late final Role role;
  late final String accessToken;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    // middleName = null;
    displayName = json['displayName'];
    prefix = json['prefix'];
    dob = json['dob'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    role = Role.fromJson(json['role']);
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    // _data['middleName'] = middleName;
    _data['displayName'] = displayName;
    _data['prefix'] = prefix;
    _data['dob'] = dob;
    _data['phoneNumber'] = phoneNumber;
    _data['email'] = email;
    _data['role'] = role.toJson();
    _data['accessToken'] = accessToken;
    return _data;
  }
}

class Role {
  Role({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
