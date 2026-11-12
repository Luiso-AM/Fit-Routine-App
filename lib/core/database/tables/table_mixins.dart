import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Generates a random UUID v4 for new rows.
String newId() => _uuid.v4();

/// Current time in UTC, used for timestamp defaults.
DateTime nowUtc() => DateTime.now().toUtc();

/// Columns shared by every table: UUID primary key and UTC timestamps.
mixin EntityColumns on Table {
  TextColumn get id => text().clientDefault(newId)();

  DateTimeColumn get createdAt => dateTime().clientDefault(nowUtc)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(nowUtc)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Soft delete for entities that history may still reference.
mixin SoftDeleteColumn on Table {
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
