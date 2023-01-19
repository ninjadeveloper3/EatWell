import 'package:eat_well/api-handler/api-extention.dart';

import '../constant/api_constants.dart';
import 'api-handler.dart';

class ApiRepository {
  ApiRepository(this._apiHelper);

  final ApiBaseHelper _apiHelper;

// get onBoardData
  Future getOnboardData() async {
    return _apiHelper
        .getWithoutParams(
          ApiConstant.GETONBOARDDATA,
        )
        .execute((response) => response);
  }

  // get diet Category
  Future getDietCategory(String goalId, String loginToken) async {
    return _apiHelper
        .getWithParamUrl(
            ApiConstant.GETDIETCATEGORY, '?goalId=$goalId', loginToken)
        .execute((response) => response);
  }

  // get diet Category
  Future getMealperDayList(String loginToken) async {
    return _apiHelper
        .getWithAccessToken(
          ApiConstant.getmealperday,
        )
        .execute((response) => response);
  }

  //// save address

  Future saveAddress(Map<String, dynamic> param) async {
    return _apiHelper
        .post(ApiConstant.saveaddress, param)
        .execute((response) => response);
  }

  //// get Address

  Future getAddress(String userID) async {
    return _apiHelper
        .getWithAccessToken(
          ApiConstant.getaddress + userID,
        )
        .execute((response) => response);
  }

  /// get Order History Meal detail
  // get onBoardData
  Future getMealHistoryData(int id) async {
    return _apiHelper
        .getWithoutParams(
          ApiConstant.getMealDetailHistoryData + id.toString(),
        )
        .execute((response) => response);
  }

  // place order
  Future placeOrder(Map<String, dynamic> placeorder) async {
    return _apiHelper
        .post(
          ApiConstant.placeOrder,
          placeorder,
        )
        .execute((response) => response);
  }

  //// Verify Payment
  Future verifyPaymentStatus(Map<String, dynamic> param) async {
    return _apiHelper
        .post(
          ApiConstant.verifyPayment,
          param,
        )
        .execute((response) => response);
  }

  // get diet Plans
  Future getDietplans(String loginToken, String catID) async {
    return _apiHelper
        .getWithAccessToken(
          ApiConstant.getdaysplanbycatID + catID,
        )
        .execute((response) => response);
  }

  ////get Meal Item

  Future getMealItem(String goalID, String dietCategoryId) async {
    return _apiHelper
        .getWithAccessToken(
          '${ApiConstant.getMealItem}?goalId=$goalID&dietCategoryId=$dietCategoryId',
        )
        .execute((response) => response);
  }

///// updatedate of cart
  Future updateCArtdate(Map<String, dynamic> param) async {
    return _apiHelper
        .put(ApiConstant.updateCartdate, param)
        .execute((response) => response);
  }

  ///// check/valide selected dates of cart
  Future checkdates(Map<String, dynamic> param) async {
    return _apiHelper
        .post(ApiConstant.checkdates, param)
        .execute((response) => response);
  }

  // Login User
  Future login(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithoutHeader(ApiConstant.login, params)
        .execute((response) => response);
  }

  //// verify otp

  Future verifyOtp(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithoutHeader(ApiConstant.verifyotp, params)
        .execute((response) => response);
  }

  /// resend otp

  Future resendotp(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithoutHeader(ApiConstant.resendotp, params)
        .execute((response) => response);
  }

  /// reset password

  Future resettpassword(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithoutHeader(ApiConstant.resetpassword, params)
        .execute((response) => response);
  }

  /// reuestotp

  Future requestotp(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithoutHeader(ApiConstant.requestotp, params)
        .execute((response) => response);
  }
  // register User

  Future signUp(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithoutHeader(ApiConstant.register, params)
        .execute((response) => response);
  }

  ///getToken for now

  Future getToken() async {
    Map<String, dynamic> login = {
      'email': 'furqan.arshad@devbatch.com',
      'password': 'admin'
    };
    return _apiHelper
        .post(ApiConstant.LoginAuth, login)
        .execute((response) => response);
  }

///// guest token

  Future guestToken(String deviceID) async {
    Map<String, dynamic> guesttoken = {
      'deviceId': deviceID,
    };
    return _apiHelper
        .guestpost(ApiConstant.guesttoken, guesttoken)
        .execute((response) => response);
  }

  /// get order History
  ///
  ///
  Future getOrderHistory() async {
    return _apiHelper
        .getWithoutParams(
          ApiConstant.orderHistiry,
        )
        .execute((response) => response);
  }

  /// update profile
  Future updateProfile(Map<String, dynamic> params) async {
    return _apiHelper
        .postWithformdata(ApiConstant.updateProfile, params)
        .execute((response) => response);
  }

  // get user profile
  Future getUserProfile() async {
    return _apiHelper
        .getWithoutParams(
          ApiConstant.userprofile,
        )
        .execute((response) => response);
  }

  // app pre request data
  Future getPrerequestdata() async {
    return _apiHelper
        .getWithAccessToken(
          ApiConstant.appprerequestdata,
        )
        .execute((response) => response);
  }

  // create a cart
  Future createCart(Map<String, dynamic> param) async {
    return _apiHelper
        .post(ApiConstant.createcart, param)
        .execute((response) => response);
  }

  /// add item to cart

  Future addtoCart(Map<String, dynamic> param) async {
    return _apiHelper
        .post(ApiConstant.additemtocart, param)
        .execute((response) => response);
  }

  /// delete item from cart
  Future deleteItem(String param) async {
    return _apiHelper
        .delete(ApiConstant.deleteItemfromCart, param)
        .execute((response) => response);
  }

  /// delete cart

  Future deleteCart(String param) async {
    return _apiHelper
        .delete(ApiConstant.deletecart, param)
        .execute((response) => response);
  }

  // get checkcart
  Future checkUserCart(String userID, String accessToken) async {
    return _apiHelper
        .getwithauthparam(
          '${ApiConstant.checkcart}?userId=$userID',
          accessToken,
        )
        .execute((response) => response);
  }
}
