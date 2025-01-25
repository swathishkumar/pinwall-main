class ImageModel {
  final String id;
  final String imageUrl;
  final String title;

  ImageModel({required this.id, required this.imageUrl, required this.title});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      imageUrl: json['urls']['small'],
      title: json['alt_description'] ?? 'Untitled',
    );
  }
}
