import 'package:eat_well/model/CartItems.dart';

class MealCategorySelectionModel {
  int id;
  String name;
  int selectedIndex;
  int mealCatID;
  List<LineItems> lineitems;

  MealCategorySelectionModel({
    required this.id,
    required this.name,
    required this.selectedIndex,
    required this.mealCatID,
    required this.lineitems,
  });
}
