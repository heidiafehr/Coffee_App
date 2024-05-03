class CoffeeImage {
  final String file;

  CoffeeImage({
    required this.file,
  });

  factory CoffeeImage.fromRestJson(Map<String, dynamic> json) {
    return CoffeeImage(
      file: json['file']
    );
  }
}
