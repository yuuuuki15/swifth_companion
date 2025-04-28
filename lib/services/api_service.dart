import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class ApiService {
  String get _clientId => dotenv.env['CLIENT_ID'] ?? '';
  String get _clientSecret => dotenv.env['CLIENT_SECRET'] ?? '';
  String get _baseUrl => dotenv.env['API_URL'] ?? 'https://api.intra.42.fr/v2';

  Future<String> getToken() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/oauth/token'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'grant_type': 'client_credentials',
        'client_id': _clientId,
        'client_secret': _clientSecret,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to get token: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getUser(String login, String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$login'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user: ${response.statusCode}');
    }
  }
}
