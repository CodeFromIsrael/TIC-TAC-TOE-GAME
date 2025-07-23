import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final streamToken = BehaviorSubject<String?>();
final Stream<bool> loginStream = streamToken.map((token) => token != null);

Future<bool> checkLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("tokenOfAcess");
  streamToken.sink.add(token);
  return token != null;
}

void closeStreams() {
  streamToken.close();
}
