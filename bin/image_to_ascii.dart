import 'dart:io';

import 'package:ascii_image/ascii_table.dart';
import 'package:ascii_image/find_eoi.dart';
import 'package:ascii_image/find_sof.dart';
import 'package:ascii_image/image_format.dart';

void main(List<String> args) async {
  const defaultImage = 'C:/Dev/Estudos - DEV/ascii_image/bin/img.jpg';

  final img = File(args.isEmpty ? defaultImage : args.single);
  if (await img.exists()) {
    final bytes = img.readAsBytesSync();

    final indexSOF = findSOF(bytes);

    if (indexSOF == -1) return;

    final pixelDepth = 24;

    final height = (bytes[indexSOF + 5] << 8) | (bytes[indexSOF + 6]);
    final width = (bytes[indexSOF + 7] << 8) | (bytes[indexSOF + 8]);

    final size = (((height * width) * pixelDepth)) / (8 * 1024);

    final buffer = StringBuffer();

    final indexEOI = findEOI(bytes);
    print(bytes.length);

    try {
      // Percorrendo imagem (altura x largura)
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final index = y * width + x;
          final pixel = bytes[index];
          if (pixel == indexEOI) break;
          final red = (pixel >> 16) & 0xff;
          final green = (pixel >> 8) & 0xff;
          final blue = (pixel) & 0xff;
          // https://www.baeldung.com/cs/convert-rgb-to-grayscale
          final grayscale =
              ((0.3 * red) + (0.59 * green) + (0.11 * blue)).round();
          final charIndex = grayscale % asciiTable.length;
          final char = asciiTable[charIndex];
          buffer.write(char);
        }
        buffer.writeln('');
      }
    } catch (e) {
      print(e);
    }

    final generatedAsciiArt = File('../build/art.txt');
    await generatedAsciiArt.create(recursive: true);
    await generatedAsciiArt.writeAsString(buffer.toString());

    print("Formato: ${ImageFormat(bytes).format}");
    print("Dimensões: $height x $width px");
    print("Tamanho: $size KB");
  }
}
