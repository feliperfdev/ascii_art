import 'image_format/image_format.dart';

class GeneratedAscii {
  final int height;
  final int width;
  final List<int> bytes;
  final double fileSize;

  GeneratedAscii({
    required this.height,
    required this.width,
    required this.bytes,
    required this.fileSize,
  });

  int get _totalBytes => bytes.length;
  int get _totalPixels => height * width;

  @override
  String toString() => '''
Format: ${imageFormat(bytes)}
Dimensions: $height x $width px
Total pixels: $_totalPixels px
Total bytes: $_totalBytes
File size: $fileSize KB
''';
}
