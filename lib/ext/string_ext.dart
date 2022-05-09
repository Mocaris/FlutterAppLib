

extension StringExt on String {

  String hidePhoneNumber() {
    if (length >= 8) {
      return replaceRange(length - 8, length - 4, "****");
    }
    return this;
  }
}
