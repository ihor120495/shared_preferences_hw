import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _keyStringList = 'string_list';

  Future<void> saveStringList(List<String> stringList) async {
    final prefs = await SharedPreferences.getInstance();
    final stringListString = stringList.join(',');
    await prefs.setString(_keyStringList, stringListString);
  }

  Future<List<String>> getStringList() async {
    final prefs = await SharedPreferences.getInstance();
    final stringListString = prefs.getString(_keyStringList);
    if (stringListString == null || stringListString.isEmpty) {
      return [];
    }
    return stringListString.split(',');
  }

  Future<void> removeStringFromList(String stringToRemove) async {
    final stringList = await getStringList();
    stringList.remove(stringToRemove);
    await saveStringList(stringList);
  }
}