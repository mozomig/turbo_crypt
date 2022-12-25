class BytesUtils {
  static List<int> addPadding({
    required List<int> bytes,
    required int blockSize,
  }) {
    final truncate = (bytes.length / blockSize).truncate();
    final padding = blockSize * (truncate + 1) - bytes.length;
    return [
      ...bytes,
      ...List.generate(padding, (index) => 0),
    ];
  }
}
