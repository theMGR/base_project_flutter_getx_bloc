import 'package:project/core/flavor.dart';
import 'package:project/res/colors/app1/app1_colors.dart';
import 'package:project/res/colors/app2/app2_colors.dart';
import 'package:project/res/colors/base_colors.dart';

class AppColors {
  static BaseColors? get() {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return App1Colors();
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return App2Colors();
    }
  }
}
