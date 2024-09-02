import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/librarian/library/controllers/lfiltered_pending_controller.dart';
import 'package:lit_express/features/librarian/library/screens/ldetails/widgets/request_details_widget.dart';
import 'package:lit_express/features/member/library/screens/details/widgets/book_details_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../controllers/lsearch_controller.dart';
import '../../controllers/pendig_request_controller.dart';

class LDetailsScreen extends StatelessWidget {
  const LDetailsScreen({
    super.key,
    required this.bookIndex,
    this.pendingRequestController,
    this.lSearchController,
    this.lFilteredPendingController,
    required this.dark,
    required this.requestListEnum,
  });

  final int bookIndex;
  final LPendingRequestController? pendingRequestController;
  final LSearchController? lSearchController;
  final LFilteredPendingController? lFilteredPendingController;
  final bool dark;
  final PendingRequestList requestListEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white),),
        backgroundColor: TColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: _buildBody(requestListEnum, context),
    );
  }
  Widget _buildBody(PendingRequestList bookListEnum, BuildContext context) {
    switch (bookListEnum) {
      case PendingRequestList.allRequestList:
        return _buildAllRequestList();
      case PendingRequestList.filteredRequestList:
        return _buildFilteredRequestList();
      case PendingRequestList.searchedRequestList:
        return _buildSearchedRequestList();
      default:
        return Container(); // Handle default case if needed
    }
  }

  Widget _buildAllRequestList() {
    return RequestDetailsWidget(
      requestId:  pendingRequestController!.pendingRequestList[bookIndex].requestId,
      requestStatus:  pendingRequestController!.pendingRequestList[bookIndex].requestStatus,
      requestDate:  pendingRequestController!.pendingRequestList[bookIndex].requestDate,
      processedDate:  pendingRequestController!.pendingRequestList[bookIndex].processedDate,
      memberId: pendingRequestController!.pendingRequestList[bookIndex].memberId,
      libraryMemberCode: pendingRequestController!.pendingRequestList[bookIndex].libraryMemberCode,
      status: pendingRequestController!.pendingRequestList[bookIndex].status,
      firstName: pendingRequestController!.pendingRequestList[bookIndex].firstName,
      lastName: pendingRequestController!.pendingRequestList[bookIndex].lastName,
      bookId: pendingRequestController!.pendingRequestList[bookIndex].bookId,
      bookName: pendingRequestController!.pendingRequestList[bookIndex].bookName,
      coverImage: pendingRequestController!.pendingRequestList[bookIndex].coverImage,
      processedMemberId: pendingRequestController!.pendingRequestList[bookIndex].processedMemberId,
      processedMemberFirstname: pendingRequestController!.pendingRequestList[bookIndex].processedMemberFirstname,
      processedMemberLastname: pendingRequestController!.pendingRequestList[bookIndex].processedMemberLastname,
      processedMemberStatus: pendingRequestController!.pendingRequestList[bookIndex].processedMemberStatus,
      bookStockId: pendingRequestController!.pendingRequestList[bookIndex].bookStockId,
      stockAvailable: pendingRequestController!.pendingRequestList[bookIndex].stockAvailable,
      dark: dark,
    );
  }
  Widget _buildFilteredRequestList() {
    return RequestDetailsWidget(
      requestId:  lFilteredPendingController!.filteredPendingList[bookIndex].requestId,
      requestStatus:  lFilteredPendingController!.filteredPendingList[bookIndex].requestStatus,
      requestDate:  lFilteredPendingController!.filteredPendingList[bookIndex].requestDate,
      processedDate:  lFilteredPendingController!.filteredPendingList[bookIndex].processedDate,
      memberId: lFilteredPendingController!.filteredPendingList[bookIndex].memberId,
      libraryMemberCode: lFilteredPendingController!.filteredPendingList[bookIndex].libraryMemberCode,
      status: lFilteredPendingController!.filteredPendingList[bookIndex].status,
      firstName: lFilteredPendingController!.filteredPendingList[bookIndex].firstName,
      lastName: lFilteredPendingController!.filteredPendingList[bookIndex].lastName,
      bookId: lFilteredPendingController!.filteredPendingList[bookIndex].bookId,
      bookName: lFilteredPendingController!.filteredPendingList[bookIndex].bookName,
      coverImage: lFilteredPendingController!.filteredPendingList[bookIndex].coverImage,
      processedMemberId: lFilteredPendingController!.filteredPendingList[bookIndex].processedMemberId,
      processedMemberFirstname: lFilteredPendingController!.filteredPendingList[bookIndex].processedMemberFirstname,
      processedMemberLastname: lFilteredPendingController!.filteredPendingList[bookIndex].processedMemberLastname,
      processedMemberStatus: lFilteredPendingController!.filteredPendingList[bookIndex].processedMemberStatus,
      bookStockId: lFilteredPendingController!.filteredPendingList[bookIndex].bookStockId,
      stockAvailable: lFilteredPendingController!.filteredPendingList[bookIndex].stockAvailable,
      dark: dark,
    );
  }
  Widget _buildSearchedRequestList() {
    return RequestDetailsWidget(
      requestId:  lSearchController!.searchedRequestList[bookIndex].requestId,
      requestStatus:  lSearchController!.searchedRequestList[bookIndex].requestStatus,
      requestDate:  lSearchController!.searchedRequestList[bookIndex].requestDate,
      processedDate:  lSearchController!.searchedRequestList[bookIndex].processedDate,
      memberId: lSearchController!.searchedRequestList[bookIndex].memberId,
      libraryMemberCode: lSearchController!.searchedRequestList[bookIndex].libraryMemberCode,
      status: lSearchController!.searchedRequestList[bookIndex].status,
      firstName: lSearchController!.searchedRequestList[bookIndex].firstName,
      lastName: lSearchController!.searchedRequestList[bookIndex].lastName,
      bookId: lSearchController!.searchedRequestList[bookIndex].bookId,
      bookName: lSearchController!.searchedRequestList[bookIndex].bookName,
      coverImage: lSearchController!.searchedRequestList[bookIndex].coverImage,
      processedMemberId: lSearchController!.searchedRequestList[bookIndex].processedMemberId,
      processedMemberFirstname: lSearchController!.searchedRequestList[bookIndex].processedMemberFirstname,
      processedMemberLastname: lSearchController!.searchedRequestList[bookIndex].processedMemberLastname,
      processedMemberStatus: lSearchController!.searchedRequestList[bookIndex].processedMemberStatus,
      bookStockId: lSearchController!.searchedRequestList[bookIndex].bookStockId,
      stockAvailable: lSearchController!.searchedRequestList[bookIndex].stockAvailable,
      dark: dark,
    );
  }
}

