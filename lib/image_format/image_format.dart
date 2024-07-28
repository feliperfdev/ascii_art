import 'package:ascii_image/image_format/jpeg_image_format.dart';
import 'package:ascii_image/image_format/png_image_format.dart';

abstract class ImageFormat {
  final List<int> bytes;

  ImageFormat(this.bytes);

  abstract final List<int> format;
  abstract final String formatText;
}

String imageFormat(List<int> bytes) =>
    (bytes.length == 3 ? JPEGImageFormat(bytes) : PNGImageFormat(bytes))
        .formatText;
