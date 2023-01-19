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
  late final List<AddressList> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => AddressList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AddressList {
  AddressList({
    required this.id,
    required this.userId,
    this.addressType,
    required this.isDefault,
    required this.name,
    required this.address,
    this.state,
    this.city,
    this.country,
    required this.lat,
    required this.lng,
  });
  late final int id;
  late final int userId;
  late final Null addressType;
  late final bool isDefault;
  late final String name;
  late final String address;
  late final Null state;
  late final Null city;
  late final Null country;
  late final String lat;
  late final String lng;

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    addressType = null;
    isDefault = json['isDefault'];
    name = json['name'];
    address = json['address'];
    state = null;
    city = null;
    country = null;
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['addressType'] = addressType;
    _data['isDefault'] = isDefault;
    _data['name'] = name;
    _data['address'] = address;
    _data['state'] = state;
    _data['city'] = city;
    _data['country'] = country;
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}
