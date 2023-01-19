/// This class defines all Api EndPoints
// ignore_for_file: constant_identifier_names

class ApiConstant {
  //Api Time out
  static const int TIMEOUT = 1000000;

  static const GETONBOARDDATA = "/api/user/goals/get/all";
  static const GETDIETCATEGORY = "/api/user/diet/get";
  static const LoginAuth = "/auth/login";
  static const daysPlan = "/api/user/plans/get/all";
  static const getdaysplanbycatID = "/api/user/plans/get-by-diet-category/";
  static const getmealperday = "/api/user/meal-per-day/get/all";
  static const createcart = "/api/user/order/save/cart";
  static const checkcart = "/api/user/order/get/cart";
  static const getMealItem = "/api/user/meal/get";
  static const login = "/auth/login";
  static const register = "/auth/register";
  static const additemtocart = "/api/user/order/save/item";
  static const verifyotp = "/auth/validate";
  static const deleteItemfromCart = "/api/user/order/delete/item";
  static const deletecart = "/api/user/order/delete/cart";
  static const guesttoken = "/auth/guest-login";
  static const orderHistiry = "/api/user/order/history";
  static const updateProfile = "/api/user/profile/update";
  static const updateCartdate = "/api/user/order/update/cart/start";
  static const checkdates = "/api/user/order/verify/cart";
  static const resendotp = "/auth/resend-otp";
  static const resetpassword = "/auth/reset-password";
  static const requestotp = "/auth/resend-password-reset-otp";
  static const saveaddress = "/api/user/user-address/save";
  static const getaddress = "/api/user/user-address/get?userId=";
  static const placeOrder = "/api/user/order/place";
  static const verifyPayment = "/api/user/order/verify-payment";
  static const userprofile = "/api/user/profile";
  static const appprerequestdata = "/api/setting/master-data/get";
  static const getMealDetailHistoryData = "/api/user/order/get/";
}
