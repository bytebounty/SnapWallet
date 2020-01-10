import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/main.dart';
import 'package:flutter_wallet_ui_challenge/src/pages/home_page.dart';
import 'package:flutter_wallet_ui_challenge/src/pages/payment_page.dart';
import 'package:flutter_wallet_ui_challenge/src/widgets/color_card.dart';

class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

var contents;

class _NfcScanState extends State<NfcScan> {

  TextEditingController writerController = TextEditingController();

  void initState() {
    super.initState();
    writerController.text = 'Flutter NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      print(onData.content);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    writerController.dispose();
    super.dispose();
  }

  Future _nfcScan()
  async {
    try{
      content = await FlutterNfcReader.read().then((response){
      print(response.content);
      contents = response.content;
      price = contents;
      });
    }
    catch (e)
    {
      price = "1500";
    }
    
  }

  Widget build(BuildContext context) {
    price = "1500";
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
                "NFC Scan Page",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
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
              colorCard("Wallet Balance", walletBalance, 1, context,
                  Color(0xFF1b5bff), 18, 24),
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
                  text: "Please Scan NFC tag",
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
            child: FloatingActionButton.extended(
              onPressed: () {
                paymentNo =5;
                _nfcScan();
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => PaymentPage(),
                ),
                );
              },
              label: Text('Scan'),
              icon: Icon(Icons.account_balance_wallet),
              elevation: 20,
            ),
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