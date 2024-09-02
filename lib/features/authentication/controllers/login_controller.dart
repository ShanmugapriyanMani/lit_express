import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lit_express/connectivity/network_connectivity.dart';
import 'package:lit_express/features/authentication/models/user_model.dart';
import 'package:lit_express/utils/constants/image_strings.dart';
import 'package:lit_express/common/widgets/loader/screen_loader.dart';

import '../../../common/widgets/snack_bar.dart';
import '../../../data/repository/authentication_repository.dart';
import '../../../data/service/api_service.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/local_storage/user_database_helper.dart';
import '../../librarian/library/screens/lhome/lhome_screen.dart';
import '../../member/library/screens/home/home_screen.dart';

class LoginController extends GetxController {

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final mobileNo = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final localStage = GetStorage();

  final networkConnectivity = Get.put(NetworkConnectivity());
  final authenticationRepository = Get.put(AuthenticationRepository());
  final  userModelController = Get.put(UserModelController());

  @override
  void onInit() {
    mobileNo.text = localStage.read("REMEMBER_ME_MOBILE_NO") ?? '';
    password.text = localStage.read("REMEMBER_ME_PASSWORD") ?? '';
    super.onInit();
  }

  Future<void> mobileNoAndPasswordLogin() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingScreen("Loading...", TImages.loadingAnimation);

      // Check internet connection
      final isConnected = await networkConnectivity.isConnected();
      if (!isConnected) {
        TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save remember me
      if (rememberMe.value) {
        localStage.write('REMEMBER_ME_MOBILE_NO', mobileNo.text.trim());
        localStage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using mobile no and password authentication
      final userData = await authenticateWithUsernameAndMobileNo(mobileNo.text, password.text);
      debugPrint('${userData?['user_id']}');

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Redirect
      if (userData?["user_type"] == "Member") {
        TSnackBar.successSnackBar(title: 'Login successfully', message: TText.successMessage);
        Get.offAll(() => const HomeScreen());
      }
      else if (userData?["user_type"] == "Librarian") {
        TSnackBar.successSnackBar(title: 'Login successfully', message: TText.successMessage);
        Get.offAll(() => const LHomeScreen());
      } else {
        TSnackBar.errorSnackBar(title: "Login failed!", message: "Invalid mobile no or password");
      }

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TSnackBar.errorSnackBar(title: 'On Snap', message: e.toString());
    }

  }

  Future<Map<String, dynamic>?> authenticateWithUsernameAndMobileNo(String username, String password) async {
    try {
      final authService = ApiService(baseUrl: TText.baseUrl);
      Map<String, dynamic> responseData = await authService.authenticate(username, password);
      if (responseData.isNotEmpty) {
        await userModelController.setUser(responseData);
        await UserDatabaseHelper.instance.clearUserData();
        await UserDatabaseHelper.instance.insertUserData({
          'user_id': responseData['user_id'] ?? "",
          'member_id': responseData['member_id'] ?? "",
          'user_type': responseData['user_type'] ?? "",
          'first_name': responseData['first_name'] ?? "",
          'last_name': responseData['last_name'] ?? "",
          'library_member_code': responseData['library_member_code'] ?? "",
          'avatar': responseData['avatar'] ?? "",
          'phone': responseData['phone'] ?? "",
          'token': responseData['token']['token'] ?? "",
          'token_expiry': responseData['token']['token_expiry'] ?? "",
        });
        return responseData;
      }
      debugPrint('$responseData');
    } catch (e) {
      debugPrint('Authentication failed: $e');
      return null;
    }
    return null;
  }

}