import 'dart:convert';
import 'dart:developer';

export 'dart:convert';

T? asT<T>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  if (value != null) {
    try {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        return (valueS == '1' || valueS == 'true') as T;
      } else {
        return json.decode(value.toString()) as T?;
      }
    } catch (e, s) {
      log('asT<$T>', error: e, stackTrace: s);
      if (0 is T) {
        return defaultValue ?? 0 as T;
      } else if (0.0 is T) {
        return defaultValue ?? 0.0 as T;
      } else if (false is T) {
        return defaultValue ?? false as T;
      }
    }
  } else {
    if ('' is T) {
      return defaultValue ?? "" as T;
    } else if (0 is T) {
      return defaultValue ?? 0 as T;
    } else if (0.0 is T) {
      return defaultValue ?? 0.0 as T;
    } else if (false is T) {
      return defaultValue ?? false as T;
    }
  }
  return defaultValue;
}
