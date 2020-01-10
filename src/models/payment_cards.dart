import 'dart:core';

class PaymentCard
{
  int cardID;
  final String cardNumber;
  final String expDate;
  final String cvv;
  final String logo;
  String fakeCardNumber;

  String get cardNum => cardNumber;
  String get fakeCardNum => fakeCardNumber;
  String get expireDat =>expDate;
  String get cvvs =>cvv;

  PaymentCard({this.cardNumber, this.expDate, this.cvv, this.logo});

  factory PaymentCard.fromJson(Map<String, dynamic> json)
  {
    return PaymentCard(
      cardNumber: json['cardNum'],
      expDate: json['expDate'],
      cvv: json['cvv'],
      logo: json['logo'],
    );
  }
}