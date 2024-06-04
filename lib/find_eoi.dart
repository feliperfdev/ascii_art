int findEOI(List<int> bytes) {
  for (int i = 0; i < bytes.length; i++) {
    // https://en.wikipedia.org/wiki/JPEG
    if (bytes[i] == 0xFF && bytes[i + 1] == 0xD9) {
      return i;
    }
  }
  return -1;
}
