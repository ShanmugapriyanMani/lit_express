import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/member/library/controllers/checkout_list_controller.dart';
import 'package:lit_express/utils/constants/sizes.dart';
import 'package:lit_express/utils/local_storage/checkout_list_helper.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helper/helper_functions.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.bookId,
    required this.authorId,
    required this.categoryId,
    required this.publisherId,
    required this.bookName,
    required this.description,
    required this.coverImage,
    required this.libraryBookCode,
    required this.isbn,
    required this.createdDate,
    required this.categoryName,
    required this.authorName,
    required this.languageName,
    required this.publisherName,
    required this.stockAvailable
  });

  final String bookId;
  final String authorId;
  final String categoryId;
  final String publisherId;
  final String bookName;
  final String description;
  final String coverImage;
  final String libraryBookCode;
  final String isbn;
  final String createdDate;
  final String categoryName;
  final String authorName;
  final String languageName;
  final String publisherName;
  final String stockAvailable;

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.put(TCheckoutBooksController());
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ActionSlider.standard(
        sliderBehavior: SliderBehavior.stretch,
        backgroundColor: TColors.primaryColor,
        successIcon: const Icon(Iconsax.tick_circle, color: TColors.primaryColor,),
        toggleColor: dark ? TColors.darkGrey : TColors.white,
        icon: const Icon(Iconsax.arrow_right_2, color: TColors.primaryColor, size: TSizes.xl),
        loadingIcon: const SizedBox(
            width: 50,
            child: Center(
                child: SizedBox(
                  width: 26.0,
                  height: 26.0,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.0, color: TColors.primaryColor),
                ))),
        action: (controller) async {
          controller.loading();
          await Future.delayed(const Duration(milliseconds: 1500));
          controller.success();
          await Future.delayed(const Duration(milliseconds: 500));
          controller.reset();
          checkoutController.isCheckoutBooksAvailable.value = true;

          await CheckOutListHelper.instance.insertBookData({
            'bookId': bookId,
            'authorId': authorId,
            'categoryId': categoryId,
            'publisherId': publisherId,
            'bookName': bookName,
            'description': description,
            'coverImage': coverImage,
            'libraryBookCode': libraryBookCode,
            'isbn': isbn,
            'createdDate': createdDate,
            'categoryName': categoryName,
            'authorName': authorName,
            'languageName': languageName,
            'publisherName': publisherName,
            'stockAvailable': stockAvailable,
          });
          final data = await CheckOutListHelper.instance.getBookListData();
          checkoutController.addCheckOutBooks(data);
          Get.back();
        },
        child: Text('Slide to add book', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: dark ? TColors.dark : TColors.white, fontWeight: FontWeight.w500),),
      ),
    );
  }
}