// ignore_for_file: non_constant_identifier_names
import 'package:project/core/flavor.dart';
import 'package:project/res/constants/constant_release.dart';

import '../base_strings.dart';

class App2Strings implements BaseStrings {
  @override
  String? get APP_NAME {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO) {
      return ReleaseConstant.APP2_DEMO_APP_NAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_DEV) {
      return ReleaseConstant.APP2_DEV_APP_NAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_UAT) {
      return ReleaseConstant.APP2_UAT_APP_NAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return ReleaseConstant.APP2_LIVE_APP_NAME;
    } else {
      return null;
    }
  }

  @override
  String? get BASE_URL {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO) {
      return ReleaseConstant.APP2_DEMO_BASE_URL;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_DEV) {
      return ReleaseConstant.APP2_DEV_BASE_URL;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_UAT) {
      return ReleaseConstant.APP2_UAT_BASE_URL;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return ReleaseConstant.APP2_LIVE_BASE_URL;
    } else {
      return null;
    }
  }

  @override
  String? get USERNAME {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO) {
      return ReleaseConstant.APP2_DEMO_USERNAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_DEV) {
      return ReleaseConstant.APP2_DEV_USERNAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_UAT) {
      return ReleaseConstant.APP2_UAT_USERNAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return ReleaseConstant.APP2_LIVE_USERNAME;
    } else {
      return null;
    }
  }

  @override
  String? get PASSWORD {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO) {
      return ReleaseConstant.APP2_DEMO_PASSWORD;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_DEV) {
      return ReleaseConstant.APP2_DEV_PASSWORD;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_UAT) {
      return ReleaseConstant.APP2_UAT_PASSWORD;
    } else if (Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return ReleaseConstant.APP2_LIVE_PASSWORD;
    } else {
      return null;
    }
  }
}
