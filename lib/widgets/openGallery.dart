// import 'package:flutter/material.dart';
// import 'package:eat_well/api-handler/env_constants.dart';
// import 'package:eat_well/model/jobsModel.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class GalleryWidget extends StatefulWidget {
//   const GalleryWidget({Key? key}) : super(key: key);

//   @override
//   State<GalleryWidget> createState() => _GalleryWidgetState();
// }

// class _GalleryWidgetState extends State<GalleryWidget> {
//   RxList<Technicianalljob> selectedJob = Get.arguments[0];
//   var selectedIndex = Get.arguments[1];
//   var imageIndex = Get.arguments[2];
//   var image = Get.arguments[0][Get.arguments[1]].cardImages;

//   PageController pageController = PageController(initialPage: Get.arguments[2]);
//   String imagebaseUrl = EnvironmentConstants.Card_images;
//   late int index = Get.arguments[2];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           PhotoViewGallery.builder(
//               pageController: pageController,
//               itemCount: image.length,
//               onPageChanged: (ind) {
//                 setState(() {
//                   index = ind;
//                 });
//               },
//               builder: (context, index) {
//                 final urlImage = image[index].image;
//                 print('url is $urlImage');

//                 return PhotoViewGalleryPageOptions(
//                   imageProvider: NetworkImage(
//                     '$imagebaseUrl$urlImage',
//                   ),
//                   initialScale: PhotoViewComputedScale.contained * 0.8,
//                 );
//               }),
//           Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Container(
//               child: Text(
//                 'Image ${index + 1}/ ${image.length}',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
