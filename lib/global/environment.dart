import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.18.16:3000/api'
      : 'http://localhost:3000/api';

  static String socket = Platform.isAndroid
      ? 'http://192.168.18.16/api'
      : 'http://192.168.18.16/api';
}
