// import 'package:flutter/material.dart';


// class CaloriesCalculator extends StatelessWidget {
//   // Calculate the basal metabolic rate (BMR)
//   double calculateBMR(
//       { required int gender,
//       required int height,
//       required int weight,
//       required int age}) {
//     // Men: BMR = 66 + (6.2 x weight in pounds) + (12.7 x height in inches) - (6.76 x age in years)
//     // Women: BMR = 655 + (4.35 x weight in pounds) + (4.7 x height in inches) - (4.7 x age in years)
//     if (gender == 1) {
//       return 66 + (6.2 * weight) + (12.7 * height) - (6.76 * age);
//     } else {
//       return 655 + (4.35 * weight) + (4.7 * height) - (4.7 * age);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Calories Calculator'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 decoration:
//                     InputDecoration(labelText: 'Gender (1 = male, 2 = female)'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Height (inches)'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Weight (pounds)'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Age (years)'),
//                 keyboardType: TextInputType.number,
//               ),
//               RaisedButton(
//                 child: Text('Calculate BMR'),
//                 onPressed: () {
//                   // Get the values from the text fields
//                   int gender = int.parse(genderController.text);
//                   int height = int.parse(heightController.text);
//                   int weight = int.parse(weightController.text);
//                   int age = int.parse(ageController.text);

//                   // Calculate the BMR
//                   double bmr = calculateBMR(
//                       gender: gender, height: height, weight: weight, age: age);

//                   // Display the result
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         content: Text('Your BMR is: $bmr calories'),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









// To convert height in inches to centimeters, you can use the following formula:

// 1 inch = 2.54 centimeters

// So to convert inches to centimeters, you can simply multiply the number of inches by 2.54. For example, to convert 72 inches to centimeters, you would do the following calculation:

// 72 inches * 2.54 centimeters/inch = 183.68 centimeters

// So 72 inches is equivalent to 183.68 centimeters.

// I hope this helps! Let me know if you have any other questions.