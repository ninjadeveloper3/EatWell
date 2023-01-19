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
  late final List<DietCategoryModel> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data'])
        .map((e) => DietCategoryModel.fromJson(e))
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

class DietCategoryModel {
  DietCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.bgImage,
    required this.headingColor,
    required this.plans,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String image;
  late final String bgImage;
  late final String headingColor;
  late final List<Plans> plans;

  DietCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    bgImage = json['bgImage'];
    headingColor = json['headingColor'];
    plans = List.from(json['plans']).map((e) => Plans.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['image'] = image;
    _data['bgImage'] = bgImage;
    _data['headingColor'] = headingColor;
    _data['plans'] = plans.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Plans {
  Plans({
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

  Plans.fromJson(Map<String, dynamic> json) {
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
