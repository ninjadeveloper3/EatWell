import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/Notification/notificationscreen.dart';
import 'package:eat_well/views/Dashboard/Settings/settings.dart';
import 'package:eat_well/views/Dashboard/dashboard_Controller.dart';
import 'package:eat_well/views/Dashboard/dashboardScreen.dart';
import 'package:eat_well/views/Dashboard/orderHistory/orderHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// class HomeDashboard extends StatelessWidget {
//   HomeDashboard({Key? key}) : super(key: key);

//   DashboardController controller = Get.find<DashboardController>();
//   InitialStatusController initialcon = Get.find<InitialStatusController>();

//   Future<bool> onWillPop(context) async {
//     AwesomeDialog(
//       context: Get.context!,
//       dialogType: DialogType.warning,
//       borderSide: const BorderSide(
//         color: Col.green,
//         width: 2,
//       ),
//       width: 400.w,
//       buttonsBorderRadius: const BorderRadius.all(
//         Radius.circular(2),
//       ),
//       dismissOnTouchOutside: true,
//       dismissOnBackKeyPress: false,
//       headerAnimationLoop: false,
//       animType: AnimType.bottomSlide,
//       title: 'Exit',
//       desc: 'Are you Sure you want to Quit Application',
//       showCloseIcon: true,
//       // btnCancelText: 'CANCEL'.tr(),
//       btnOkText: 'Ok',
//       btnCancelText: 'CANCEL',
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {
//         SystemNavigator.pop();

//         // Get.back();
//         // Get.back();
//       },
//     ).show();

//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () => onWillPop(context),
//         child: SizedBox.expand(
//           child: PageView(
//             physics: const NeverScrollableScrollPhysics(),
//             controller: controller.pageController,
//             onPageChanged: (index) {
//               print(controller.pageController);
//               print('fjhf$index');
//               controller.bottomChange(index);
//             },
//             children: <Widget>[
//               DashBoard(),
//               const OrderHIstory(),
//               const NotificationScreen(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Obx(() {
//         return BottomNavigationBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: SvgPicture.asset('assets/bottomnavSvg/Home.svg',
//                     height: controller.rxIndex.value == 0 ? 40 : 30,
//                     color: controller.rxIndex.value == 0
//                         ? Col.darkgreen
//                         : Col.black,
//                     semanticsLabel: 'A red up arrow'),
//               ),
//               // ImageIcon(
//               //   const AssetImage(
//               //     'assets/img/Homebottom.png',
//               //   ),
//               //   color: controller.rxIndex.value == 0
//               //       ? Col.green
//               //       : Colors.grey[400],
//               // ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.white,
//               icon: Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: SvgPicture.asset('assets/bottomnavSvg/Order History.svg',
//                     height: controller.rxIndex.value == 1 ? 40 : 30,
//                     color: controller.rxIndex.value == 1
//                         ? Col.darkgreen
//                         : Col.black,
//                     semanticsLabel: 'A red up arrow'),
//               ),
//               label: 'Order History',
//             ),
//             BottomNavigationBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: SvgPicture.asset('assets/bottomnavSvg/Notifications.svg',
//                     height: controller.rxIndex.value == 2 ? 40 : 30,
//                     color: controller.rxIndex.value == 2
//                         ? Col.darkgreen
//                         : Col.black,
//                     semanticsLabel: 'A red up arrow'),
//               ),
//               label: 'Notifications',
//             ),
//             BottomNavigationBarItem(
//               icon: InkWell(
//                 onTap: () {
//                   cLearEvertyThing();
//                   initialcon.logout();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 2),
//                   child: SvgPicture.asset('assets/bottomnavSvg/logout.svg',
//                       height: controller.rxIndex.value == 3 ? 40 : 30,
//                       color: controller.rxIndex.value == 3
//                           ? Col.darkgreen
//                           : Col.black,
//                       semanticsLabel: 'A red up arrow'),
//                 ),
//               ),
//               label: 'Logout',
//             ),
//           ],

//           currentIndex: controller.rxIndex.value,
//           // fixedColor: primaryColor,
//           selectedItemColor: Col.black,
//           unselectedItemColor: Colors.grey,
//           selectedFontSize: 10.h,
//           unselectedFontSize: 10.h,
//           showUnselectedLabels: true,
//           selectedLabelStyle: TextStyle(
//             color: Col.lightgrey,
//             fontFamily: Assets.Product_Sans_Regular,
//             fontSize: MediaQuery.of(context).size.height * 0.017,
//           ),
//           unselectedLabelStyle: TextStyle(
//             color: Col.lightgrey,
//             fontFamily: Assets.Product_Sans_Regular,
//             fontSize: MediaQuery.of(context).size.height * 0.014,
//           ),

//           onTap: (index) {
//             print('dd$index');

//             index == 3 ? null : controller.bottomChange(index);
//           },
//         );
//       }),
//     );
//   }
// }

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  DashboardController controller = Get.find();

  Future<bool> onWillPop(context) async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PersistentTabView(
        context,
        controller: controller.controllerPersistent,
        screens: _buildScreens(),
        items: _navBarsItems(controller.rxIndex.value),
        navBarHeight: 70.0,
        padding: const NavBarPadding.all(9),

        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.simple, // Choose the nav bar style with this property.
      ),
    );
  }
}

//        PersistentTabView(
//         context,

//         controller: controller.controllerPersistent,
//         itemCount:
//             4, // This is required in case of custom style! Pass the number of items for the nav bar.
//         screens: _buildScreens(),
//         confineInSafeArea: controller.istrue.value,
//         onWillPop: onWillPop,
//         handleAndroidBackButtonPress: true,
//         hideNavigationBarWhenKeyboardShows: true,

//         popAllScreensOnTapOfSelectedTab: true,

//         // onItemSelected: (int) {
//         //   setState(
//         //       () {}); // This is required to update the nav bar if Android back button is pressed
//         // },
//         // customWidget: CustomNavBarWidget(

//         //   // Your custom widget goes here
//         //   items: _navBarsItems(controller.controllerPersistent.index),
//         //   selectedIndex: controller.controllerPersistent.index,
//         //   onItemSelected: (index) {
//         //     setState(() {
//         //       controller.controllerPersistent.index =
//         //           index; // NOTE: THIS IS CRITICAL!! Don't miss it!
//         //     });
//         //   },
//         // ),
//       ),
//     );
//   }
// }

List<Widget> _buildScreens() {
  return [
    DashBoard(),
    const OrderHIstory(),
    const NotificationScreen(),
    SettingScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems(int index) {
  return [
    PersistentBottomNavBarItem(
      contentPadding: 0,
      textStyle: TextStyle(
        fontFamily: Get.locale.toString() == 'en'
            ? Assets.Product_Sans_Regular
            : Assets.TheSans_plain,
        fontSize: 12,
      ),
      activeColorPrimary: Col.darkgreen,
      activeColorSecondary: Col.darkgreen,
      title: ("Home".tr()),
      inactiveColorPrimary: Col.black,
      icon: SvgPicture.asset(
        'assets/bottomnavSvg/Home.svg',
        color: index == 0 ? Col.darkgreen : Col.black,
      ),
    ),
    PersistentBottomNavBarItem(
      textStyle: TextStyle(
        fontFamily: Get.locale.toString() == 'en'
            ? Assets.Product_Sans_Regular
            : Assets.TheSans_plain,
        fontSize: 12,
      ),
      contentPadding: 0,
      activeColorPrimary: Col.darkgreen,
      icon: SvgPicture.asset(
        'assets/bottomnavSvg/Order History.svg',
        color: index == 1 ? Col.darkgreen : Col.black,
      ),
      title: ("Order History".tr()),
      inactiveColorPrimary: Col.black,
      activeColorSecondary: Col.darkgreen,
    ),
    PersistentBottomNavBarItem(
      textStyle: TextStyle(
        fontFamily: Get.locale.toString() == 'en'
            ? Assets.Product_Sans_Regular
            : Assets.TheSans_plain,
        fontSize: 12,
      ),
      contentPadding: 0,
      icon: SvgPicture.asset(
        'assets/bottomnavSvg/Notifications.svg',
        color: index == 2 ? Col.darkgreen : Col.black,
      ),
      title: ("Notifications".tr()),
      activeColorPrimary: Col.darkgreen,
      inactiveColorPrimary: Col.black,
      activeColorSecondary: Col.darkgreen,
    ),
    PersistentBottomNavBarItem(
      textStyle: TextStyle(
        fontFamily: Get.locale.toString() == 'en'
            ? Assets.Product_Sans_Regular
            : Assets.TheSans_plain,
        fontSize: 12,
      ),
      contentPadding: 0,
      icon: SvgPicture.asset(
        'assets/bottomnavSvg/Settings.svg',
        color: index == 3 ? Col.darkgreen : Col.black,
      ),
      title: ("Settings".tr()),
      activeColorPrimary: Col.darkgreen,
      activeColorSecondary: Col.darkgreen,
      inactiveColorPrimary: Col.black,
    ),
  ];
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 50.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0, color: isSelected ? Col.green : Col.black),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title.toString(),
                style: TextStyle(
                    color: isSelected ? Col.green : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  InitialStatusController initalcontroller = Get.find();

                  index == 3
                      ? initalcontroller.logout()
                      : onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
