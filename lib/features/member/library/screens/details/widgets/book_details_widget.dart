import 'package:flutter/material.dart';
import 'package:lit_express/common/widgets/slder_action/slider.dart';
import 'details_book_header.dart';

class BookDetailsWidget extends StatelessWidget {
  const BookDetailsWidget({
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
    required this.stockAvailable,
    required this.dark,
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
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          DetailsBookHeader(coverImage: coverImage, bookName: bookName, categoryName: categoryName, languageName: languageName, authorName: authorName, isbn: isbn),
          const Divider(
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SliderWidget(
              bookId: bookId,
              authorId: authorId,
              categoryId: categoryId,
              publisherId: publisherId,
              bookName: bookName,
              description: description,
              coverImage: coverImage,
              libraryBookCode: libraryBookCode,
              isbn: isbn,
              createdDate: createdDate,
              categoryName: categoryName,
              authorName: authorName,
              languageName: languageName,
              publisherName: publisherName,
              stockAvailable: stockAvailable,
          )
        ],
      ),
    );
  }
}
