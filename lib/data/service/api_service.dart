import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lit_express/common/widgets/snack_bar.dart';
import 'package:lit_express/features/authentication/models/user_model.dart';
import 'package:lit_express/utils/constants/image_strings.dart';
import 'package:lit_express/utils/constants/text_strings.dart';

import '../../common/widgets/loader/animation_loader.dart';


class ApiService {

  ApiService({required this.baseUrl});
  final String baseUrl;


  // Authentication
  Future<Map<String, dynamic>> authenticate(String username, String password) async {

    final String apiUrl = "$baseUrl/users/auth";
    late final http.Response response;

    final Map<String, String> requestBody = {
      "username": username,
      "password": password,
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('user_id')) {
          return responseData;
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to authenticate');
      }
    } catch (error) {
      if (kDebugMode) {
        print('HTTP errors or other exceptions: $error');
      }
      if (kReleaseMode) {
        print('HTTP errors or other exceptions: $error');
      }
      TSnackBar.errorSnackBar(title: 'Failed to login', message: '$error Status code: ${response.statusCode}');
      // TSnackBar.errorSnackBar(title: 'Failed to login', message: TText.errorMessage);
      rethrow;
    }
  }


  Future<List<Map<String, dynamic>>> getRequestForBooks(int pageNo)  async {
    final String apiUrl = "$baseUrl/books/search";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "hide_rented": false,
      "per_page": 10,
      "page_num": pageNo,
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      }
      else {
        throw Exception('Invalid response data');
      }
    }
    catch (error) {
      TSnackBar.warningSnackBar(title: 'Failed to load books', message: 'It may be server issue or check your internet connectivity.');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getRequestForSearchBooks(String query)  async {
    final String apiUrl = "$baseUrl/books/search";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "query": query,
      "hide_rented": false,
      "per_page": 10,
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      }
      else {
        throw Exception('Invalid response data');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
      }
      else {

      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getRequestForFilterBooks(int filterIndex)  async {
    String additional = '';
    switch (filterIndex) {
      case 0:
        additional = '/category';
        break;
      case 1:
        additional = '/languages';
        break;
      case 2:
        additional = '/authers';
        break;
    }
    final String apiUrl = "$baseUrl$additional";
    late final http.Response response;


    try {
      response = await http.get(
        Uri.parse(apiUrl),
        headers: {"Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      }
      else {
        throw Exception('Invalid response data');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
      }
      else {

      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> requestForFilteredBooks(String selectedCategoryId, String selectedLanguageId, String selectedAuthorId, int pageNo)  async {

    final String apiUrl = "$baseUrl/books/search";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "hide_rented": false,
      "per_page": 10,
      "page_num": pageNo,
      "category_id": selectedCategoryId,
      "language_id": selectedLanguageId,
      "auther_id": selectedAuthorId,
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      }
      else {
        throw Exception('Invalid response data');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
      }
      else {

      }
      rethrow;
    }
  }

  Future<bool> requestForBooks(List<String> books)  async {

    final String apiUrl = "$baseUrl/request/create";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "books": books.map((bookId) => {"book_id": bookId}).toList(),
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        Navigator.of(Get.overlayContext!).pop();
        TSnackBar.successSnackBar(title: "Requested successfully!", message: "Wait for book request approval from librarian");
        return true;
      } else {
        throw Exception('Already send a request');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
        Navigator.of(Get.overlayContext!).pop();
        TSnackBar.warningSnackBar(title: "Already Request was initiated!",  message: "Wait for book request approval from librarian");
        return false;
      }
      else {
        Navigator.of(Get.overlayContext!).pop();
        TSnackBar.warningSnackBar(title: "Server issue!", message: "Try after sometimes");
        return false;
      }
    }
  }

  Future<List<Map<String, dynamic>>> getPendingRequest(int pageNo) async {
    final String apiUrl = "$baseUrl/request/search";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "per_page": 10,
      "page_num": pageNo
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {
          "Authorization": "Bearer ${UserModelController.instance.token}",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;

        // Remove the 'Member[' prefix and the trailing ']'
        if (responseBody.startsWith('[') && responseBody.endsWith(']')) {
          responseBody = responseBody.substring(1, responseBody.length - 1);
        }

        // Add surrounding brackets to make it a valid JSON array
        responseBody = '[$responseBody]';

        List<dynamic> responseData = json.decode(responseBody);
        if (responseData.isNotEmpty) {
          return responseData.map((item) => Map<String, dynamic>.from(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Invalid response data');
      }
    } catch (error) {
      TSnackBar.warningSnackBar(
          title: 'Failed to load books',
          message: 'It may be a server issue or check your internet connectivity.'
      );
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getRequestForSearchPendingBooks(String query)  async {
    final String apiUrl = "$baseUrl/request/search";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "query": query,
      "hide_rented": false,
      "per_page": 10,
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {
          "Authorization": "Bearer ${UserModelController.instance.token}",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        // final List<dynamic> responseData = json.decode(response.body);
        String responseBody = response.body;

        // Remove the 'Member[' prefix and the trailing ']'
        if (responseBody.startsWith('') && responseBody.endsWith(']')) {
          responseBody = responseBody.substring(1, responseBody.length - 1);
        }
        // Add surrounding brackets to make it a valid JSON array
        responseBody = '[$responseBody]';

        List<dynamic> responseData = json.decode(responseBody);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      }
      else {
        throw Exception('Invalid response data');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
      }
      else {

      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> requestForFilterRequest(String sortBy, String sortOrder, int pageNo)  async {

    final String apiUrl = "$baseUrl/request/search";
    late final http.Response response;

    switch (sortBy) {
      case "Date":
        sortBy = 'request_date';
        break;
      case "Member":
        sortBy = 'member_id';
        break;
      default:
        sortBy = '';
        break;
    }

    switch (sortOrder) {
      case "Ascending":
        sortOrder = 'ASC';
        break;
      case "Descending":
        sortOrder = 'DESC';
        break;
      default:
        sortOrder = '';
        break;
    }

    final Map<String, dynamic> requestBody = {
      "sort_by": sortBy,
      "sort_order": sortOrder,
      "hide_rented": false,
      "per_page": 10,
      "page_num": pageNo
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {
          "Authorization": "Bearer ${UserModelController.instance.token}",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;

        if (responseBody.startsWith('[') && responseBody.endsWith(']')) {
          responseBody = responseBody.substring(1, responseBody.length - 1);
        }
        responseBody = '[$responseBody]';
        final List<dynamic> responseData = json.decode(responseBody);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      }
      else {
        throw Exception('Invalid response data');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
      }
      else {

      }
      rethrow;
    }
  }

  Future<bool> requestForPendingApproval(String requestId)  async {

    final String apiUrl = "$baseUrl/request/process";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "process": "Completed",
      "request_id": requestId
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        // TSnackBar.successSnackBar(title: "Approved successfully!", message: "Request Processed successfully");
        return true;
      } else {
        throw Exception('Already send a request');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
        // TSnackBar.warningSnackBar(title: "Bad Request was initiated!",  message: "Failed to Processed the Request");
        return false;
      }
      else {
        // TSnackBar.warningSnackBar(title: "Server issue!", message: "Try after sometimes");
        return false;
      }
    }
  }

  Future<List<Map<String, dynamic>>> requestForApprovedList(int pageNo)  async {

    final String apiUrl = "$baseUrl/request/search";
    late final http.Response response;

    final Map<String, dynamic> requestBody = {
      "per_page": 10,
      "page_num": pageNo,
      "show_processed": true
    };

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${UserModelController.instance.token}"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = response.body;

        if (responseBody.startsWith('[') && responseBody.endsWith(']')) {
          responseBody = responseBody.substring(1, responseBody.length - 1);
        }
        responseBody = '[$responseBody]';
        final List<dynamic> responseData = json.decode(responseBody);
        if (responseData.isNotEmpty) {
          List<Map<String, dynamic>> convertedList = responseData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return convertedList;
        }
        else {
          return [];
        }
      } else {
        throw Exception('Already send a request');
      }
    }
    catch (error) {
      if ((response.statusCode >= 400) || (response.statusCode <= 451)) {
        // Navigator.of(Get.overlayContext!).pop();
        // TSnackBar.warningSnackBar(title: "Already Request was initiated!",  message: "Wait for book request approval from librarian");
        return [];
      }
      else {
        // Navigator.of(Get.overlayContext!).pop();
        // TSnackBar.warningSnackBar(title: "Server issue!", message: "Try after sometimes");
        return [];
      }
    }
  }
}