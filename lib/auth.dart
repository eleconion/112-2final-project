import 'package:http/http.dart' as http;
import 'dart:convert';
Future<String> authenticate() async {
  final String clientId = 'c110151135-76d77b20-fcbb-4266';
  final String clientSecret = '098ad98f-9094-4a2c-b660-d5f4daff81c2';
  final String auth_Url = 'https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token';

  final response = await http.post(
    Uri.parse(auth_Url),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    },
  );

  if (response.statusCode == 200) {
    final authJson = jsonDecode(response.body);
    return authJson['access_token'];

  } else {
    throw Exception('Failed to authenticate: ${response.statusCode}');
  }
}