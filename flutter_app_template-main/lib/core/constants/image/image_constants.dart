class ImageConstants {
  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  ImageConstants._init();

  String get logo => toPng('logo');
  String get titleLogo => toPng('title_logo');
  String get splashBackground => toPng('splash_background');

  String toPng(String name) => 'assets/images/$name.png';
}
