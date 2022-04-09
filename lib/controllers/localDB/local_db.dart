import 'package:get_storage/get_storage.dart';

class LocalDB {
  static final box = GetStorage();

  static setData(String key, dynamic val) {
    box.write(key, val);
  }

  static getData(String key) {
    return box.read(key);
  }

  static deleteData(String key) {
    return box.remove(key);
  }
}
