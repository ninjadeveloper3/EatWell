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
  late final List<DaysPlan> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => DaysPlan.fromJson(e)).toList();
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

class DaysPlan {
  DaysPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.dietCategoryId,
  });
  late final int id;
  late final String name;
  late final String price;
  late final int duration;
  late final int dietCategoryId;

  DaysPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    dietCategoryId = json['dietCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    _data['duration'] = duration;
    _data['dietCategoryId'] = dietCategoryId;
    return _data;
  }
}
