import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Future<String> getDomain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('instance')!;
  }
}
