import 'package:flutter/material.dart';
import 'package:lit_express/common/widgets/layout/listview_builder_layout.dart';
import 'package:lit_express/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class TVerticalBooksShimmer extends StatelessWidget {
  const TVerticalBooksShimmer({
    super.key,
    required this.itemCount
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TListViewBuilderLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const ListTile(
        leading: TShimmerEffect(
          width: TSizes.booksListWidth,
          height: TSizes.booksListHeight,
        ),
        title: TShimmerEffect(
          width: 20,
          height: 20,
        ),
        subtitle: TShimmerEffect(
          width: 5,
          height: 12,
        ),
      ),

    );
  }
}
