import 'dart:convert';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart' show rootBundle;

const rpcUrl =
    "https://polygon-mainnet.infura.io/v3/c731d68b09e6477fa3c86fa92380133e";
const rpcWssUrl =
    "wss://polygon-mainnet.infura.io/ws/v3/c731d68b09e6477fa3c86fa92380133e";
final client = Web3Client(rpcUrl, Client(), socketConnector: () {
  return IOWebSocketChannel.connect(rpcWssUrl).cast<String>();
});
final EthereumAddress contractAddr =
    EthereumAddress.fromHex('0x45c32fa6df82ead1e2ef74d17b76547eddfaff89');

Future<String> getAbi() async {
  String abiStringFile = await rootBundle.loadString('lib/utils/abi.json');
  var jsonAbi = jsonDecode(abiStringFile), abiCode = jsonEncode(jsonAbi);
  return abiCode;
}

Future<DeployedContract> getContract() async {
  String abi = await getAbi();
  final contract =
      DeployedContract(ContractAbi.fromJson(abi, 'MetaCoin'), contractAddr);
  return contract;
}

getName() async {
  final contract = await getContract();
  final nameFunction = contract.function('name');

  final name =
      await client.call(contract: contract, function: nameFunction, params: []);
  print(name);
}

getBalance(String address) async {
  final contract = await getContract();

  final balanceFunction = contract.function('balanceOf');

  final balance = await client.call(
      contract: contract,
      function: balanceFunction,
      params: [EthereumAddress.fromHex(address)]);
  return (EtherAmount.fromBigInt(EtherUnit.wei, balance.first)
      .getValueInUnit(EtherUnit.ether)
      .toStringAsFixed(2));
}
