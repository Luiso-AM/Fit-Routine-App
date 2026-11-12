import 'dart:convert';

import 'package:drift/drift.dart';

/// Stores a list of enum values as a JSON array of their names,
/// e.g. `["chest","triceps"]`.
class EnumListConverter<T extends Enum> extends TypeConverter<List<T>, String> {
  const EnumListConverter(this.values);

  /// All values of the enum, usually `MyEnum.values`.
  final List<T> values;

  @override
  List<T> fromSql(String fromDb) {
    final names = jsonDecode(fromDb) as List<dynamic>;
    return [for (final name in names) values.byName(name as String)];
  }

  @override
  String toSql(List<T> value) => jsonEncode([for (final e in value) e.name]);
}
