import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://dummyjson.com';
  static const String url = 'carts';


  static Future<Map<String, dynamic>> fetchData(int? page) async {
    print('api services fetchData gets executed');

    try {
       final apiUrl = Uri.parse('$baseUrl/$url/$page');
      print('URI PARSING: $apiUrl');
      final headers = {'Content-Type': 'application/json', 'Host': '<calculated when request is sent>'};
      print(headers);
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        print('success');
        final data = json.decode(response.body);


        return data;
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> fetchOuterData() async {
    print('Out fetch api services  gets executed');

    try {
      final apiUrl = Uri.parse('$baseUrl/$url');
      print('URI PARSING: $apiUrl');
      final headers = {'Content-Type': 'application/json', 'Host': '<calculated when request is sent>'};
      print(headers);
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        print('Success in outer api fetching');
        final outerdata = json.decode(response.body);
         return outerdata;
      } else {
        throw Exception('Failed to load outerdata. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }








}






















//
// class Api {
//
//   static const String baseUrl = 'https://dummyjson.com';
//   static const String url = 'carts';
//
//   static Future<Map<String, dynamic>> fetchData() async {
//     print('api services fetchdata gets executed');
//     try {
//       final uirl = Uri.parse('$baseUrl/$url');
//       print (uirl) ;
//       final headers = {'Content-Type': 'application/json', 'Host':'<calculated when request is sent>'};
//       print(headers);
//       final response = await http.get(uirl);
//
//       if (response.statusCode == 200) {
//         print('success');
//         final data  = json.decode(response.body);
//         return data;
//       } else {
//         throw Exception('Failed to load data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }
//
//