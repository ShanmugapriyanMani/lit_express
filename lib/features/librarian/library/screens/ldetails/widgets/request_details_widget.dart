import 'package:flutter/material.dart';
import 'package:lit_express/features/librarian/library/screens/ldetails/widgets/pending_request_slider.dart';
import 'package:lit_express/utils/constants/colors.dart';

import '../../../../../../common/widgets/slder_action/slider.dart';
import 'details_request_header.dart';

class RequestDetailsWidget extends StatelessWidget {
  const RequestDetailsWidget({
    super.key,
    required this.requestId,
    required this.requestStatus,
    required this.requestDate,
    required this.processedDate,
    required this.memberId,
    required this.libraryMemberCode,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.bookId,
    required this.bookName,
    required this.coverImage,
    required this.processedMemberId,
    required this.processedMemberFirstname,
    required this.processedMemberLastname,
    required this.processedMemberStatus,
    required this.bookStockId,
    required this.stockAvailable,
    required this.dark
  });

  final String requestId;
  final String requestStatus;
  final String requestDate;
  final String processedDate;
  final String memberId;
  final String libraryMemberCode;
  final String status;
  final String firstName;
  final String lastName;
  final String bookId;
  final String bookName;
  final String coverImage;
  final String processedMemberId;
  final String processedMemberFirstname;
  final String processedMemberLastname;
  final String processedMemberStatus;
  final String bookStockId;
  final String stockAvailable;
  final bool dark;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
      child: Column(
        children: [
          DetailsRequestHeader(coverImage: coverImage, bookName: bookName, processedMemberFirstname: processedMemberFirstname, processedMemberLastname: processedMemberLastname, processedMemberStatus: processedMemberStatus, requestDate: requestDate, memberId: memberId, bookStockId: bookStockId, requestStatus: requestStatus,),
          const SizedBox(height: 20,),
          const Divider(
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Member details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TColors.primaryColor),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Member Id:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          memberId,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('First Name:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          firstName,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Last Name:    ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          lastName,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Status:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          status,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Request Date:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          requestDate,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Library Member Code:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          libraryMemberCode,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.green,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Stock details:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TColors.textPrimaryColor),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Stock Id:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          bookStockId,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Stock Available:   ', style: Theme.of(context).textTheme.titleMedium,),
                      Flexible(
                        child: Text(
                          stockAvailable,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.green,
                  ),
                ],
              )
            ),
          ),
          PendingRequestSlider(
            requestId: requestId,
          )
        ],
      ),
    );
  }
}
