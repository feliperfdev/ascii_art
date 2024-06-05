import 'package:ascii_image/ascii_table.dart';

class PixelAspects {
  final int pixel;

  PixelAspects(this.pixel);

  int get red => (pixel >> 16) & 0xff;
  int get green => (pixel >> 8) & 0xff;
  int get blue => (pixel) & 0xff;

  // https://www.baeldung.com/cs/convert-rgb-to-grayscale
  int get grayscale => ((0.3 * red) + (0.59 * green) + (0.11 * blue)).round();

  int get charIndex => grayscale % asciiTable.length;
  String get char => asciiTable[charIndex];
}
