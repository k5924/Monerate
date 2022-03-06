import 'package:hive/hive.dart';
import 'package:monerate/src/models/export.dart';

class BoxProvider {
  static Box<LocalKeyModel> getKeys() => Hive.box<LocalKeyModel>('local_keys');
}
