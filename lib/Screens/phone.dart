import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:nicode/Screens/verifyPhone.dart';
import 'package:nicode/modul/curve.dart';
import 'package:nicode/modul/txtField.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constans.dart';

class phonePage extends StatefulWidget {
  const phonePage({Key? key}) : super(key: key);

  @override
  _phonePageState createState() => _phonePageState();
}

GlobalKey<FormState> _formkey = GlobalKey<FormState>();

var number;
Map data = new Map();

class _phonePageState extends State<phonePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg.withOpacity(1),
      body: SafeArea(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Column(
              children: [
                new Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    new Container(
                      height: 400,
                      child: new CustomPaint(
                        size: Size(double.infinity, double.infinity),
                        painter: CurvedPainterTop(),
                      ),
                    ),
                    new RichText(
                      text: new TextSpan(
                          style: Theme.of(context).textTheme.headline1,
                          children: <TextSpan>[
                            new TextSpan(text: ' لطفا برای'),
                            new TextSpan(
                                text: ' ورود',
                                style: new TextStyle(
                                    color: bl.withOpacity(1),
                                    fontWeight: FontWeight.w600)),
                            new TextSpan(text: ' یا'),
                            new TextSpan(
                              text: ' عضویت ',
                              style: new TextStyle(
                                  color: bl.withOpacity(1),
                                  fontWeight: FontWeight.w600),
                            ),
                            new TextSpan(
                                text: 'شماره همراه خود را وارد نمایید ')
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: new Text('+98'),
                          ),
                          new SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: new Image.asset(
                              'images/flag.jpeg',
                              height: 20,
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          new SizedBox(
                            width: 25,
                          ),
                          Container(
                              height: 70,
                              width: 296,
                              child: Form(
                                key: _formkey,
                                child: new TextFormField(
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  onSaved: (val) {
                                    number = val;
                                    var num = '+98$val';
                                    int mob = int.parse(num);
                                    data['mobile'] = mob;
                                    print(val);
                                  },
                                  cursorColor: gry.withOpacity(1),
                                  maxLength: 10,
                                  textAlign: TextAlign.left,
                                  decoration: new InputDecoration(
                                    hintText: '9.. ... ....',
                                    labelStyle: new TextStyle(
                                        color: gry.withOpacity(1)),
                                    filled: true,
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: (BorderSide(
                                            color: gry.withOpacity(1)))),
                                    focusedBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: (BorderSide(color: gry))),
                                    prefixIcon: Icon(
                                      Icons.phone_android_outlined,
                                      size: 16,
                                      color: gry.withOpacity(1),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            new Flexible(
              child: new Container(
                child: new Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    new CustomPaint(
                      size: Size(double.infinity, 300),
                      painter: new CurvedPainterBottom(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: new AvatarGlow(
                        endRadius: 60,
                        glowColor: wh.withOpacity(1),
                        child: new FloatingActionButton(
                            backgroundColor: wh.withOpacity(1),
                            onPressed: () {
                              _formkey.currentState!.save();
                              var js = jsonEncode(data);
                              sendLogin(mo: js);
                              print(js);
                            },
                            child: new Icon(
                              Icons.navigate_next,
                              color: bl.withOpacity(1),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendLogin({mo}) async {
    var url = Uri.parse('https://appgatewaytech.kargozareman.com/v1/signin');
    var response = await http.post(url,
        headers: {"Content-type": "application/json"}, body: mo);
    var jsonrespons = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => verifyPhone(
                    number: number,
                  )));
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "${jsonrespons['message']}",
        ),
      );
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "${jsonrespons['message']}",
        ),
      );
    }
    print(mo);
    print(response.body);
  }
}
