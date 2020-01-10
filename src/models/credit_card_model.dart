import 'package:flutter/animation.dart';

class CreditCardModel{
  String _cardNo,_expiryDate,_cvv,_logo;
  CreditCardModel(this._cardNo, this._logo, this._expiryDate, this._cvv);


  set cardNumb(String s)
  {
    this._cardNo = s;
  }
  set logos(String s)
  {
    this._logo = s;
  }
  set expire(String s)
  {
    this._expiryDate = s;
  }
  set cvvnum(String s)
  {
    this._cvv = s;
  }

  String get cNum
  {
    return _cardNo;
  }
  String get cardNo
  {
    var letters=[];
    for(int i=0;i<_cardNo.length;)
      {
                 letters.add(_cardNo.substring(i,( ( i ~/4)+1)*4));
         i+=4;
      }
    var fakeCardNo="";
    for(int i=0;i<letters.length;i++)
      {
        if(i==letters.length-1)
          {
            fakeCardNo+=letters[i];
            break;
          }
     fakeCardNo+="****    ";
      }
    return fakeCardNo;
  }


  String get logo => _logo;

  String get cvv => _cvv;

  String get expiryDate => _expiryDate;

}