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
  late final List<MealPerDay> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => MealPerDay.fromJson(e)).toList();
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

class MealPerDay {
  MealPerDay({
    required this.id,
    required this.name,
    required this.selection,
    required this.categories,
    required this.caloriesOld,
    required this.calories,
  });
  late final int id;
  late final String name;
  late final int selection;
  late final List<Categories> categories;
  late final List<CaloriesOld> caloriesOld;
  late final List<Calories> calories;

  MealPerDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    selection = json['selection'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
    caloriesOld = List.from(json['caloriesOld'])
        .map((e) => CaloriesOld.fromJson(e))
        .toList();
    calories =
        List.from(json['calories']).map((e) => Calories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['selection'] = selection;
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    _data['caloriesOld'] = caloriesOld.map((e) => e.toJson()).toList();
    _data['calories'] = calories.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.image,
    required this.selectedImage,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String selectedImage;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    selectedImage = json['selectedImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['selectedImage'] = selectedImage;
    return _data;
  }
}

class CaloriesOld {
  CaloriesOld({
    required this.id,
    required this.mealPerDayId,
    this.calories,
    required this.calorieId,
  });
  late final int id;
  late final int mealPerDayId;
  late final int? calories;
  late final int calorieId;

  CaloriesOld.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealPerDayId = json['mealPerDayId'];
    calories = null;
    calorieId = json['calorieId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['mealPerDayId'] = mealPerDayId;
    _data['calories'] = calories;
    _data['calorieId'] = calorieId;
    return _data;
  }
}

class Calories {
  Calories({
    required this.id,
    required this.calorieValue,
  });
  late final int id;
  var calorieValue;

  Calories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calorieValue = json['calorieValue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['calorieValue'] = calorieValue;
    return _data;
  }
}
