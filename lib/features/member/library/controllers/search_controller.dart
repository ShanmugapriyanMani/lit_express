import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/text_strings.dart';
import '../models/books_model.dart';

class TSearchController extends GetxController {
  static TSearchController get instance => Get.find();

  RxList<Books> searchedBookList = <Books>[].obs;
  final searchTextEditingController = TextEditingController();
  RxString searchText = ''.obs;
  RxBool isInternetAvailable = true.obs;
  RxBool isBooksAvailable = false.obs;
  RxBool isLoading = false.obs;
  final networkConnectivity = Get.put(NetworkConnectivity());


  Future<void> getBooksForSearch(String query) async {
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }
    isLoading.value = true;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    List<Map<String, dynamic>> booksList = await apiService.getRequestForSearchBooks(query);
    isBooksAvailable.value = (booksList.isNotEmpty) ? true : false;
    if (isBooksAvailable.value == true) {
      searchedBooks(booksList);
    }
    isLoading.value = false;
  }

  // Searched books
  void searchedBooks(List<Map<String, dynamic>> booksData) {
    searchedBookList.clear();
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
      searchedBookList.add(book);
    }
    update();
  }

}