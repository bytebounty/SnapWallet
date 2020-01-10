import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/src/nfc_pay.dart';
import 'package:flutter_wallet_ui_challenge/src/pages/overview_page.dart';
import '../qr_scan.dart';
import '../nfc_pay.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      alignment: Alignment.center,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.shade50,
            blurRadius: 8.0,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('\t\t\t\t\t\t\t\t\t'),
              Column(children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.nfc,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NfcScan()));
                  },
                  iconSize: 40.0,
                ),
                Text(
                  "NFC Tapping",
                  style: TextStyle(
                      inherit: true,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
              ]),
              Text('\t\t\t\t\t\t\t\t\t\t\t'),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.apps,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    iconSize: 40.0,
                  ),
                  Text(
                    "Scan QR Code",
                    style: TextStyle(
                        inherit: true,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text('\t\t\t\t\t\t\t\t\t\t\t'),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OverviewPage()));
                    },
                    iconSize: 40.0,
                  ),
                  Text(
                    "Overview",
                    style: TextStyle(
                        inherit: true,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text('\t\t\t\t\t\t\t\t'),
            ],
          )
        ],
      ),
    );
  }
}
