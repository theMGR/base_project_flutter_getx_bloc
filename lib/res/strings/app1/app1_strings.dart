// ignore_for_file: non_constant_identifier_names

import 'package:project/core/flavor.dart';
import 'package:project/res/constants/constant_release.dart';

import '../base_strings.dart';

class App1Strings implements BaseStrings {
  @override
  String? get APP_NAME {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO) {
      return ReleaseConstant.APP1_DEMO_APP_NAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_DEV) {
      return ReleaseConstant.APP1_DEV_APP_NAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_UAT) {
      return ReleaseConstant.APP1_UAT_APP_NAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return ReleaseConstant.APP1_LIVE_APP_NAME;
    } else {
      return null;
    }
  }

  @override
  String? get BASE_URL {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO) {
      return ReleaseConstant.APP1_DEMO_BASE_URL;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_DEV) {
      return ReleaseConstant.APP1_DEV_BASE_URL;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_UAT) {
      return ReleaseConstant.APP1_UAT_BASE_URL;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return ReleaseConstant.APP1_LIVE_BASE_URL;
    } else {
      return null;
    }
  }

  @override
  String? get USERNAME {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO) {
      return ReleaseConstant.APP1_DEMO_USERNAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_DEV) {
      return ReleaseConstant.APP1_DEV_USERNAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_UAT) {
      return ReleaseConstant.APP1_UAT_USERNAME;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return ReleaseConstant.APP1_LIVE_USERNAME;
    } else {
      return null;
    }
  }

  @override
  String? get PASSWORD {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO) {
      return ReleaseConstant.APP1_DEMO_PASSWORD;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_DEV) {
      return ReleaseConstant.APP1_DEV_PASSWORD;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_UAT) {
      return ReleaseConstant.APP1_UAT_PASSWORD;
    } else if (Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return ReleaseConstant.APP1_LIVE_PASSWORD;
    } else {
      return null;
    }
  }
}
