import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lit_express/features/authentication/models/user_model.dart';
import 'package:lit_express/features/authentication/screens/onboarding/onboarding.dart';
import 'package:lit_express/features/member/library/screens/home/home_screen.dart';
import '../../features/librarian/library/screens/lhome/lhome_screen.dart';
import '../../utils/local_storage/user_database_helper.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();
  /// Variables
  final deviceStorage = GetStorage();

  Future<void> screenRedirect() async {
    try {
      final userData = await UserDatabaseHelper.instance.getUserData();
      final userModelController = Get.put(UserModelController());
      if (userData != null && userData['user_id'] != null) {
        await userModelController.setUser(userData);
        final String? tokenExpiryString = userData['token_expiry'];
        if (tokenExpiryString != null) {
          final DateTime tokenExpiry = DateTime.parse(tokenExpiryString);
          if (tokenExpiry.isAfter(DateTime.now())) {
            if(userModelController.userType == "Member") {
              Get.offAll(() => const HomeScreen());
            } else if ((userModelController.userType == "Librarian")){
              Get.offAll(() => const LHomeScreen());
            } else {
              throw Exception('User type error!');
            }
          }
          else {
            throw Exception('Token expiry!');
          }
        }
        else {
          throw Exception('Invalid token!');
        }
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      Get.offAll(() => const OnBoardingScreen());
    }
  }

}