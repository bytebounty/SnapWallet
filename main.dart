import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/src/app.dart';
import 'package:flutter_wallet_ui_challenge/src/data/data.dart';
import 'package:flutter_wallet_ui_challenge/src/models/credit_card_model.dart';
import 'package:flutter_wallet_ui_challenge/src/models/payment_model.dart';
import 'package:flutter_wallet_ui_challenge/src/welcome_scree.dart';
import 'package:path_provider/path_provider.dart';

String walletBalance = "0";
String price = "";
String totalAmount = "1";
Map<String, dynamic> content = new Map();
var add;
String withNoSpaces;
String cardDetails;
var paymentNo = 0;
List<List<String>> strList = new List();
List<String>temp = new List();
List<CreditCardModel> creditCards = [];
  List<PaymentModel> paymentCards = [];

Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/balance.txt');
}

Future<File> get _cardPath async{
  final path1 = await _localPath;
  return File('$path1/cards.txt');
}

Future<File> get _statusFile async {
  final path = await _localPath;
  return File('$path/status.txt');
}

Future<File> get _transactionFile async {
  final path = await _localPath;
  return File('$path/transactions.txt');
}

Future<String> readBalance() async {
    try {
      final file = await _localFile;
      // Read the file
      walletBalance = await file.readAsString();
      return walletBalance;
    } catch (e) {
      // If encountering an error, return 0
      return "0";
    }
}

Future<String> readCards() async{
  try{
    final file = await _cardPath;
    print("cards.txt file is = ");
    String cards = await file.readAsString();
    print(cards);
    print("*****************************");
    return cards;
  }
  catch (e)
  {
    return "";
  }
  
}

Future<String> readStatus() async {
    try {
      final file = await _statusFile;
      // Read the file
      String stat = await file.readAsString();
      return stat;
    } catch (e) {
      // If encountering an error, return 0
      return "0";
    }
}

Future<String> readTrans() async {
    try {
      final file = await _statusFile;
      // Read the file
      String stat = await file.readAsString();
      return stat;
    } catch (e) {
      // If encountering an error, return 0
      return "0";
    }
}

Future<File> writeBalance(String balance) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$balance');
}

Future<File> writecards(String a) async
{
  String abc = await readCards();
  final file = await _cardPath;
  abc += "|" + a;
  //print("card details = " + abc);
  cardDetails = abc;
  return file.writeAsString(abc);
}

Future<File> writeStatus(String status) async {
    final file = await _statusFile;

    // Write the file
    return file.writeAsString('$status');
}

Future<File> writeTrans(String status) async {
    final file = await _statusFile;

    // Write the file
    return file.writeAsString('$status');
}

Future main()
async {
  await getCreditCards();
  readCards();
  readBalance();
  readStatus();
  String s = await readStatus();
  if(s == "0" || s == "")
  {
    await writeStatus("no");
  }
  else if(s == "yes")
  {
    runApp(Welcome());
  }
  else if(s == "no")
  {
    runApp(App());
  }
}




