import 'package:flutter/material.dart';
import 'package:lit_express/features/member/library/screens/home/widgets/search_container.dart';
import 'package:lit_express/utils/constants/sizes.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/clip/circular_container.dart';
import '../../../../../../common/widgets/clip/curved_edge_widget.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
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
                    TAppBar(appIcon: TImages.appLogo, title: TText.appName1, avatar: ''),
                    SizedBox(height: TSizes.spaceBtwItems,),
                    TSearchContainer(text: 'Search books'),
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

