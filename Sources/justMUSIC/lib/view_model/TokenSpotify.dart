import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenSpotify {
  final String clientId = 'd9b82921bbdf43efa15d0c34c28c6f93';
  final String _clientSecret = 'ba01687f59ea4ab7ad00c769e89e44d8';
  late String _accessToken;
  late DateTime _tokenEnd;

  TokenSpotify() {
    _tokenEnd = DateTime.now().add(Duration(seconds: -10));
  }

  Future<String> getAccessToken() async {
    if (_isTokenExpired()) {
      await _refreshToken();
    }
    return _accessToken;
  }

  _refreshToken() async {
    final basicAuth = base64Encode(utf8.encode('$clientId:$_clientSecret'));
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials',
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _accessToken = responseData['access_token'];
      _tokenEnd =
          DateTime.now().add(Duration(seconds: responseData['expires_in']));
    } else {
      print('Error refreshing token : ${response.statusCode}');
    }
  }

  bool _isTokenExpired() {
    return DateTime.now().isAfter(_tokenEnd);
  }
}
