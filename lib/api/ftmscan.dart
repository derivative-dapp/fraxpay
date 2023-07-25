import 'dart:convert';

import 'package:http/http.dart' as http;

Future getTransactionsByAccount(String add) async {
  try {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.ftmscan.com/api?module=account&action=txlist&address=$add&sort=desc&apikey=YREMA5SU4GWAVY99N9YPE9JCJTEMC2XZHK"),
    );
    var fR = jsonDecode(response.body);
    return fR["result"];
  } catch (e) {
    //
  }
}
