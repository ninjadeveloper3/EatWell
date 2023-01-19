import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/theme/color_codes.dart';
import 'package:animate_do/animate_do.dart';

class EatWellSplashScreen extends StatefulWidget {
  @override
  _EatWellSplashScreenState createState() => _EatWellSplashScreenState();
}

class _EatWellSplashScreenState extends State<EatWellSplashScreen> {
  InitialStatusController controller = InitialStatusController(Get.find());

  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 2),
    //     () => {Get.toNamed('/GettingStartedScreen')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.Sign_Bg_image_verticle),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * .22,
              left: 0,
              child: FadeInUp(
                child: Image(
                    image: const AssetImage(
                      Assets.backgoundpngSplash,
                    ),
                    height: MediaQuery.of(context).size.height * .62),
              ),
            ),
            Center(
              child: ZoomIn(
                delay: const Duration(milliseconds: 500),
                child: Image(
                    image: const AssetImage(
                      Assets.logoPng,
                    ),
                    height: MediaQuery.of(context).size.width * .62),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
