import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/res/colors/app_colors/app_colors.dart';
import 'package:project/res/strings/app_strings/app_strings.dart';
import 'package:project/ui/config/route_config.dart';

import 'splash_controller.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Get.find<SplashController>();
  final SplashState state = Get.find<SplashController>().state;

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                AppStrings.get()?.APP_NAME ?? "",
                textStyle: TextStyle(fontSize: 50.0,
                    fontFamily: 'Ubuntu'),
                colors: [
                  AppColors.get()?.PRIMARY_COLOR ?? Colors.green,
                  AppColors.get()?.ACCENT_COLOR ?? Colors.green,
                  Colors.yellow,
                  Colors.red,
                ],
              )
            ],
            totalRepeatCount: 1,
            isRepeatingAnimation: true,

            onFinished: () {
             Get.offAllNamed(RouteConfig.login);
            },
          ),
        ),

      );
    }

  @override
  void dispose() {
    Get.delete<SplashController>();
    super.dispose();
  }
}