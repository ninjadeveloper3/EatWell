// ignore_for_file: prefer_typing_uninitialized_variables

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
  late final List<MealItem> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => MealItem.fromJson(e)).toList();
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

class MealItem {
  MealItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageMenu,
    required this.imageItem,
    required this.details,
    required this.ingredients,
    required this.mealCategories,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String imageMenu;
  late final String imageItem;
  late final List<Details> details;
  late final List<Ingredients> ingredients;
  late final List<MealCategories> mealCategories;

  MealItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageMenu = json['imageMenu'];
    imageItem = json['imageItem'];
    details =
        List.from(json['details']).map((e) => Details.fromJson(e)).toList();
    ingredients = List.from(json['ingredients'])
        .map((e) => Ingredients.fromJson(e))
        .toList();
    mealCategories = List.from(json['mealCategories'])
        .map((e) => MealCategories.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['imageMenu'] = imageMenu;
    _data['imageItem'] = imageItem;
    _data['details'] = details.map((e) => e.toJson()).toList();
    _data['ingredients'] = ingredients.map((e) => e.toJson()).toList();
    _data['mealCategories'] = mealCategories.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Details {
  Details({
    required this.id,
    required this.dietCategoryId,
    required this.goalsId,
    required this.mealItemsId,
    required this.calories,
    required this.size,
  });
  late final int id;
  late final int dietCategoryId;
  late final int goalsId;
  late final int mealItemsId;
  var calories;
  var size;

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dietCategoryId = json['dietCategoryId'];
    goalsId = json['goalsId'];
    mealItemsId = json['mealItemsId'];
    calories = json['calories'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['dietCategoryId'] = dietCategoryId;
    _data['goalsId'] = goalsId;
    _data['mealItemsId'] = mealItemsId;
    _data['calories'] = calories;
    _data['size'] = size;
    return _data;
  }
}

class Ingredients {
  Ingredients({
    required this.id,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String image;

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}

class MealCategories {
  MealCategories({
    required this.id,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String image;

  MealCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}
