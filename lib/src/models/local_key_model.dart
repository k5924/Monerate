import 'package:hive/hive.dart';

part 'local_key_model.g.dart';

@HiveType(typeId: 0)
class LocalKeyModel extends HiveObject {
  @HiveField(0)
  String provider;

  @HiveField(1)
  List<String> keys;

  LocalKeyModel({required this.provider, required this.keys});
}
