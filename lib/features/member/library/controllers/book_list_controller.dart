import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/repository/book_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../models/books_model.dart';
import '../screens/home/home_screen.dart';
import 'checkout_list_controller.dart';

class TBookListController extends GetxController with GetTickerProviderStateMixin {
  static TBookListController get instance => Get.find();

  RxList<Books> bookList = <Books>[].obs;

  Rx<int> pageNo = 0.obs;
  RxBool hasReachedEnd = false.obs;
  RxBool isBookAvailable = false.obs;
  RxBool isInternetAvailable = true.obs;

  Rx<int> selectedIndex = 1.obs;

  final bookRepository = Get.put(BookRepository());
  final networkConnectivity = Get.put(NetworkConnectivity());
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchFeaturedBooks();
    scrollController.addListener(onScroll);
    super.onInit();
  }


  Future<void> fetchFeaturedBooks() async {
    final checkoutController = Get.put(TCheckoutBooksController());
    checkoutController.fetchCheckoutList();
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }

    pageNo.value++;
    final books = await bookRepository.getBooksForList(pageNo.value);
    if ((books.isNotEmpty)) {
      assignAllBooks(books);
      isBookAvailable.value = true;
    } else {
      isBookAvailable.value = false;
    }
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
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
      fetchFeaturedBooks();
      return const CircularProgressIndicator(color: TColors.primaryColor,);
    } else {
      return Container();
    }
  }



  // Store books
  void assignAllBooks(List<Map<String, dynamic>> booksData) {
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
      bookList.add(book);
    }
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

}