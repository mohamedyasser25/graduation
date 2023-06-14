import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static clearAllData() async {
    List<String> favsEmails = sharedPreferences?.getStringList('favsEmails') ?? [];
    List<List<String>> allMappedFavs = [];

    favsEmails.forEach((element) {
      allMappedFavs.add(sharedPreferences?.getStringList(element + 'favs') ?? []);
    });

    await sharedPreferences?.clear();

    for (int i = 0; i < allMappedFavs.length; i++) {
      sharedPreferences?.setStringList('favsEmails', favsEmails);
      sharedPreferences?.setStringList(favsEmails[i] + 'favs', allMappedFavs[i]);
    }

    List x = sharedPreferences?.getStringList('favsEmails') ?? [];
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}