import 'dart:convert';

import 'package:flutter_wallet_ui_challenge/src/app.dart';
import 'package:http/http.dart' as http;

class ApiService
{
  static Future<List<dynamic>> getUserList() async
  {
    try
    {
      final response = await http.get('${Urls.Base_API_URL}/users');
    
      if (response.statusCode == 200)
      {
        return json.decode(response.body);
      }
      else
      {
        return null;
      }
    }
    catch (ex)
    {
      return null;
    }
    
  }
}