import 'dart:convert';

class JsonPrinter {
  static String prettyPrint(Map<String, dynamic> json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }
}