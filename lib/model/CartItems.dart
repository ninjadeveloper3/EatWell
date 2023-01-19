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
  late final List<CartItems> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => CartItems.fromJson(e)).toList();
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

class CartItems {
  CartItems({
    required this.id,
    required this.userId,
    this.addressId,
    required this.goalId,
    required this.planId,
    required this.dietCategoryId,
    required this.caloriesId,
    required this.mealsPerDayId,
    required this.startDate,
    required this.endDate,
    this.price,
    this.discount,
    this.vat,
    this.totalAmount,
    required this.dieticianAssessment,
    this.deliveryMethod,
    required this.orderStatus,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    this.updatedAt,
    required this.mealCategories,
    required this.checkoutFlag,
    required this.plan,
  });
  late final int id;
  late final int userId;
  late final Null addressId;
  late final int goalId;
  late final int planId;
  late final int dietCategoryId;
  late final int caloriesId;
  late final int mealsPerDayId;
  late final String startDate;
  late final String endDate;
  late final Null price;
  late final Null discount;
  late final Null vat;
  late final Null totalAmount;
  late final int dieticianAssessment;
  late final Null deliveryMethod;
  late final int orderStatus;
  late final int createdBy;
  late final Null updatedBy;
  late final String createdAt;
  late final Null updatedAt;
  late final List<MealCategories> mealCategories;
  late final bool checkoutFlag;
  late final Plan plan;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    addressId = null;
    goalId = json['goalId'];
    planId = json['planId'];
    dietCategoryId = json['dietCategoryId'];
    caloriesId = json['caloriesId'];
    mealsPerDayId = json['mealsPerDayId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    price = null;
    discount = null;
    vat = null;
    totalAmount = null;
    dieticianAssessment = json['dieticianAssessment'];
    deliveryMethod = null;
    orderStatus = json['orderStatus'];
    createdBy = json['createdBy'];
    updatedBy = null;
    createdAt = json['createdAt'];
    updatedAt = null;
    mealCategories = List.from(json['mealCategories'])
        .map((e) => MealCategories.fromJson(e))
        .toList();
    checkoutFlag = json['checkoutFlag'];
    plan = Plan.fromJson(json['plan']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['addressId'] = addressId;
    _data['goalId'] = goalId;
    _data['planId'] = planId;
    _data['dietCategoryId'] = dietCategoryId;
    _data['caloriesId'] = caloriesId;
    _data['mealsPerDayId'] = mealsPerDayId;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['vat'] = vat;
    _data['totalAmount'] = totalAmount;
    _data['dieticianAssessment'] = dieticianAssessment;
    _data['deliveryMethod'] = deliveryMethod;
    _data['orderStatus'] = orderStatus;
    _data['createdBy'] = createdBy;
    _data['updatedBy'] = updatedBy;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['mealCategories'] = mealCategories.map((e) => e.toJson()).toList();
    _data['checkoutFlag'] = checkoutFlag;
    _data['plan'] = plan.toJson();
    return _data;
  }
}

class MealCategories {
  MealCategories({
    required this.id,
    required this.orderId,
    required this.mealCategoryId,
    required this.lineItems,
    required this.mealCategory,
  });
  late final int id;
  late final int orderId;
  late final int mealCategoryId;
  late final List<LineItems> lineItems;
  late final MealCategory mealCategory;

  MealCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    mealCategoryId = json['mealCategoryId'];
    lineItems =
        List.from(json['lineItems']).map((e) => LineItems.fromJson(e)).toList();
    mealCategory = MealCategory.fromJson(json['mealCategory']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['orderId'] = orderId;
    _data['mealCategoryId'] = mealCategoryId;
    _data['lineItems'] = lineItems.map((e) => e.toJson()).toList();
    _data['mealCategory'] = mealCategory.toJson();
    return _data;
  }
}

class LineItems {
  LineItems({
    required this.id,
    required this.orderMealCatId,
    required this.dietCategoryMealItemsId,
    required this.mealItemId,
    this.status,
    required this.orderDate,
  });
  late final int id;
  late final int orderMealCatId;
  late final int dietCategoryMealItemsId;
  late final int mealItemId;
  late final Null status;
  late final String orderDate;

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderMealCatId = json['orderMealCatId'];
    dietCategoryMealItemsId = json['dietCategoryMealItemsId'];
    mealItemId = json['mealItemId'];
    status = null;
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['orderMealCatId'] = orderMealCatId;
    _data['dietCategoryMealItemsId'] = dietCategoryMealItemsId;
    _data['mealItemId'] = mealItemId;
    _data['status'] = status;
    _data['orderDate'] = orderDate;
    return _data;
  }
}

class MealCategory {
  MealCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.selectedImage,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String selectedImage;

  MealCategory.fromJson(Map<String, dynamic> json) {
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

class Plan {
  Plan({
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

  Plan.fromJson(Map<String, dynamic> json) {
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
