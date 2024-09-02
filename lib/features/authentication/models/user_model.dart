import 'package:get/get.dart';

class UserModelController extends GetxController {

  static UserModelController get instance => Get.find<UserModelController>();

  late String userId;
  late String memberId;
  late String userType;
  late String firstName;
  late String lastName;
  late String libraryMemberCode;
  late String avatar;
  late String phone;
  late String token;
  late String tokenExpiry;

  Future<void> setUser(Map<String, dynamic> newUser) async {
    userId = newUser['user_id'] ?? '';
    memberId = newUser['member_id'] ?? '';
    userType = newUser['user_type'] ?? '';
    firstName = newUser['first_name'] ?? '';
    lastName = newUser['last_name'] ?? '';
    libraryMemberCode = newUser['library_member_code'] ?? '';
    avatar = newUser['avatar'] ?? '';
    phone = newUser['phone'] ?? '';

    if (newUser['token'] is Map<String, dynamic>) {
      token = newUser['token']['token'] ?? '';
      tokenExpiry = newUser['token']['token_expiry'] ?? '';
    } else {
      token = newUser['token'] ?? '';
      tokenExpiry = newUser['token_expiry'] ?? '';
    }

    update();
  }
}
