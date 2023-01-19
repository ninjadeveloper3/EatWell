// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_void_to_null

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
  late final OngoingOrderDetailModel data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = OngoingOrderDetailModel.fromJson(json['data']);
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

class OngoingOrderDetailModel {
  OngoingOrderDetailModel({
    this.id,
    this.userId,
    this.addressId,
    this.goalId,
    this.planId,
    this.dietCategoryId,
    this.caloriesId,
    this.mealsPerDayId,
    this.startDate,
    required this.endDate,
    this.price,
    this.discount,
    this.vat,
    this.totalAmount,
    this.dieticianAssessment,
    this.deliveryMethod,
    this.orderStatus,
    this.contactName,
    this.contactEmail,
    this.contactNumber,
    this.createdBy,
    this.updatedBy,
    required this.details,
  });
  late final int? id;
  late final int? userId;
  late final Null addressId;
  late final int? goalId;
  late final int? planId;
  late final int? dietCategoryId;
  late final int? caloriesId;
  late final int? mealsPerDayId;
  late final String? startDate;
  late final String? endDate;
  late final Null price;
  late final Null discount;
  late final Null vat;
  late final Null totalAmount;
  late final int? dieticianAssessment;
  late final Null deliveryMethod;
  late final int? orderStatus;
  late final Null contactName;
  late final Null contactEmail;
  late final Null contactNumber;
  late final int? createdBy;
  late final Null updatedBy;
  late final List<Details> details;

  OngoingOrderDetailModel.fromJson(Map<String, dynamic> json) {
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
    details =
        List.from(json['details']).map((e) => Details.fromJson(e)).toList();
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
    _data['details'] = details.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Details {
  Details({
    required this.orderId,
    required this.orderUserId,
    required this.orderPlanId,
    required this.planDuration,
    required this.planName,
    required this.omcMealCategoryId,
    required this.mealCategoryId,
    required this.mcName,
    required this.mcImage,
    required this.mealItemId,
    required this.mealName,
    required this.mealDescription,
    required this.oliOrderDate,
  });
  late final int orderId;
  late final int orderUserId;
  late final int orderPlanId;
  late final int planDuration;
  late final String planName;
  late final int omcMealCategoryId;
  late final int mealCategoryId;
  late final String mcName;
  late final String mcImage;
  late final int mealItemId;
  late final String mealName;
  late final String mealDescription;
  late final String oliOrderDate;

  Details.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderUserId = json['orderUserId'];
    orderPlanId = json['orderPlanId'];
    planDuration = json['planDuration'];
    planName = json['planName'];
    omcMealCategoryId = json['omcMealCategoryId'];
    mealCategoryId = json['mealCategoryId'];
    mcName = json['mcName'];
    mcImage = json['mcImage'];
    mealItemId = json['mealItemId'];
    mealName = json['mealName'];
    mealDescription = json['mealDescription'];
    oliOrderDate = json['oliOrderDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderId'] = orderId;
    _data['orderUserId'] = orderUserId;
    _data['orderPlanId'] = orderPlanId;
    _data['planDuration'] = planDuration;
    _data['planName'] = planName;
    _data['omcMealCategoryId'] = omcMealCategoryId;
    _data['mealCategoryId'] = mealCategoryId;
    _data['mcName'] = mcName;
    _data['mcImage'] = mcImage;
    _data['mealItemId'] = mealItemId;
    _data['mealName'] = mealName;
    _data['mealDescription'] = mealDescription;
    _data['oliOrderDate'] = oliOrderDate;
    return _data;
  }
}
