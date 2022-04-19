import 'dart:convert';
import 'package:fyp/constants.dart';
import 'package:http/http.dart' as http;

import 'report_filter.dart';

class Transaction {
  String id;
  String userId;
  double amount;
  String category;
  DateTime date;
  String? description;
  String type;

  Transaction(
      {required this.id,
      required this.amount,
      required this.category,
      required this.date,
      this.description,
      required this.userId,
      required this.type});

  static Transaction fromPayload(Map<String, dynamic> rawTransaction) {
    return Transaction(
      id: rawTransaction['id'],
      amount: double.parse(rawTransaction['amount'].toString()),
      category: rawTransaction['category'],
      date: DateTime.parse(rawTransaction['trn_date']),
      description: rawTransaction['description'],
      type: rawTransaction['trn_type'],
      userId: rawTransaction['userid'],
    );
  }

  static Future<List<Transaction>> getAllFromServer(String userId) async {
    var resp = await http.post(Uri.parse(kBackendURL + "/transactions/all.php"),
        body: jsonEncode({"userid": userId}));
    if (resp.statusCode != 200) {
      throw Exception("Response status code: ${resp.statusCode}");
    }
    var body = jsonDecode(resp.body);
    if (body['status'] != 'success') {
      throw Exception(body['error'] ?? "Server Error");
    }
    return (body['transactions'] as List).map((e) => fromPayload(e)).toList();
  }

  bool passes(ReportFilter filter) {
    if (filter.from != null && filter.to != null) {
      return date.isAfter(filter.from!) && date.isBefore(filter.to!);
    } else {
      if (filter.from != null) {
        return date.isAfter(filter.from!);
      } else if (filter.to != null) {
        return date.isBefore(filter.to!);
      } else {
        return true;
      }
    }
  }
  // bool passes(ReportFilter filter) {
  //   if (filter.from != null && filter.to != null) {
  //     return !date.isBefore(filter.from!) && !date.isAfter(filter.to!);
  //   } else {
  //     if (filter.from != null) {
  //       return !date.isBefore(filter.from!);
  //     } else if (filter.to != null) {
  //       return !date.isAfter(filter.to!);
  //     } else {
  //       return true;
  //     }
  //   }
  // }
}
