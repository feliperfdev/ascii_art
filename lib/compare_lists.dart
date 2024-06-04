bool compareLists(List a, List b) {
  if (a.length != b.length) return false;

  bool equal = false;

  for (final ea in a) {
    final index = a.indexOf(ea);
    equal = b[index] == ea;
  }
  return equal;
}
