import 'package:hive/hive.dart';

part 'local_key_model.g.dart';

@HiveType(typeId: 0)
class LocalKeyModel extends HiveObject{
  @HiveField(0)
  late String provider;

  @HiveField(1)
  late String keyName;

  @HiveField(2)
  late String value;
}
