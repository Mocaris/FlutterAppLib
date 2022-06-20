mixin DateFormat {

  /// Return a string representing [date] formatted according to our locale
  /// and internal format.
  String format(DateTime date);

  /// Given user input, attempt to parse the [inputString] into the anticipated
  /// format, treating it as being in the local timezone.
  ///
  /// If [inputString] does not match our format, throws a [FormatException].
  /// This will accept dates whose values are not strictly valid, or strings
  /// with additional characters (including whitespace) after a valid date. For
  /// stricter parsing, use [parseStrict].
  DateTime parse(String source, {bool utc = false});
}
