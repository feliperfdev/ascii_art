import 'package:ascii_image/image_format/image_format.dart';

class PNGImageFormat extends ImageFormat {
  PNGImageFormat(super.bytes);

  @override
  final format = [89, 50, 0x4E, 47, 0x0D, 0x0A, 0x1A, 0x0A];

  @override
  final formatText = 'PNG';
}
