import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/src/data/data.dart';
import 'package:flutter_wallet_ui_challenge/src/widgets/credit_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_wallet_ui_challenge/src/models/credit_card_model.dart';
import '../widgets/credit_card.dart';
import 'package:flutter_wallet_ui_challenge/main.dart';
import 'package:local_auth/local_auth.dart';
 
class AddCardPage extends StatefulWidget {
  @override
  AddCardPageState createState() => AddCardPageState();
}

enum Formtype {
  menu,
}

class AddCardPageState extends State<AddCardPage> {

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorizedOrNot = "Not Authorized";
  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  final formkey = new GlobalKey<FormState>();
  Formtype formtype = Formtype.menu;


  File pickedImage;
  bool isImageLoaded = false;
  CreditCardModel card1;
  static int id;
  String encryptedCardNumber = "";
  CreditCardModel card2 = new CreditCardModel("", "", "", "");

  Future encrypt() async
  {
    String cardNumber = card2.cNum;
    for(int i = cardNumber.length - 1; i >= 0; i--)
    {
      encryptedCardNumber += cardNumber[i];
    }
  }

  Future pickImage() async
  {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    if (mounted)
    {
      setState(() {
        pickedImage = tempStore;
        isImageLoaded = true;
      });
    }
    readText();
  }

  Future getCards() async{
    creditCards = await getCreditCards();
  }

  Future readText() async{
    String info;
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    info = readText.text;
    String text1;
    String txt;
    for(TextBlock block in readText.blocks)
    {
      for(TextLine line in block.lines)
      {
        txt = line.text;
        for(TextElement word in line.elements)
        {
          text1 = word.text;
        }
      }
    }
    //print(info);
    bool cardNumFound = false;
    bool expDateFound = false;
    for(var i = 0; i < info.length ; i++)
    {
      if(!cardNumFound)
      {
        if(info[i] == '4' || info[i] == '5')
        {
          card2.cardNumb=info.substring(i,i+19);
          cardNumFound = true;
        }
      }
      if(!expDateFound)
      {
        if(info[i] == '/')
        {
          if((info[i+1]== "0") || (info[i+1]== "1") ||(info[i+1]== "2") || (info[i+1]== "3")||(info[i+1]== "4") || (info[i+1]== "5")
          ||(info[i+1]== "6") || (info[i+1]== "7")||(info[i+1]== "8") || (info[i+1]== "9"))
          {
            card2.expire = info[i-2] + info[i-1] + info[i] + info[i+1] + info[i+2];
            expDateFound = true;
          }
        }
      }
    }
    card2.logos="https://resources.mynewsdesk.com/image/upload/ojf8ed4taaxccncp6pcp.png";
    card2.cvvnum = "443";
    encrypt();
    //print(card2.cNum);
    //print(card2.expiryDate);
    //print("encrypted card number = " + encryptedCardNumber);
    writecards(card2.cNum +"," + card2.expiryDate + "," + "433");
    await readCards();
    await getCreditCards();
    setState(() {
        if(creditCards[0].cNum == "****************")
        {
          creditCards.removeAt(0);
        }
        //creditCards.add(card2);
        //getCreditCards();
      });
  }
  

  @override
  void initState()
  {
    super.initState();
    //loadVault();
    //decode();
  }

  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 15,
          top: 70,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Add A payment Card",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Back",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),

            ],
          ),

          SizedBox(
            height: 25,
          ),
          Text(
            "SnapWallet",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              inherit: true,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 30,
          ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
            left: 5,
          ),
          height: _media.longestSide <= 775
              ? _media.height / 4
              : _media.height / 4.3,
          width: _media.width,
          child:
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: creditCards.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                              onLongPress: () async {
                                await _authorizeNow();
                                creditCards.removeLast();
                                setState(() async {
                                  await getCreditCards();
                                });
                                showDialog(
                                context: context,
                                builder: (context)
                                {
                                  return AlertDialog(
                                    title: Text('Success'),
                                    content: Text('Card Deleted Successfully'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                }
                              );
                              },
                              child: CreditCard(
                                card: creditCards[index],
                              ),
                            ),
                );
              },
            ),
          ),
        ),
      ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Tap to Scan a Card",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Varela",

                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            onPressed: ()
            {
              pickImage();
            },
            child: Icon(Icons.credit_card),
            elevation: 20,
          )
        ],
      ),
    );
  }
}