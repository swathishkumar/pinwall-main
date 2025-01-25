// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/image_model.dart';

// class ImageController extends GetxController {
//   var isLoading = false.obs;
//   var isLoadingMore = false.obs;
//   var images = <ImageModel>[].obs;

//   final String apiUrl = 'https://api.unsplash.com/photos';
//   final String accessKey = 'mKzvacBirethsiU4FG--9JZ71XYr4oqYsWMbslpIvqI';
//   int page = 1;
//   final int perPage = 12;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchImages();
//   }

//   void fetchImages() async {
//     if (isLoading.value) return;
//     isLoading(true);
//     try {
//       final response = await http.get(
//         Uri.parse('$apiUrl?page=$page&per_page=$perPage&client_id=$accessKey'),
//       );

//       if (response.statusCode == 200) {
//         final List data = json.decode(response.body);
//         images.addAll(data.map((e) => ImageModel.fromJson(e)).toList());
//         page++;
//       } else {
//         Get.snackbar('Error', 'Failed to load images');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   void loadMoreImages() async {
//     if (isLoadingMore.value) return;
//     isLoadingMore(true);
//     try {
//       final response = await http.get(
//         Uri.parse('$apiUrl?page=$page&per_page=$perPage&client_id=$accessKey'),
//       );

//       if (response.statusCode == 200) {
//         final List data = json.decode(response.body);
//         images.addAll(data.map((e) => ImageModel.fromJson(e)).toList());
//         page++;
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load more images');
//     } finally {
//       isLoadingMore(false);
//     }
//   }
// }



import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import '../models/image_model.dart';

class ImageController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var images = <ImageModel>[].obs;

  final String apiUrl = 'https://api.unsplash.com/photos';
  final String accessKey = 'mKzvacBirethsiU4FG--9JZ71XYr4oqYsWMbslpIvqI';
  int page = 1;
  final int perPage = 10;

  @override
  void onInit() {
    super.onInit();
    // fetchImages();
    fetchImagesWithDelay();
  }

  // void fetchImages() async {
  //   if (isLoading.value) return;
  //   isLoading(true);
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$apiUrl?page=$page&per_page=$perPage&client_id=$accessKey'),
  //     );

  //     if (response.statusCode == 200) {
  //       final List data = json.decode(response.body);
  //       images.addAll(data.map((e) => ImageModel.fromJson(e)).toList());
  //       page++;
  //     } else {
  //       Get.snackbar('Error', 'Failed to load images');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void loadMoreImages() async {
    if (isLoadingMore.value) return;
    isLoadingMore(true);
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?page=$page&per_page=$perPage&client_id=$accessKey'),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        images.addAll(data.map((e) => ImageModel.fromJson(e)).toList());
        page++;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load more images');
    } finally {
      isLoadingMore(false);
    }
  }

  Future<void> fetchImagesWithDelay() async {
    isLoading(true);

    // Simulate a 4-second shimmer effect
    await Future.delayed(const Duration(seconds: 4));

    try {
      final response = await http.get(
        Uri.parse('$apiUrl?page=$page&per_page=$perPage&client_id=$accessKey'),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        images.addAll(data.map((e) => ImageModel.fromJson(e)).toList());
        page++;
      } else {
        Get.snackbar('Error', 'Failed to load images');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadImage(String imageUrl, String fileName) async {
    try {
      // Request permission to access storage
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          Get.snackbar('Permission Denied', 'Storage permission is required to download images.');
          return;
        }
      }

      // Get the directory to save images
      final Directory? directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (directory == null) {
        Get.snackbar('Error', 'Failed to find a directory to save the image.');
        return;
      }

      final String savePath = '${directory.path}/$fileName';

      // Download the image using Dio
      final Dio dio = Dio();
      await dio.download(imageUrl, savePath);

      Get.snackbar('Success', 'Image downloaded to $savePath');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download image: $e');
    }
  }
}
