// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:shimmer/shimmer.dart';
// import '../controller/image_controller.dart';
// import 'image_detail_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ImageController imageController = Get.put(ImageController());
//     final ScrollController scrollController = ScrollController();

//     // Listen for scroll events
//     scrollController.addListener(() {
//       if (scrollController.position.pixels >=
//               scrollController.position.maxScrollExtent - 200 &&
//           !imageController.isLoadingMore.value) {
//         imageController.loadMoreImages();
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pinterest'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       backgroundColor: Colors.grey[200],
//       body: Obx(() {
//         if (imageController.isLoading.value && imageController.images.isEmpty) {
//           return const ShimmerGrid();
//         }

//         return Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: MasonryGridView.builder(
//                 controller: scrollController,
//                 gridDelegate:
//                     const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // Adjust for responsiveness
//                 ),
//                 mainAxisSpacing: 12,
//                 crossAxisSpacing: 12,
//                 itemCount: imageController.images.length,
//                 itemBuilder: (context, index) {
//                   final image = imageController.images[index];
//                   return GestureDetector(
//                     onTap: () => Get.to(() => ImageDetailPage(image: image)),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Stack(
//                         children: [
//                           AspectRatio(
//                             aspectRatio: 2 / 3, // Mimic Pinterest proportions
//                             child: Image.network(
//                               image.imageUrl,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   color: Colors.grey[300],
//                                   child: const Center(
//                                     child: Icon(Icons.error, color: Colors.red),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 8,
//                             left: 8,
//                             right: 8,
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.6),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 image.title,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             if (imageController.isLoadingMore.value)
//               Positioned(
//                 bottom: 16,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//           ],
//         );
//       }),
//     );
//   }
// }

// class ShimmerGrid extends StatelessWidget {
//   const ShimmerGrid({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: MasonryGridView.builder(
//         gridDelegate:
//             const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         itemCount: 8, // Number of shimmer placeholders
//         itemBuilder: (context, index) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16.0),
//               child: Container(
//                 height: (index % 3 + 1) * 100.0, // Staggered height simulation
//                 color: Colors.grey[300],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:shimmer/shimmer.dart';
// import '../controller/image_controller.dart';
// import 'image_detail_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ImageController imageController = Get.put(ImageController());
//     final ScrollController scrollController = ScrollController();

//     // Detect when the user scrolls near the bottom of the grid
//     scrollController.addListener(() {
//       if (scrollController.position.pixels >=
//               scrollController.position.maxScrollExtent - 200 &&
//           !imageController.isLoadingMore.value) {
//         imageController.loadMoreImages();
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pinterest'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       backgroundColor: Colors.grey[200],
//       body: Obx(() {
//         if (imageController.isLoading.value) {
//           return const ShimmerGrid(); // Show shimmer effect while loading
//         }

//         return Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: MasonryGridView.builder(
//                 controller: scrollController,
//                 gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 mainAxisSpacing: 12,
//                 crossAxisSpacing: 12,
//                 itemCount: imageController.images.length,
//                 itemBuilder: (context, index) {
//                   final image = imageController.images[index];
//                   return GestureDetector(
//                     onTap: () => Get.to(() => ImageDetailPage(image: image)),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         image.imageUrl,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             color: Colors.grey[300],
//                             child: const Center(
//                               child: Icon(Icons.error, color: Colors.red),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Show a loading indicator when more images are being fetched
//             if (imageController.isLoadingMore.value)
//               Positioned(
//                 bottom: 16,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.redAccent,
//                   ),
//                 ),
//               ),
//           ],
//         );
//       }),
//     );
//   }
// }

// class ShimmerGrid extends StatelessWidget {
//   const ShimmerGrid({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: MasonryGridView.builder(
//         gridDelegate:
//             const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         itemCount: 8, // Number of shimmer items
//         itemBuilder: (context, index) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16.0),
//               child: Container(
//                 color: Colors.grey[300],
//                 height: 200 + (index % 3) * 50, // Simulate staggered heights
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/image_controller.dart';
import 'image_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());
    final ScrollController scrollController = ScrollController();

    // Detect when the user scrolls near the bottom of the grid
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !imageController.isLoadingMore.value) {
        imageController.loadMoreImages();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('PinWall HD'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (imageController.isLoading.value) {
          return const ShimmerGrid(); // Show shimmer effect while loading
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MasonryGridView.builder(
                controller: scrollController,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: imageController.images.length,
                itemBuilder: (context, index) {
                  final image = imageController.images[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => ImageDetailPage(image: image)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image with rounded corners
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            image.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Title text below the image
                        Text(
                          image.title.isNotEmpty ? image.title : 'Untitled',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Show a loading indicator when more images are being fetched
            if (imageController.isLoadingMore.value)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MasonryGridView.builder(
        gridDelegate:
            const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: 8, // Number of shimmer items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    color: Colors.grey[300],
                    height: 200 + (index % 3) * 50, // Simulate staggered heights
),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
