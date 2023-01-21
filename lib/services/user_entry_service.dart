import 'dart:convert';

import 'domain.dart';
import 'package:http/http.dart' as http;

class UserEntry {
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
    print(response.body);
    return '';
  }
}
