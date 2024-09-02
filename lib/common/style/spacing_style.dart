import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class TSpacingStyle {

  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: TSizes.appBarHeight,
      left: TSizes.spaceDefault,
      right: TSizes.spaceDefault,
      bottom: TSizes.spaceDefault
  );

  static const EdgeInsetsGeometry paddingWithSearchBarHeight = EdgeInsets.only(
      top: TSizes.searchBarHeight,
      left: TSizes.spaceDefault,
      right: TSizes.spaceDefault,
      bottom: TSizes.spaceDefault
  );

}