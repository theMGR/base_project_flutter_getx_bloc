import 'package:project/core/flavor.dart';
import 'package:project/res/strings/app1/app1_strings.dart';
import 'package:project/res/strings/app2/app2_strings.dart';

import '../base_strings.dart';

class AppStrings {
  static BaseStrings? get() {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return App1Strings();
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return App2Strings();
    }
  }
}
