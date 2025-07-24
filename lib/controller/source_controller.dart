import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController {
  static final ServiceController _instance = ServiceController._internal();
  factory ServiceController() => _instance;
  ServiceController._internal();

  static final streamToken = BehaviorSubject<String?>();

  static Stream<bool> get loginStream =>
      streamToken.map((token) => token != null);

  static Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("tokenOfAcess");
    streamToken.sink.add(token);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("tokenOfAcess");
    streamToken.sink.add(null);
  }
}
