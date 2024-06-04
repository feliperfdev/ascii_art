class AsciiChar {
  final String char;
  AsciiChar(this.char) {
    final ascii_32 = int.tryParse(char) ?? 0;
    final red = (ascii_32 >> 16) & 0xff;
    final green = (ascii_32 >> 8) & 0xff;
    final blue = (ascii_32) & 0xff;
    final brightess = (red + green + blue) / 3;
    final density = (brightess / 255);
  }
}
