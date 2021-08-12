import 'package:flutter/material.dart';
import 'package:project/core/flavor.dart';
import 'package:project/presentation/res/constants/constant_color.dart';

import '../base_colors.dart';

// ignore_for_file: non_constant_identifier_names
class App1Colors implements BaseColors {
  @override
  Color? get PRIMARY_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return Colors.blue;
    }
  }

  @override
  Color? get ACCENT_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return Colors.blueAccent;
    }
  }

  @override
  Color? get BUTTON_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return Colors.blue;
    }
  }

  @override
  Color? get BUTTON_TEXT_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return Colors.white;
    }
  }

  @override
  Color? get ICON_COLOR {
    if (Flavor.FLAVOR == FlavorTypes.APP1_DEMO ||
        Flavor.FLAVOR == FlavorTypes.APP1_DEV ||
        Flavor.FLAVOR == FlavorTypes.APP1_UAT ||
        Flavor.FLAVOR == FlavorTypes.APP1_LIVE) {
      return Colors.blueGrey;
    }
  }
}
