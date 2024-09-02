import 'package:get/get.dart';
import '../../utils/constants/text_strings.dart';
import '../service/api_service.dart';

class BookRepository extends GetxController {
  static BookRepository get instance => Get.find();

  //Get books list
  Future<List<Map<String, dynamic>>> getBooksForList(int pageNo) async {
    try {
      final apiService = ApiService(baseUrl: TText.baseUrl);
      List<Map<String, dynamic>> booksList = await apiService.getRequestForBooks(pageNo);
      if (booksList.isNotEmpty) {
        return booksList;
      } else {
        throw Exception("No book list found!");
      }
    } catch(e) {
      return [];
    }
  }



}