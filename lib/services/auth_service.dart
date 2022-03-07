import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/usuario.dart';

import '../global/environment.dart';

class AuthService with ChangeNotifier {
  // Definiciones
  late Usuario usuario;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();

  // Getters y setters
  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  // Obtener token
  static Future getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  // Borrar Token
  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  // Login
  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {
      'email': email,
      'password': password,
    };

    String url = '${Environment.apiUrl}/login';

    final resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  // Registrar nuevo usuario
  Future register(String email, String password, String nombre) async {
    autenticando = true;

    final data = {'email': email, 'password': password, 'nombre': nombre};

    String url = '${Environment.apiUrl}/login/new';

    final resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  // Comprobar token
  Future isloggedIn() async {
    final token = await _storage.read(key: 'token');
    print(token.toString());
    String url = '${Environment.apiUrl}/login/renew';

    final resp = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString(),
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  // Guardar token
  Future _guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
    return;
  }

  // Eliminar token
  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
