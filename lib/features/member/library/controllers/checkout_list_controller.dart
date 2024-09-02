import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lit_express/features/member/library/screens/home/home_screen.dart';
import 'package:lit_express/utils/local_storage/checkout_list_helper.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/widgets/loader/animation_loader.dart';
import '../../../../common/widgets/snack_bar.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../models/books_model.dart';
import '../screens/checkout/checkout_screen.dart';

class TCheckoutBooksController extends GetxController {
  static TCheckoutBooksController get instance => Get.find();

  RxList<Books> checkoutBookList = <Books>[].obs;
  RxBool isCheckoutBooksAvailable = false.obs;
  RxBool isSlideToRequested = false.obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    fetchCheckoutList();
    super.onInit();
  }


  Future<void> fetchCheckoutList() async {
    final bookListData = await CheckOutListHelper.instance.getBookListData();

    if (bookListData.isNotEmpty) {
      isCheckoutBooksAvailable.value = true;
      addCheckOutBooks(bookListData);
    } else {
      isCheckoutBooksAvailable.value = false;
    }

  }

  void addCheckOutBooks(List<Map<String, dynamic>?> bookListData) {
    checkoutBookList.clear();
    for (var bookData in bookListData) {
      Books book = Books();
      book.bookId = bookData?['bookId'];
      book.authorId = bookData?['authorId'];
      book.categoryId = bookData?['categoryId'];
      book.publisherId = bookData?['publisherId'];
      book.bookName = bookData?['bookName'];
      book.description = bookData?['description'];
      book.coverImage = bookData?['coverImage'] ?? '';
      book.libraryBookCode = bookData?['libraryBookCode'];
      book.isbn = bookData?['isbn'];
      book.createdDate = bookData?['createdDate'];
      book.categoryName = bookData?['categoryName'];
      book.authorName = bookData?['authorName'];
      book.languageName = bookData?['languageName'];
      book.publisherName = bookData?['publisherName'];
      book.stockAvailable = bookData?['stockAvailable'];
      checkoutBookList.add(book);
    }
    update();
  }

  Future<void> removeBookAtIndex(int index, String bookId) async {
    if (index >= 0 && index < checkoutBookList.length) {
      checkoutBookList.removeAt(index);
      isCheckoutBooksAvailable.value = checkoutBookList.isEmpty ? false : true;
      await CheckOutListHelper.instance.deleteBookById(bookId);
    } else {
      print('Index out of range');
    }
  }


  Future<void> sendBookRequest() async {
    isLoading.value = true;
    List<String> booksIdList = [];
    for (var book in checkoutBookList) {
      booksIdList.add(book.bookId.toString());
    }
    try {
      if (booksIdList.isEmpty) {
        Navigator.of(Get.overlayContext!).pop();
        TSnackBar.warningSnackBar(title: "Card is empty!", message: "Add book to initiate a request");
        throw Exception("Card is empty!");
      }
      final apiService = ApiService(baseUrl: TText.baseUrl);
      bool result = await apiService.requestForBooks(booksIdList);
      if (result) {
        checkoutBookList.clear();
        isCheckoutBooksAvailable.value = false;
        Get.to(() => const HomeScreen());
      }
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  static void openLoadingScreen(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => CustomDialog(
        text: text,
        animation: animation,
      ),
    );
  }

}