import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../common/widgets/snack_bar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/ldetails_request_controller.dart';
import '../../lhome/lhome_screen.dart';

class PendingRequestSlider extends StatelessWidget {
  const PendingRequestSlider({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final lDetailsController = Get.put(LDetailsController());
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ActionSlider.standard(
        sliderBehavior: SliderBehavior.stretch,
        backgroundColor: TColors.primaryColor,
        successIcon: const Icon(Iconsax.tick_circle, color: TColors.primaryColor,),
        // failureIcon: const Icon(Icons.close, color: TColors.error,),
        toggleColor: dark ? TColors.darkGrey : TColors.white,
        icon: const Icon(Iconsax.arrow_right_2, color: TColors.primaryColor, size: TSizes.xl),
        loadingIcon: const SizedBox(
            width: 50,
            child: Center(
                child: SizedBox(
                  width: 26.0,
                  height: 26.0,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.0, color: TColors.primaryColor),),
            ),
        ),

        action: (controller) async {
          controller.loading();
          await Future.delayed(const Duration(milliseconds: 1500));
          bool result = await lDetailsController.approveRequestedBook(requestId);
          if (result) {
            controller.success();
            await Future.delayed(const Duration(milliseconds: 1000));
            lDetailsController.isSlideToApprove.value = true;
            lDetailsController.removePendingRequest(requestId);
            Get.to(() => const LHomeScreen());
          } else {
            controller.failure();
            await Future.delayed(const Duration(milliseconds: 1000));
            TSnackBar.warningSnackBar(title: "Failed to Processed the Request",  message: "Bad request was initiated or Try after sometimes.");
          }
          controller.reset();
        },
        child: Text('Slide to approve', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: dark ? TColors.dark : TColors.white, fontWeight: FontWeight.w500),),
      ),
    );
  }
}
