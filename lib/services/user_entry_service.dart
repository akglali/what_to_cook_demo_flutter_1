import 'dart:convert';

import 'domain.dart';
import 'package:http/http.dart' as http;

class UserEntryService {
  Future<String> googleSignIn(String? idToken) async {
    var url = Uri.parse('${domain}User/GoogleEntry');
    var response = await http.post(
      url,
      body: json.encode(
        {
          'id_token': idToken,
        },
      ),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    var body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return body["Error"];
    }
    return 'Welcome to the paradise!';
  }

  Future<String> emailSignUp(String email, username, password, code) async {
    var url = Uri.parse('${domain}User');
    var response = await http.post(url,
        body: json.encode(
          {
            "username": username,
            "password": password,
            "email": email,
            "code": code
          },
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
    var body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return body["Error"];
    }
    return 'Welcome to the paradise!';
  }

  Future<String> verifyEmail(String email) async {
    var url = Uri.parse('${domain}User/Verify');
    var response = await http.post(url,
        body: json.encode(
          {
            "email": email,
          },
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
    var body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return body["Error"];
    }
    return '';
  }

}
