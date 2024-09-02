import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/member/library/screens/details/widgets/book_details_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../controllers/book_list_controller.dart';
import '../../controllers/fitered_books_controller.dart';
import '../../controllers/search_controller.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.bookIndex, this.booksController, this.searchController, this.filteredBooksController,required this.dark, required this.bookListEnum});

  final int bookIndex;
  final TBookListController? booksController;
  final TSearchController? searchController;
  final TFilteredBooksController? filteredBooksController;
  final bool dark;
  final BookList bookListEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white),),
        backgroundColor: TColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white,),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: _buildBody(bookListEnum, context),
    );
  }
  Widget _buildBody(BookList bookListEnum, BuildContext context) {
    switch (bookListEnum) {
      case BookList.allBookList:
        return _buildAllBookList();
      case BookList.filteredBookList:
        return _buildFilteredBookList();
      case BookList.searchedBookList:
        return _buildSearchedBookList();
      default:
        return Container(); // Handle default case if needed
    }
  }

  Widget _buildAllBookList() {
    return BookDetailsWidget(
      bookId:  booksController!.bookList[bookIndex].bookId,
      authorId:  booksController!.bookList[bookIndex].authorId,
      categoryId:  booksController!.bookList[bookIndex].categoryId,
      publisherId:  booksController!.bookList[bookIndex].publisherId,
      bookName: booksController!.bookList[bookIndex].bookName,
      description: booksController!.bookList[bookIndex].description,
      coverImage: booksController!.bookList[bookIndex].coverImage,
      libraryBookCode: booksController!.bookList[bookIndex].libraryBookCode,
      isbn: booksController!.bookList[bookIndex].isbn,
      createdDate: booksController!.bookList[bookIndex].createdDate,
      categoryName: booksController!.bookList[bookIndex].categoryName,
      authorName: booksController!.bookList[bookIndex].authorName,
      languageName: booksController!.bookList[bookIndex].languageName,
      publisherName: booksController!.bookList[bookIndex].publisherName,
      stockAvailable: booksController!.bookList[bookIndex].stockAvailable,
      dark: dark,
    );
  }
  Widget _buildFilteredBookList() {
    return BookDetailsWidget(
      bookId:  filteredBooksController!.filteredBookList[bookIndex].bookId,
      authorId:  filteredBooksController!.filteredBookList[bookIndex].authorId,
      categoryId:  filteredBooksController!.filteredBookList[bookIndex].categoryId,
      publisherId:  filteredBooksController!.filteredBookList[bookIndex].publisherId,
      bookName: filteredBooksController!.filteredBookList[bookIndex].bookName,
      description: filteredBooksController!.filteredBookList[bookIndex].description,
      coverImage: filteredBooksController!.filteredBookList[bookIndex].coverImage,
      libraryBookCode: filteredBooksController!.filteredBookList[bookIndex].libraryBookCode,
      isbn: filteredBooksController!.filteredBookList[bookIndex].isbn,
      createdDate: filteredBooksController!.filteredBookList[bookIndex].createdDate,
      categoryName: filteredBooksController!.filteredBookList[bookIndex].categoryName,
      authorName: filteredBooksController!.filteredBookList[bookIndex].authorName,
      languageName: filteredBooksController!.filteredBookList[bookIndex].languageName,
      publisherName: filteredBooksController!.filteredBookList[bookIndex].publisherName,
      stockAvailable: filteredBooksController!.filteredBookList[bookIndex].stockAvailable,
      dark: dark,
    );
  }
  Widget _buildSearchedBookList() {
    return BookDetailsWidget(
      bookId:  searchController!.searchedBookList[bookIndex].bookId,
      authorId:  searchController!.searchedBookList[bookIndex].authorId,
      categoryId:  searchController!.searchedBookList[bookIndex].categoryId,
      publisherId:  searchController!.searchedBookList[bookIndex].publisherId,
      bookName: searchController!.searchedBookList[bookIndex].bookName,
      description: searchController!.searchedBookList[bookIndex].description,
      coverImage: searchController!.searchedBookList[bookIndex].coverImage,
      libraryBookCode: searchController!.searchedBookList[bookIndex].libraryBookCode,
      isbn: searchController!.searchedBookList[bookIndex].isbn,
      createdDate: searchController!.searchedBookList[bookIndex].createdDate,
      categoryName: searchController!.searchedBookList[bookIndex].categoryName,
      authorName: searchController!.searchedBookList[bookIndex].authorName,
      languageName: searchController!.searchedBookList[bookIndex].languageName,
      publisherName: searchController!.searchedBookList[bookIndex].publisherName,
      stockAvailable: searchController!.searchedBookList[bookIndex].stockAvailable,
      dark: dark,
    );
  }
}

