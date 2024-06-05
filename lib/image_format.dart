import 'package:ascii_image/compare_lists.dart';

class ImageFormat {
  final List<int> bytes;

  ImageFormat(this.bytes);

  final formats = {
    'jpeg': [0xFF, 0xD8, 0xFF],
    'png': [89, 50, 0x4E, 47, 0x0D, 0x0A, 0x1A, 0x0A],
  };

  String get format {
    if (compareLists(bytes.sublist(0, formats['jpeg']!.length).toList(),
        formats['jpeg'] as List<int>)) {
      return 'JPEG';
    } else if (compareLists(bytes.sublist(0, formats['png']!.length).toList(),
        formats['png'] as List<int>)) {
      return 'PNG';
    }
    return 'WEBP';
  }
}
