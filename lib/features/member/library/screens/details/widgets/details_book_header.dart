import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class DetailsBookHeader extends StatelessWidget {
  const DetailsBookHeader({
    super.key,
    required this.coverImage,
    required this.bookName,
    required this.categoryName,
    required this.languageName,
    required this.authorName,
    required this.isbn,
  });

  final String coverImage;
  final String bookName;
  final String categoryName;
  final String languageName;
  final String authorName;
  final String isbn;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                Row(
                  children: [
                    Text('Book:           ', style: Theme.of(context).textTheme.titleMedium,),
                    Flexible(
                      child: Text(
                        bookName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.primaryColor),
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
                    Text('Category:   ', style: Theme.of(context).textTheme.titleMedium,),
                    Flexible(
                      child: Text(
                        categoryName,
                        style: Theme.of(context).textTheme.titleSmall,
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
                    Text('Language:  ', style: Theme.of(context).textTheme.titleMedium,),
                    Flexible(
                      child: Text(
                        languageName,
                        style: Theme.of(context).textTheme.titleSmall,
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
                    Text('Author:         ', style: Theme.of(context).textTheme.titleMedium,),
                    Flexible(
                      child: Text(
                        authorName,
                        style: Theme.of(context).textTheme.titleSmall,
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
                    Text('ISBN No:       ', style: Theme.of(context).textTheme.titleMedium,),
                    Flexible(
                      child: Text(
                        isbn,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            )
        ),
      ],
    );
  }
}