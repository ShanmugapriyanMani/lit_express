import 'package:flutter/foundation.dart';

class PendingRequest {
  String requestId = '';
  String requestStatus = '';
  String requestDate = '';
  String processedDate = '';
  String memberId = '';
  String libraryMemberCode = '';
  String status = '';
  String firstName = '';
  String lastName = '';
  String bookId = '';
  String bookName = '';
  String coverImage = '';
  String processedMemberId = '';
  String processedMemberFirstname = '';
  String processedMemberLastname = '';
  String processedMemberStatus = '';
  String bookStockId = '';
  String stockAvailable = '';

  // Constructor to initialize from JSON
  PendingRequest.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("JSON Data: $json");
    }
    requestId = json['request_id'] ?? '';
    requestStatus = json['request_status'] ?? '';
    requestDate = json['request_date'] ?? '';
    processedDate = json['processed_date'] ?? '';
    memberId = json['member_id'] ?? '';
    libraryMemberCode = json['library_member_code'] ?? '';
    status = json['status'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    bookId = json['book_id'] ?? '';
    bookName = json['book_name'] ?? '';
    coverImage = json['cover_image'] ?? '';
    processedMemberId = json['processed_member_id'] ?? '';
    processedMemberFirstname = json['processed_member_firstname'] ?? '';
    processedMemberLastname = json['processed_member_lastname'] ?? '';
    processedMemberStatus = json['processed_member_status'] ?? '';
    bookStockId = json['book_stock_id'] ?? '';
    stockAvailable = json['stock_available'] ?? '';
  }

}