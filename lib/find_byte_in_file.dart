class FindByteInFile {
  // https://en.wikipedia.org/wiki/JPEG

  static int findSOF(List<int> bytes) {
    for (int i = 0; i < bytes.length; i++) {
      if ((bytes[i] == 0xFF && bytes[i + 1] == 0xC2) ||
          (bytes[i] == 0xFF && bytes[i + 1] == 0xC0)) {
        return i;
      }
    }
    return -1;
  }

  static int findEOI(List<int> bytes) {
    for (int i = 0; i < bytes.length; i++) {
      if (bytes[i] == 0xFF && bytes[i + 1] == 0xD9) {
        return i;
      }
    }
    return -1;
  }
}
