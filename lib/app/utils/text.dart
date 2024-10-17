class UtilText {
  // Ẩn text khi quá dài thành ...
  static String truncateString(String str, int maxLength) {
    return (str.length <= maxLength)
        ? str
        : '${str.substring(0, maxLength)}...';
  }
}
