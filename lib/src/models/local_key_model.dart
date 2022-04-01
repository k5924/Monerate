import 'package:hive/hive.dart';

part 'local_key_model.g.dart';

/// This class lets us structure our hive objects
@HiveType(typeId: 0)
class LocalKeyModel extends HiveObject {
  /// This field will store the provider field in the hive object
  @HiveField(0)
  String provider;

  /// This field will store a list of keys associated with the provider
  @HiveField(1)
  List<String> keys;

  /// This constructor requires both the provider and keys be supplied on initialization of the class
  LocalKeyModel({required this.provider, required this.keys});
}
