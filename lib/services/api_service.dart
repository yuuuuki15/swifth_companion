import 'dart:io'; // SocketException
import 'dart:async'; // TimeoutException
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  String get _clientId => dotenv.env['CLIENT_ID'] ?? '';
  String get _clientSecret => dotenv.env['CLIENT_SECRET'] ?? '';
  String get _baseUrl => dotenv.env['API_URL'] ?? 'https://api.intra.42.fr/v2';

  Future<Map<String, dynamic>> getToken() async {
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
      return {
        'access_token': data['access_token'],
        'expires_in': data['expires_in'],
        'created_at': data['created_at'],
      };
    } else {
      throw Exception('Failed to get token: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getUser(String login, String token) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/users/$login'),
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get user: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error: Please check your internet connection.');
    } on TimeoutException {
      throw Exception('Network timeout: The request took too long.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
