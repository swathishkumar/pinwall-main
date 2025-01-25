// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../models/image_model.dart';
// import '../controller/image_controller.dart';

// class ImageDetailPage extends StatelessWidget {
//   final ImageModel image;

//   const ImageDetailPage({Key? key, required this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ImageController imageController = Get.find<ImageController>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // Full-screen image
//           Positioned.fill(
//             child: Image.network(
//               image.imageUrl,
//               fit: BoxFit.none,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   color: Colors.grey[300],
//                   child: const Center(
//                     child: Icon(Icons.error, color: Colors.red, size: 50),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Content overlay
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, -4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   Text(
//                     image.title,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Description placeholder
//                   const Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
//                     style: TextStyle(fontSize: 16, color: Colors.black54),
//                   ),
//                   const SizedBox(height: 16),

//                   // Action buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton.icon(
//   onPressed: () async {
//     final PermissionStatus status = await Permission.storage.request();

//     if (status.isGranted) {
//       // Call the download function
//       await imageController.downloadImage(
//         image.imageUrl,
//         '${image.title}.jpg', // Save with the image title as the file name
//       );
//     } else if (status.isDenied) {
//       Get.snackbar(
//         'Permission Denied',
//         'Storage permission is required to save the image.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } else if (status.isPermanentlyDenied) {
//       Get.snackbar(
//         'Permission Denied',
//         'Please enable storage permission in app settings to save images.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       await openAppSettings(); // Open app settings to let the user enable permission
//     }
//   },
//   icon: const Icon(Icons.bookmark_border),
//   label: const Text('Save'),
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.redAccent,
//     foregroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   ),
// ),

//                       IconButton(
//                         onPressed: () {
//                           // Add share functionality here
//                         },
//                         icon: const Icon(Icons.share),
//                         color: Colors.grey[600],
//                         iconSize: 28,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Back button
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 8,
//             left: 16,
//             child: CircleAvatar(
//               backgroundColor: Colors.black45,
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/image_model.dart';
import '../controller/image_controller.dart';

class ImageDetailPage extends StatelessWidget {
  final ImageModel image;

  const ImageDetailPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find<ImageController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Full-screen image
            Container(
              child: Image.network(
                image.imageUrl,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    ),
                  );
                },
              ),
            ),
            // Content overlay with details
            Container(height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    image.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final PermissionStatus status = await Permission.storage.request();

                          if (status.isGranted) {
                            // Call the download function
                            await imageController.downloadImage(
                              image.imageUrl,
                              '${image.title}.jpg', // Save with the image title as the file name
                            );
                          } else if (status.isDenied) {
                            Get.snackbar(
                              'Permission Denied',
                              'Storage permission is required to save the image.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else if (status.isPermanentlyDenied) {
                            Get.snackbar(
                              'Permission Denied',
                              'Please enable storage permission in app settings to save images.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            await openAppSettings(); // Open app settings to let the user enable permission
                          }
                        },
                        icon: const Icon(Icons.bookmark_border),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Add share functionality here
                        },
                        icon: const Icon(Icons.share),
                        color: Colors.grey[600],
                        iconSize: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),   
                  const SizedBox(height: 8),
                  // Additional suggestion section
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}