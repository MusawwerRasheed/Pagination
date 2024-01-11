

import 'package:pagination/Services/ApiServices/api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaginationRepository {

  static Future<Map<String, dynamic>> getCarts(int? page) async {

    try {
      return await Api.fetchData(page).then(
            (value) {
          return value;
        },
      ).catchError((e) {
        throw e;
      });
    } catch (e) {
      print('Error in PaginationRepository: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getOuterData() async {

    try {
      return await Api.fetchOuterData().then(
            (value) {
          return value;
        },
      ).catchError((e) {
        throw e;
      });
    } catch (e) {
      print('Error in PaginationRepository: $e');
      rethrow;
    }
  }


}







//
//
//
// class PaginationRepository {
//
//   static Future< dynamic> getCarts() async {
//     try {
//       return await Api.fetchData().then(
//         (value) {
//           print('inside the pagination $value');
//           return value;
//         },
//       ).catchError((e) {
//         throw e;
//       });
//     } catch (e) {
//       print('Error in PaginationRepository: $e');
//       rethrow;
//     }
//   }
// }
