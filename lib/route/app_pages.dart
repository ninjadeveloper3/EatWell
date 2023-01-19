// ignore_for_file: constant_identifier_names

import 'package:eat_well/views/Calories_Calculator/caloriesCalculator_binding.dart';
import 'package:eat_well/views/Calories_Calculator/caloriesResultPage.dart';
import 'package:eat_well/views/Calories_Calculator/caloriescalculator.dart';
import 'package:eat_well/views/Dashboard/dashboardScreen.dart';
import 'package:eat_well/views/Dashboard/dashboardView.dart';
import 'package:eat_well/views/Dashboard/dashboard_binding.dart';
import 'package:eat_well/views/Dashboard/goalSelection.dart';
import 'package:eat_well/views/Login&SignIn/resetPassword.dart/resetpassword.dart';
import 'package:eat_well/views/UserCartFlow/DietCAtegory/dietcategory_binding.dart';
import 'package:eat_well/views/UserCartFlow/Diet_Days_Plan/dietDaysPlan.dart';
import 'package:eat_well/views/UserCartFlow/Diet_Days_Plan/dietDays_binding.dart';

import 'package:eat_well/views/UserCartFlow/MealPlannning/mealplaning.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/mealdetails.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_binding.dart';
import 'package:eat_well/views/Login&SignIn/loginSignUp_binding.dart';
import 'package:eat_well/views/Onboarding/onboard.dart';

import 'package:eat_well/views/Splash/splash.dart';

import 'package:get/get.dart';

import '../views/UserCartFlow/DietCategory/dietcategory.dart';
import '../views/UserCartFlow/MealDuration/MealplanDuration.dart';
import '../views/UserCartFlow/MealDuration/mealplan_binding.dart';
import '../views/UserCartFlow/MealPlannning/mealplanning_binding.dart';
import '../views/Login&SignIn/login&SignUp.dart';
import '../views/Login&SignIn/verification/verification.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static const SPLASH = Routes.SPLASH;
  static const ONBOARD = Routes.ONBOARD;
  static const SIGNIN = Routes.SIGNIN;
  static const DASHBOARD = Routes.DASHBOARD;
  static const OngoingPlanDashboard = Routes.OngoingPlanDashboard;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => EatWellSplashScreen(),
      // binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => GettingStartedScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,
      // binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => LoginSignUp(),

      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,

      binding: LoginSignUpBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const HomeDashboard(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,

      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARDGuest,
      page: () => DashBoard(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,

      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DIETCATEGORY,
      page: () => const DietCategory(),
      binding: DietCategoryBinding(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DIETDAYPLAN,
      page: () => DietDayPlan(),
      binding: DietDaysBinding(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => Verification(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,

      // binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.MEALPLANNING,
      page: () => MealPlanning(),
      binding: MealPlanningBinding(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MEALPLANDURATION,
      page: () => const MealPlanDurationPage(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,
      binding: MealdurationBinding(),
    ),
    GetPage(
      name: _Paths.DAILYMEALSELECTION,
      page: () => SelectDailyMealScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      // transition: Transition.cupertino,

      binding: DailyMealSelectBinding(),
    ),
    GetPage(
      name: _Paths.DAILYMEALDETAILS,
      page: () => MealDetails(),
      // transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),

      // binding: ChatBinding(),
    ),
    // GetPage(
    //   name: _Paths.OngoingPlanDashboard,
    //   page: () =>  OngoingPlanDashboardSreen(),
    //   // transition: Transition.cupertino,
    //   transitionDuration: const Duration(milliseconds: 400),

    //   // binding: ChatBinding(),
    // ),
    GetPage(
      name: _Paths.GoalSelectionScreen,
      page: () => const GoalSelectionScreen(),
      // transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),

      // binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.CaloriesCalculator,
      page: () => const CaloriesCalculator(),
      // transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),

      binding: CaloriesCalculatorBinding(),
    ),
    GetPage(
      name: _Paths.ResetPassword,
      page: () => const ResetPasswordScreen(),
      // transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),

      // binding: CaloriesCalculatorBinding(),
    ),
    GetPage(
      name: _Paths.CalloriesResult,
      page: () => const CalloriesResultPage(),
      // transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),

      // binding: CaloriesCalculatorBinding(),
    ),
  ];
}
