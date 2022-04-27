import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageManager {
  static void save(String key, dynamic value) async {
    // final sp = await SharedPreferences.getInstance();
    // final storage = new FlutterSecureStorage();
    await SharedPreferences.getInstance().then((prefs) async {
      await prefs.setString(key, value);
    });

    // await storage.write(key: key, value: value);
  }

  static Future<dynamic> read(String key) async {
    // final sp = await SharedPreferences.getInstance();
    // final storage = new FlutterSecureStorage();
    // dynamic value = await storage.read(key: key);
    var prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key);
    return value;
    // dynamic obj = sp.get(key);
    // return value;

  }

  static Future<bool> delete(String key) async {
    // final sp = await SharedPreferences.getInstance();
    // final storage = new FlutterSecureStorage();
    // // return sp.remove(key);
    // await storage.delete(key: key);
    await SharedPreferences.getInstance().then((prefs) async {
      await prefs.remove(key);

    });
    return true;
    // return true;
  }
}