import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/src/pages/home_page.dart';
import 'package:flutter_wallet_ui_challenge/src/widgets/color_card.dart';
import 'package:flutter_wallet_ui_challenge/main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';


class RechargePage extends StatefulWidget {
  @override
  RechargePageState createState() => RechargePageState();
}

enum Formtype{
    menu,
}

class RechargePageState extends State<RechargePage> {

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  String newAmount = "";
  Future updateAmount() async
  {
    String amount = await readBalance();
    if (amount == "")
    {
      amount = "0";
    }
    print("balance = " + walletBalance);
    setState(() {
      var num = int.parse(amount) + int.parse(newAmount);
      amount = num.toString();
      walletBalance = amount;
      writeBalance(walletBalance);
    });
  }
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
  }

  //authenticate the reload process
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
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  final formkey=new GlobalKey<FormState>();
  Formtype formtype=Formtype.menu;

  Widget build(BuildContext context) {
    
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
                "Recharge Page",
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
                  text: "Enter Amount",
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
          SafeArea(
            child: Container(
                  alignment: Alignment.topRight,
                  height: 80,
                  width: 80,
                  child: TextField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  onSubmitted: (String str)
                  {
                    setState(() {
                      newAmount=str;
                    });
                  },
                  controller: myController,
                ),
                ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              await _authorizeNow();
              updateAmount();
              myController.text="";

        },
            label:Text('Fill the Wallet'),
            icon: Icon(Icons.account_balance_wallet),
            elevation: 20,
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