import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/utils/constants/colors.dart';
import 'package:lit_express/utils/constants/image_strings.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/helper/helper_functions.dart';
import '../../controllers/checkout_list_controller.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutBooksController = Get.put(TCheckoutBooksController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.white),
          "Check out",
        ),
        backgroundColor: TColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if ((checkoutBooksController.isCheckoutBooksAvailable.value) && (checkoutBooksController.checkoutBookList.isNotEmpty)) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: checkoutBooksController.checkoutBookList.length,
                    itemBuilder: (_, index) {
                      return Card(
                        color: (checkoutBooksController.checkoutBookList[index].checkoutFlagAdd.value == false && checkoutBooksController.checkoutBookList[index].checkoutFlagRemove.value == true)
                            ? TColors.grey.withOpacity(0.8)
                            : TColors.primaryColor.withOpacity(0.9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Delete",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: Get.overlayContext!,
                                      barrierDismissible: false,
                                      builder: (_) => _deleteFromCard(context, index, checkoutBooksController.checkoutBookList[index].bookId, checkoutBooksController),
                                    );

                                  },
                                  icon: const Icon(
                                    Iconsax.trash,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  checkoutBooksController.checkoutBookList[index].coverImage == ''
                                      ? Image.asset(
                                    TImages.booksPlaceholder,
                                    scale: 4,
                                  )
                                      : Image.asset(checkoutBooksController.checkoutBookList[index].coverImage),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.7,
                              color: checkoutBooksController.checkoutBookList[index].checkoutFlagAdd.value == true
                                  ? TColors.white
                                  : TColors.primaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  const Text('Book: '),
                                  Flexible(
                                    child: Text(
                                      checkoutBooksController.checkoutBookList[index].bookName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  const Text('Author: '),
                                  Flexible(
                                    child: Text(
                                      checkoutBooksController.checkoutBookList[index].authorName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  const Text('ISBN: '),
                                  Flexible(
                                    child: Text(
                                      checkoutBooksController.checkoutBookList[index].isbn,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: dark ? TColors.dark : TColors.light,
                margin: const EdgeInsets.only(top: 12.0),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(
                  width: THelperFunctions.screenWidth() * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      TCheckoutBooksController.openLoadingScreen("Loading...", TImages.loadingAnimation);
                      // Trigger the actual request here
                      checkoutBooksController.sendBookRequest();
                    },
                    child: Text(
                      'Request',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TColors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  TImages.noBooksPlaceholder,
                  animate: true,
                  width: 150,
                  height: 150,
                  repeat: true
                ),
                Text(
                  "No books added!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
  Widget _deleteFromCard(BuildContext context, int index, String bookId, TCheckoutBooksController checkoutBooksController) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Are you want to delete this card?", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 100, child: OutlinedButton(onPressed: () {Navigator.pop(context);}, child: Text("No", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primaryColor),))),
                SizedBox(width: 100, child: ElevatedButton(onPressed: () {checkoutBooksController.removeBookAtIndex(index, bookId); Navigator.of(context).pop();}, child: Text("Yes", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.white))))
              ],
            )
          ],
        ),
      ),
    );
  }
}


class CustomDialog extends StatelessWidget {
  final String text;
  final String animation;

  const CustomDialog({super.key, required this.text, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 150, vertical: 360),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Builder(
        builder: (context) {
          return Lottie.asset(
            animation,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
