import 'package:get/get.dart';

class Books extends GetxController {
  late String bookId;
  late String authorId;
  late String categoryId;
  late String publisherId;
  late String bookName;
  late String description;
  late String coverImage;
  late String libraryBookCode;
  late String isbn;
  late String createdDate;
  late String categoryName;
  late String authorName;
  late String languageName;
  late String publisherName;
  late String stockAvailable;
  RxBool checkoutFlagAdd = true.obs;
  RxBool checkoutFlagRemove = false.obs;
}

