import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/dashboard_Controller.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class bottomnavBar extends StatelessWidget {
  const bottomnavBar({
    Key? key,
    required this.controller,
    required this.initialcon,
  }) : super(key: key);

  final DashboardController controller;
  final InitialStatusController initialcon;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FadeIn(
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset('assets/bottomnavSvg/Home.svg',
                    height: controller.rxIndex.value == 0 ? 40 : 30,
                    color: controller.rxIndex.value == 0
                        ? Col.darkgreen
                        : Col.black,
                    semanticsLabel: 'A red up arrow'),
              ),
              // ImageIcon(
              //   const AssetImage(
              //     'assets/img/Homebottom.png',
              //   ),
              //   color: controller.rxIndex.value == 0
              //       ? Col.green
              //       : Colors.grey[400],
              // ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset('assets/bottomnavSvg/Order History.svg',
                    height: controller.rxIndex.value == 1 ? 40 : 30,
                    color: controller.rxIndex.value == 1
                        ? Col.darkgreen
                        : Col.black,
                    semanticsLabel: 'A red up arrow'),
              ),
              label: 'Order History',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset('assets/bottomnavSvg/Notifications.svg',
                    height: controller.rxIndex.value == 2 ? 40 : 30,
                    color: controller.rxIndex.value == 2
                        ? Col.darkgreen
                        : Col.black,
                    semanticsLabel: 'A red up arrow'),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  cLearEvertyThing();

                  initialcon.logout();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: SvgPicture.asset('assets/bottomnavSvg/logout.svg',
                      height: controller.rxIndex.value == 3 ? 40 : 30,
                      color: controller.rxIndex.value == 3
                          ? Col.darkgreen
                          : Col.black,
                      semanticsLabel: 'A red up arrow'),
                ),
              ),
              label: 'Logout',
            ),
          ],

          currentIndex: controller.rxIndex.value,
          // fixedColor: primaryColor,
          selectedItemColor: Col.black,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10.h,
          unselectedFontSize: 10.h,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            color: Col.lightgrey,
            fontFamily: Assets.Product_Sans_Regular,
            fontSize: MediaQuery.of(context).size.height * 0.017,
          ),
          unselectedLabelStyle: TextStyle(
            color: Col.lightgrey,
            fontFamily: Assets.Product_Sans_Regular,
            fontSize: MediaQuery.of(context).size.height * 0.014,
          ),

          onTap: (index) {
            // print('dd$index');

            // index == 3 ? null : controller.bottomChange(index);
          },
        ),
      ),
    );
  }
}
