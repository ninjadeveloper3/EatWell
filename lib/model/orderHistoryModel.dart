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
  late final List<OrderHistoryModel> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data'])
        .map((e) => OrderHistoryModel.fromJson(e))
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

class OrderHistoryModel {
  OrderHistoryModel({
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
    this.contactName,
    this.contactEmail,
    this.contactNumber,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    this.updatedAt,
    required this.mealCategories,
    required this.user,
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
  late final Null contactName;
  late final Null contactEmail;
  late final Null contactNumber;
  late final int createdBy;
  late final Null updatedBy;
  late final String createdAt;
  late final Null updatedAt;
  late final List<MealCategories> mealCategories;
  late final User user;
  late final bool checkoutFlag;
  late final Plan plan;

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
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
    contactName = null;
    contactEmail = null;
    contactNumber = null;
    createdBy = json['createdBy'];
    updatedBy = null;
    createdAt = json['createdAt'];
    updatedAt = null;
    mealCategories = List.from(json['mealCategories'])
        .map((e) => MealCategories.fromJson(e))
        .toList();
    user = User.fromJson(json['user']);
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
    _data['contactName'] = contactName;
    _data['contactEmail'] = contactEmail;
    _data['contactNumber'] = contactNumber;
    _data['createdBy'] = createdBy;
    _data['updatedBy'] = updatedBy;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['mealCategories'] = mealCategories.map((e) => e.toJson()).toList();
    _data['user'] = user.toJson();
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
  late final List<dynamic> lineItems;
  late final MealCategory mealCategory;

  MealCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    mealCategoryId = json['mealCategoryId'];
    lineItems = List.castFrom<dynamic, dynamic>(json['lineItems']);
    mealCategory = MealCategory.fromJson(json['mealCategory']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['orderId'] = orderId;
    _data['mealCategoryId'] = mealCategoryId;
    _data['lineItems'] = lineItems;
    _data['mealCategory'] = mealCategory.toJson();
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

class User {
  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.displayName,
    required this.prefix,
    this.dob,
    required this.phoneNumber,
    required this.email,
    required this.role,
    this.guestDeviceId,
    required this.userType,
    this.imageUrl,
    this.gender,
  });
  late final int id;
  String? firstName;
  String? lastName;
  late final Null middleName;
  late final Null displayName;
  late final String prefix;
  late final Null dob;
  late final String phoneNumber;
  late final String email;
  late final Role role;
  late final Null guestDeviceId;
  late final String userType;
  String? imageUrl;
  late final Null gender;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = null;
    displayName = null;
    prefix = json['prefix'];
    dob = null;
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    role = Role.fromJson(json['role']);
    guestDeviceId = null;
    userType = json['userType'];
    imageUrl = json['imageUrl'];
    gender = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['middleName'] = middleName;
    _data['displayName'] = displayName;
    _data['prefix'] = prefix;
    _data['dob'] = dob;
    _data['phoneNumber'] = phoneNumber;
    _data['email'] = email;
    _data['role'] = role.toJson();
    _data['guestDeviceId'] = guestDeviceId;
    _data['userType'] = userType;
    _data['imageUrl'] = imageUrl;
    _data['gender'] = gender;
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
