import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../models/books_model.dart';
import 'categories_controller.dart';

class TFilteredBooksController extends GetxController {
  static TFilteredBooksController get instance => Get.find();

  Rx<int> pageNo = 0.obs;
  RxBool hasReachedEnd = false.obs;
  RxBool isBookAvailable = false.obs;
  RxBool isInternetAvailable = true.obs;

  RxList<Books> filteredBookList = <Books>[].obs;

  ScrollController scrollControllerForFilteredBooks = ScrollController();
  final networkConnectivity = Get.put(NetworkConnectivity());
  final categoriesController = Get.put(TCategoriesController());


  Future<void> fetchFilteredBooks(String selectedCategoryId, String selectedLanguageId, String selectedAuthorId) async {
    scrollControllerForFilteredBooks.addListener(onScrollForFilter);
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }
    pageNo.value++;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    final booksList = await apiService.requestForFilteredBooks(selectedCategoryId, selectedLanguageId, selectedAuthorId, pageNo.value);
    isBookAvailable.value = (booksList.isNotEmpty) ? true : false;
    if (isBookAvailable.value == true) {
      filteredBooks(booksList);
    }
  }

  void filteredBooks(List<Map<String, dynamic>> booksData) {
    for (var bookData in booksData) {
      Books book = Books();
      book.bookId = bookData['book_id'];
      book.authorId = bookData['auther_id'];
      book.categoryId = bookData['category_id'];
      book.publisherId = bookData['publisher_id'];
      book.bookName = bookData['book_name'];
      book.description = bookData['description'];
      book.coverImage = bookData['cover_image'] ?? '';
      book.libraryBookCode = bookData['library_book_code'];
      book.isbn = bookData['isbn'];
      book.createdDate = bookData['created_date'];
      book.categoryName = bookData['category_name'];
      book.authorName = bookData['auther_name'];
      book.languageName = bookData['language_name'];
      book.publisherName = bookData['publisher_name'];
      book.stockAvailable = bookData['stock_available'];
      filteredBookList.add(book);
    }
    update();
  }

  void onScrollForFilter() {
    if (scrollControllerForFilteredBooks.position.pixels == scrollControllerForFilteredBooks.position.maxScrollExtent) {
      hasReachedEnd.value = true;
      isBookAvailable.value = true;
    } else {
      hasReachedEnd.value = false;
      isBookAvailable.value = false;
    }
  }

  Widget circularIndicator() {
    if (hasReachedEnd.value && isBookAvailable.value) {
      hasReachedEnd.value = false;
      fetchFilteredBooks(categoriesController.selectedCategoryId.value, categoriesController.selectedLanguageId.value, categoriesController.selectedAuthorId.value);
      return const CircularProgressIndicator(color: TColors.primaryColor,);
    } else {
      return Container();
    }
  }

  void clearFilteredData() {
    categoriesController.isSelectedCategoryIndex.value = 0;
    categoriesController.isSelectedCategoryIndex.value = -1.obs;
    categoriesController.isSelectedLanguageIndex.value = -1.obs;
    categoriesController.isSelectedAuthorIndex.value = -1.obs;
    categoriesController.selectedCategoryId.value = '';
    categoriesController.selectedLanguageId.value = '';
    categoriesController.selectedAuthorId.value = '';
    categoriesController.selectedCategory.value = '';
    categoriesController.selectedLanguage.value = '';
    categoriesController.selectedAuthor.value = '';
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollControllerForFilteredBooks.dispose();
  }

}