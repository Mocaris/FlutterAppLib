import 'package:flutter_utils/utils/date/date_format.dart';
import 'package:intl/intl.dart' as intl;

/// 字母	含义	示例
/// y	年份。一般用 yy 表示两位年份，yyyy 表示 4 位年份	使用 yy 表示的年扮，如 11；使用 yyyy 表示的年份，如 2011
/// M	月份。一般用 MM 表示月份，如果使用 MMM，则会 根据语言环境显示不同语言的月份	使用 MM 表示的月份，如 05； 使用 MMM 表示月份，在 Locale.CHINA 语言环境下，如“十月”；在 Locale.US 语言环境下，如 Oct
/// d	月份中的天数。一般用 dd 表示天数	使用 dd 表示的天数，如 10
/// D	年份中的天数。表示当天是当年的第几天， 用 D 表示	使用 D 表示的年份中的天数，如 295
/// E	星期几。用 E 表示，会根据语言环境的不同， 显示不同语言的星期几	使用 E 表示星期几，在 Locale.CHINA 语言环境下，如“星期四”；在 Locale.US 语言环境下，如 Thu
/// H	一天中的小时数（0~23)。一般用 HH 表示小时数	使用 HH 表示的小时数，如 18
/// h	一天中的小时数（1~12)。一般使用 hh 表示小时数	使用 hh 表示的小时数，如 10 (注意 10 有可能是 10 点，也可能是 22 点）
/// m	分钟数。一般使用 mm 表示分钟数	使用 mm 表示的分钟数，如 29
/// s	秒数。一般使用 ss 表示秒数	使用 ss 表示的秒数，如 38
/// S	毫秒数。一般使用 SSS 表示毫秒数	使用 SSS 表示的毫秒数，如 156
class SimpleDateFormat implements DateFormat {
  final intl.DateFormat _dateFormat;

  SimpleDateFormat(String pattern) : _dateFormat = intl.DateFormat(pattern);

  String? get pattern => _dateFormat.pattern;

  @override
  String format(DateTime date) {
    return _dateFormat.format(date);
  }

  @override
  DateTime parse(String source, {bool utc = false}) {
    return _dateFormat.parse(source, utc);
  }
}
