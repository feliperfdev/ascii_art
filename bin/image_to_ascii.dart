import 'dart:io';

import 'package:ascii_image/find_byte_in_file.dart';
import 'package:ascii_image/image_format.dart';
import 'package:ascii_image/pixel_aspects.dart';

void main(List<String> args) async {
  const defaultImage = 'C:/Dev/Estudos - DEV/ascii_image/bin/img3.jpg';

  final img = File(args.isEmpty ? defaultImage : args.single);

  if (await img.exists()) {
    final bytes = img.readAsBytesSync().toList();

    final indexEOI = FindByteInFile.findEOI(bytes);
    final indexSOF = FindByteInFile.findSOF(bytes);

    if (indexSOF == -1 || indexEOI == -1) return;

    final pixelDepth = 24;

    final height = (bytes[indexSOF + 5] << 8) | (bytes[indexSOF + 6]);
    final width = (bytes[indexSOF + 7] << 8) | (bytes[indexSOF + 8]);

    final fileSize = ((height * width) * pixelDepth) / (8 * 1024);

    final buffer = StringBuffer();

    try {
      // Percorrendo imagem (altura x largura)
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final index = y * width + x;
          final pixel = bytes[index];
          if (pixel == indexEOI) break;
          final aspects = PixelAspects(pixel);
          buffer.write(aspects.char);
        }
        buffer.writeln('');
      }
    } catch (e) {
      print(e);
    }

    await _buildAsciiArt(buffer);

    print("Format: ${ImageFormat(bytes).format}");
    print("Dimensions: $height x $width px");
    print("Total pixels: ${height * width} px");
    print("Total bytes: ${bytes.length}");
    print("File size: $fileSize KB");
    return;
  } else {
    print("It wasn't possible to find file located at path: ${img.path}");
    return;
  }
}

Future<void> _buildAsciiArt(StringBuffer buffer) async {
  final generatedAsciiArt = File('../build/art.txt');
  await generatedAsciiArt.create(recursive: true);
  await generatedAsciiArt.writeAsString(buffer.toString());
}
