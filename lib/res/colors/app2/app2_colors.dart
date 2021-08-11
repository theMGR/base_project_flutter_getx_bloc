import 'package:flutter/material.dart';
import 'package:project/res/constants/constant_color.dart';
import 'package:project/core/flavor.dart';

import '../base_colors.dart';

// ignore_for_file: non_constant_identifier_names
class App2Colors implements BaseColors {
  @override
  Color? get PRIMARY_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return Colors.purple;
    }
  }

  @override
  Color? get ACCENT_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return Colors.purpleAccent;
    }
  }

  @override
  Color? get BUTTON_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return Colors.purple;
    }
  }

  @override
  Color? get BUTTON_TEXT_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return Colors.white;
    }
  }

  @override
  Color? get ICON_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP2_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP2_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP2_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP2_LIVE) {
      return Colors.blueGrey;
    }
  }
}
