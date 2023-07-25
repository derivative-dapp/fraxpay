import 'dart:convert';

import 'package:http/http.dart' as http;

Future getTokenByAddress(String address) async {
  try {
    http.Response response = await http.get(
        Uri.parse("https://fanpay-api.daggle.xyz/tokens/$address"),
        headers: {"Content-Type": "application/json"});
    var fR = jsonDecode(response.body);
    return fR;
  } catch (e) {
    //
  }
}

Future getNFTByAddress(String address) async {
  try {
    http.Response response = await http.get(
        Uri.parse("https://fanpay-api.daggle.xyz/nfts/$address"),
        headers: {"Content-Type": "application/json"});
    var fR = jsonDecode(response.body);
    return fR['result'];
  } catch (e) {
    //
  }
}
