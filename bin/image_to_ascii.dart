import 'dart:io';

import 'package:ascii_image/find_byte_in_file.dart';
import 'package:ascii_image/generated_ascii.dart';
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

    // https://stackoverflow.com/questions/18264357/how-to-get-the-width-height-of-jpeg-file-without-using-library?rq=3
    final height = (bytes[indexSOF + 5] << 8) | (bytes[indexSOF + 6]);
    final width = (bytes[indexSOF + 7] << 8) | (bytes[indexSOF + 8]);

    final fileSize = ((height * width) * pixelDepth) / (8 * 1024);

    final buffer = StringBuffer();

    try {
      // Reading image (height x width)
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final index = y * width + x;
          final pixel = bytes.elementAtOrNull(index);
          if (pixel == null || pixel == indexEOI) break;
          final aspects = PixelAspects(pixel);
          buffer.write(aspects.char);
        }
        buffer.writeln('');
      }
    } catch (e, st) {
      print(e);
      print('STACK_TRACE: $st');
    }

    await _buildAsciiArt(buffer);

    final generatedAscii = GeneratedAscii(
      height: height,
      width: width,
      bytes: bytes,
      fileSize: fileSize,
    );

    print(generatedAscii.toString());

    return;
  } else {
    print("It wasn't possible to find file located at path: ${img.path}");
    return;
  }
}

Future<void> _buildAsciiArt(StringBuffer buffer) async {
  final generatedAsciiArt = File('./build/art.txt');

  print('Generating ASCII art...');
  final generated = await generatedAsciiArt.create(recursive: true);
  print('ASCII art generated!');

  await generatedAsciiArt.writeAsString(buffer.toString());
  print('ASCII art was stored locally at ${generated.path}!');
}
