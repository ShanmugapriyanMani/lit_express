import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class DetailsRequestHeader extends StatelessWidget {
  const DetailsRequestHeader({super.key, required this.coverImage, required this.bookName, required this.processedMemberFirstname, required this.processedMemberLastname, required this.processedMemberStatus, required this.requestDate, required this.memberId, required this.bookStockId, required this.requestStatus});

  final String coverImage;
  final String bookName;
  final String memberId;
  final String bookStockId;
  final String requestStatus;
  final String requestDate;
  final String processedMemberFirstname;
  final String processedMemberLastname;
  final String processedMemberStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
              width: 100,
              height: 160,
              child: (coverImage == '')
                  ? Image.asset(
                TImages.booksPlaceholder,
                width: TSizes.booksListWidth,
                height: TSizes.booksListHeight,
                fit: BoxFit.fill,)
                  : Image.network('')

          ),
        ),
        const SizedBox(width: 10,),
        Flexible(
          child: Column(
            children: [
              const SizedBox(height: 15,),
              Text('Book Name:', style: Theme.of(context).textTheme.titleMedium,),
              Text(
                bookName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.primaryColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 20,),
              Text('Request Status: ', style: Theme.of(context).textTheme.titleMedium,),
              (requestStatus == 'Pending')
                  ? Text(
                    requestStatus,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TColors.warning),
                  )
                  : Text(
                      requestStatus,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TColors.primaryColor),
                  ),

            ],
          ),
        ),
      ],
    );
  }
}
