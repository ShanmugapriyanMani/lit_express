import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class TCategoriesController extends GetxController {
  static TCategoriesController get instance => Get.find();

  final networkConnectivity = Get.put(NetworkConnectivity());

  RxBool isInternetAvailable = true.obs;
  RxBool isBooksAvailable = false.obs;
  RxBool isLoading = false.obs;
  RxBool isFilterApply = false.obs;

  RxInt isSelectedCategoryIndex = RxInt(-1);
  RxInt isSelectedLanguageIndex = RxInt(-1);
  RxInt isSelectedAuthorIndex = RxInt(-1);

  Rx<int> filterIndex = 0.obs;

  RxList<RxMap> tempCategory = <RxMap>[].obs;
  RxList<RxMap> tempLanguage = <RxMap>[].obs;
  RxList<RxMap> tempAuthor = <RxMap>[].obs;

  RxString selectedCategory = ''.obs;
  RxString selectedLanguage = ''.obs;
  RxString selectedAuthor = ''.obs;

  RxString selectedCategoryId = ''.obs;
  RxString selectedLanguageId = ''.obs;
  RxString selectedAuthorId = ''.obs;


  @override
  void onInit() {
    filterIndex.value = 0;
    fetchFilterList(filterIndex.value);
    super.onInit();
  }

  Future<void> fetchFilterList(int filterIndex) async {
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(
          title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }

    isLoading.value = true;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    List<Map<String, dynamic>> booksList = await apiService.getRequestForFilterBooks(filterIndex);
    isBooksAvailable.value = (booksList.isNotEmpty) ? true : false;
    if (isBooksAvailable.value == true) {
      sortBooks(booksList);
    }
    isLoading.value = false;

  }

  // store books
  void sortBooks(List<Map<String, dynamic>> booksData) {

    for (var bookData in booksData) {
      switch (filterIndex.value) {
        case 0:
          RxMap<String, dynamic> categoryMapped = {"category_id": bookData["category_id"], "category_name": bookData['category_name']}.obs;
          tempCategory.add(categoryMapped);
          break;
        case 1:
          RxMap<String, dynamic> languageMapped = {"language_id": bookData["language_id"], "language_name": bookData['language_name']}.obs;
          tempLanguage.add(languageMapped);
          break;
        case 2:
          RxMap<String, dynamic> authorMapped = {"author_id": bookData["auther_id"], "author_name": bookData['auther_name']}.obs;
          tempAuthor.add(authorMapped);
          break;
      }
    }
    update();
  }

  int lengthOfCategories(index) {
    if (index == 0) {
      return tempCategory.length;
    } else if (index == 1) {
      return tempLanguage.length;
    } else {
      return tempAuthor.length;
    }
  }


  Future<void> changeFilter(index) async {
    filterIndex.value = index;
    bool isEmpty = false;
    switch (filterIndex.value) {
      case 0:
        if (tempCategory.isEmpty) {
          isEmpty = true;
        }
        break;
      case 1:
        if (tempLanguage.isEmpty) {
          isEmpty = true;
        }
        break;
      case 2:
        if (tempAuthor.isEmpty) {
          isEmpty = true;
        }
        break;
    }
    if (isEmpty) {
      await fetchFilterList(filterIndex.value);
    }
    update();
  }

  Widget listTitle(int actualIndex, int index, String displayText) {
    if(actualIndex == 0) {
      return (isSelectedCategoryIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
    } else if (actualIndex == 1) {
      return (isSelectedLanguageIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
    } else {
      return (isSelectedAuthorIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
    }
  }

  Widget listTitleIcon(int actualIndex, int index) {
    if(actualIndex == 0) {
      return (isSelectedCategoryIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
    } else if (actualIndex == 1) {
      return (isSelectedLanguageIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
    } else {
      return (isSelectedAuthorIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isSelectedCategoryIndex.value = -1.obs;
    isSelectedLanguageIndex.value = -1.obs;
    isSelectedAuthorIndex.value = -1.obs;
    selectedCategoryId.value = '';
    selectedLanguageId.value = '';
    selectedAuthorId.value = '';
    selectedCategory.value = '';
    selectedLanguage.value = '';
    selectedAuthor.value = '';

  }


}
