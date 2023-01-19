import 'package:get_storage/get_storage.dart';

final box = GetStorage();

/////// . /////// //// . storage keys used==> AccessToken,UserID,roleID,roleName,fullname,phonenumber,email,guestToken, guestID
///
///
///

Future<String> getAccessToken() async {
  var token = box.read('AccessToken');

  return token.toString();
}

Future<String> savedLocale() async {
  var token = box.read('locale');

  return token.toString();
}

Future<String> getuserId() async {
  var userId = box.read('UserID');

  return userId.toString();
}

Future<String> getrolename() async {
  var rolename = box.read('roleName');

  return rolename.toString();
}

Future<String> getroleid() async {
  var roleid = box.read('roleID');

  return roleid.toString();
}

Future<String> getusername() async {
  var name = box.read('fullname');

  return name.toString();
}

Future<String> getemail() async {
  var email = box.read('email');

  return email.toString();
}

Future<String> getGuestToken() async {
  var guesttoken = box.read('GuestToken');

  return guesttoken.toString();
}

Future<String> getguestId() async {
  var guestID = box.read('GuestID');

  return guestID.toString();
}

Future<String> getphonenumber() async {
  var phonenum = box.read('phonenumber');

  return phonenum.toString();
}

cLearEvertyThing() {
  box.remove('AccessToken');
  box.remove('UserID');
  box.remove('roleName');
  box.remove('roleID');
  box.remove('fullname');
  box.remove('email');
  box.remove('phonenumber');
  box.remove('GuestToken');
  box.remove('GuestID');
}
