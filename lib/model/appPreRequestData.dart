// ignore_for_file: prefer_void_to_null, no_leading_underscores_for_local_identifiers

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
  late final List<AppPreRequestData> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data'])
        .map((e) => AppPreRequestData.fromJson(e))
        .toList();
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

class AppPreRequestData {
  AppPreRequestData({
    required this.id,
    required this.paramName,
    required this.paramValue,
    this.nameAr,
    required this.nameEn,
  });
  late final int id;
  late final String paramName;
  late final String paramValue;
  late final Null nameAr;
  late final String nameEn;

  AppPreRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paramName = json['paramName'];
    paramValue = json['paramValue'];
    nameAr = null;
    nameEn = json['nameEn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['paramName'] = paramName;
    _data['paramValue'] = paramValue;
    _data['nameAr'] = nameAr;
    _data['nameEn'] = nameEn;
    return _data;
  }
}
