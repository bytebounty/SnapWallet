import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/main.dart';
import 'package:flutter_wallet_ui_challenge/src/models/credit_card_model.dart';
import 'package:flutter_wallet_ui_challenge/src/models/payment_model.dart';
import 'package:flutter_wallet_ui_challenge/src/models/user_model.dart';

List<CreditCardModel> creditCards1 = [];
Future getCreditCards() 
async { 
  print ("I am in the getCreditCard Function.\n");
  String cards = await readCards();
  String temp = cards;
  if (temp == "")
  {
    creditCards.add(CreditCardModel("****************","https://resources.mynewsdesk.com/image/upload/ojf8ed4taaxccncp6pcp.png","**/**","***"));
  }
  String cNum1, cNum, dt, cvv;
  String prevCard = "";
  for (var i =0; i<temp.length; i++)
  {
    if(temp[i] == "|")
    {
      String t = temp.substring(i+1, i+26);
      cNum1 = t.substring(0,19);
      if(prevCard != cNum1)
      {
        prevCard = cNum1;
        cNum = cNum1.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
        dt = t.substring(20, 25);
        cvv = "443";    
        creditCards.add(CreditCardModel(cNum,"https://resources.mynewsdesk.com/image/upload/ojf8ed4taaxccncp6pcp.png",dt,cvv));
      }
    }
  }
}

List<UserModel> getUsersCard() {
  List<UserModel> userCards = [
    UserModel("Anna", "assets/images/users/anna.jpeg"),
    UserModel("Gillian", "assets/images/users/gillian.jpeg"),
    UserModel("Judith", "assets/images/users/judith.jpeg"),
  ];

  return userCards;
}

List<PaymentModel> getPaymentsCard() {
      List<PaymentModel> paymentCards = [
    (PaymentModel(Icons.receipt, Color(0xFFffd60f), "Sample Store",
    "02-01", "09:04", 0.00, 1)),
    (PaymentModel(Icons.receipt, Color(0xFFffd60f), "Real Madrid Store",
    "02-01", "10:04", 2251.00, -1)),
    (PaymentModel(Icons.receipt, Color(0xFFff415f), "Uber",
        "09-13", "14:01", 164.00, -1)),
    (PaymentModel(Icons.location_city, Color(0xFF50f3e2), "Uber Eats",
        "09-06", "10:04", 1151.00, -1)),
    (PaymentModel(Icons.train, Colors.green, "Train ticket from Kurunegala", "02-01",
        "04:01", 135.00, -1)),
    (PaymentModel(Icons.receipt, Color(0xFFff415f), "Scope Cinemas",
        "02-01", "16:01", 2640.00, -1)),
    (PaymentModel(Icons.location_city, Color(0xFF50f3e2), "Uber Eats",
        "02-01", "12:04", 673.00, -1)),
    (PaymentModel(Icons.train, Colors.green, "Arpico Super Center", "02-01",
        "13:04", 13500.00, -1)),
    (PaymentModel(Icons.train, Colors.green, "Netflix", "02-01",
        "13:33", 1500.00, -1)),
  ];
  return paymentCards;
}
