import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/main.dart';
import 'package:flutter_wallet_ui_challenge/src/pages/home_page.dart';
import 'package:flutter_wallet_ui_challenge/src/widgets/color_card.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import './recharge_wallet.dart';

class PaymentPage extends StatefulWidget {
  @override
  PaymentPageState createState() => PaymentPageState();
}

enum Formtype{
    menu,
}

class PaymentPageState extends State<PaymentPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  int spent = int.parse(totalAmount)+int.parse(price);
  bool lowBalance = false;
  bool isPressed = false;
  final myController = TextEditingController();
  String newAmount = price;
  
  static String amount = walletBalance;
  Future isBalanceLow() async
  {
    var tempNum = int.parse(walletBalance);
    var tempPrice = int.parse(price);
    if(tempNum < tempPrice)
    {
      lowBalance = true;
    }
  }
  void updateAmount()
  {
    setState(() async {
      var num = int.parse(amount) - int.parse(newAmount);
      amount = num.toString();
      walletBalance=amount;
      totalAmount = spent.toString();
      writeBalance(walletBalance);
      writeTrans(totalAmount);
    });
  }
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
    } 
    on PlatformException catch (e) {
      print(e);
    }
  
    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
        updateAmount();
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  final formkey=new GlobalKey<FormState>();
  Formtype formtype=Formtype.menu;
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
  }
  void initState()
  {
    super.initState();
    print(price);
  }
  Widget build(BuildContext context) {
    isBalanceLow();
    if(lowBalance == true)
    {
      return AlertDialog(
        title: Text('Low Balance'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please Recharge'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Recharge'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => RechargePage()));
            },
          ),
        ],
      );
    }
    else
    {
      return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          top: 70,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Payment Page",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => HomePage()));
            },
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
          Row(
            children: <Widget>[
              colorCard("Wallet Balance", walletBalance, 1, context, Color(0xFF1b5bff),18,24),
            ],
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
                  text: "Amount : " + price,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Varela",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
          child : FloatingActionButton.extended(
            onPressed: () {
              _authorizeNow();
              isPressed = true;
              showDialog(
                context: context,
                builder: (context)
                {
                  return AlertDialog(
                  title: Text('Payment Successfull'),
                  content: Icon(Icons.done_outline),
                  elevation: 50,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Back to Home'),
                        onPressed: ()
                        {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => HomePage()));
                        },
                      )
                    ],
                  );
                },
              barrierDismissible: false,
            );
        },
            label:Text('Pay'),
            icon: Icon(Icons.account_balance_wallet),
            elevation: 20,
          ),
            visible: isPressed ? false : true,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
    }
    
}