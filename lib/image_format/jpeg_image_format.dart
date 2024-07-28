import 'package:ascii_image/image_format/image_format.dart';

class JPEGImageFormat extends ImageFormat {
  JPEGImageFormat(super.bytes);

  @override
  final format = <int>[0xFF, 0xD8, 0xFF];

  @override
  final formatText = 'JPEG';
}
