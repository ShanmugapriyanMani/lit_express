import 'package:flutter/material.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/clip/circular_container.dart';
import '../../../../../../common/widgets/clip/curved_edge_widget.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../member/library/screens/home/widgets/search_container.dart';
import 'lappbar.dart';
import 'lsearch_container.dart';

class LPrimaryHeaderContainer extends StatelessWidget {
  const LPrimaryHeaderContainer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primaryColor,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              Positioned(top: -50, right: -60, child: TCircularContainer(backgroundColor: TColors.white.withOpacity(0.1),)),
              Positioned(top: 50, right: -80, child: TCircularContainer(backgroundColor: TColors.white.withOpacity(0.1),)),
              const Positioned(top: 10, left: 0, right: 0,
                child: Column(
                  children: [
                    LAppBar(appIcon: TImages.appLogo, title: TText.appName1, avatar: ''),
                    SizedBox(height: TSizes.spaceBtwItems,),
                    LSearchContainer(text: 'Search'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}