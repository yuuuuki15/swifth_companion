import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  String get _clientId => dotenv.env['CLIENT_ID'] ?? '';
  String get _clientSecret => dotenv.env['CLIENT_SECRET'] ?? '';
  String get _apiUrl => dotenv.env['API_URL'] ?? 'https://api.intra.42.fr/v2';

  Future<Map<String, dynamic>> getUser(String username) async {
    try {
      final tokenResponse = await http.post(
        Uri.parse('https://api.intra.42.fr/oauth/token'),
        body: {
          'grant_type': 'client_credentials',
          'client_id': _clientId,
          'client_secret': _clientSecret,
        },
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception('Failed to get token: ${tokenResponse.body}');
      }

      final token = jsonDecode(tokenResponse.body)['access_token'];

      final userResponse = await http.get(
        Uri.parse('$_apiUrl/users/$username'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (userResponse.statusCode != 200) {
        throw Exception('Failed to get user: ${userResponse.body}');
      }

      return jsonDecode(userResponse.body);
    } catch (e) {
      throw Exception('API error: $e');
    }
  }
}
