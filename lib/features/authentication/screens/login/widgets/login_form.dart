import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/utils/validator/validator.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/login_controller.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceDefault),
        child: Column(
          children: [
            /// Mobile No
            TextFormField(
              controller: controller.mobileNo,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) => TValidator.validateMobileNo(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.call_copy), labelText: TText.mobileNo),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField,),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                textInputAction: TextInputAction.done,
                validator: (value) => TValidator.validatePassword(value),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check_copy),
                    labelText: TText.password,
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField / 2,),

            Row(
              children: [
                Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                const Text(TText.rememberMe)
              ],
            ),

            const SizedBox(height: TSizes.spaceDefault,),

            SizedBox(width: TSizes.maxBtnWidth,child: ElevatedButton(onPressed: () => controller.mobileNoAndPasswordLogin(), child: const Text(TText.logIn))),

            const SizedBox(height: TSizes.spaceBtwSections,),

          ],
        ),
      ),
    );
  }
}