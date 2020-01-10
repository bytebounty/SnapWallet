import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui_challenge/main.dart';
import 'package:flutter_wallet_ui_challenge/src/api_service.dart';
import 'package:flutter_wallet_ui_challenge/src/pages/home_page.dart';
import 'package:flutter_wallet_ui_challenge/src/signup.dart';

class Urls
{
  static const Base_API_URL = "https://jsonplaceholder.typicode.com";
}
bool login = false;
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  TextEditingController _userNameCOntroller = new TextEditingController();
  TextEditingController _passwordCOntroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                          controller: _userNameCOntroller,
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                      controller: _passwordCOntroller,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Varela',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    isLoading? CircularProgressIndicator() : Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final users = await ApiService.getUserList();
                            if (users == null)
                            {
                              showDialog(
                                context: context,
                                builder: (context)
                                {
                                  return AlertDialog(
                                    title: Text('Error Logging In'),
                                    content: Text('An Error Occured While Trying to Login! Please Try Again.'),
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
                            }
                            else
                            {
                              final userWithUserNameExist = users.any((u) => u['email'] == _userNameCOntroller.text);
                              final userWithPasswordExist = users.any((u) => u['username'] == _passwordCOntroller.text);
                              if(userWithUserNameExist && userWithPasswordExist)
                              {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                                login = true;
                                writeStatus("yes");
                              }
                              else
                              {
                                showDialog(
                                context: context,
                                builder: (context)
                                {
                                  
                                  isLoading = false;
                                  return AlertDialog(
                                    title: Text('Error Logging In'),
                                    content: Text('Please Check Username and Password'),
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
                              }
                            }
                            
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Varela'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child:
                                  Icon(Icons.favorite_border),
                            ),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text('Log in with facebook',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Varela')),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to SnapWallet ?',
                  style: TextStyle(fontFamily: 'Varela'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
