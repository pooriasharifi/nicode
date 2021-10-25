import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:nicode/Screens/phone.dart';
import 'package:nicode/modul/curve.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../constans.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;

class verifyPhone extends StatefulWidget {
  const verifyPhone({Key? key, this.number}) : super(key: key);
  final number;
  @override
  _verifyPhoneState createState() => _verifyPhoneState();
}

class _verifyPhoneState extends State<verifyPhone> {
  GlobalKey<FormState> _formkeyTimer = GlobalKey<FormState>();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 116;
  late CountdownTimerController controller;
  Map verifyNumber = new Map();
  @override
  void initState() {
    super.initState();
    // timer();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new SafeArea(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Stack(
            alignment: Alignment.center,
            children: [
              new Container(
                height: 400,
                child: new CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: CurvedPainterTop(),
                ),
              ),
              new Column(
                children: [
                  new SizedBox(
                    height: 100,
                  ),
                  new Text(
                    'تایید شماره همراه',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  new SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: new RichText(
                      text: new TextSpan(
                          style: Theme.of(context).textTheme.headline1,
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'کد چهاررقمی ارسال شده به شماره'),
                            new TextSpan(
                                text: ' ${widget.number}',
                                style: new TextStyle(
                                    color: bl.withOpacity(1),
                                    fontWeight: FontWeight.w600)),
                            new TextSpan(text: ' را وارد کنید'),
                          ]),
                    ),
                  ),
                  new SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Form(
                      key: _formkeyTimer,
                      child: PinPut(
                        fieldsCount: 4,
                        withCursor: true,
                        fieldsAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        eachFieldMargin: EdgeInsets.symmetric(horizontal: 5),
                        autofocus: true,
                        followingFieldDecoration: BoxDecoration(
                          border: Border.all(color: bla.withOpacity(1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        selectedFieldDecoration: BoxDecoration(
                          border: Border.all(color: bla.withOpacity(1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onSaved: (val) {
                          verifyNumber['activeCode'] = val;
                          verifyNumber['mobile'] = widget.number;
                          print(verifyNumber);
                        },
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  new CountdownTimer(
                    controller: controller,
                    endTime: endTime,
                    onEnd: onEnd,
                    textStyle: Theme.of(context).textTheme.headline2,
                  ),
                  new Text(
                    'فرصت باقی مانده',
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
              )
            ],
          ),
          new AvatarGlow(
            endRadius: 60,
            glowColor: wh.withOpacity(1),
            child: new FloatingActionButton(
                backgroundColor: wh.withOpacity(1),
                onPressed: () {
                  _formkeyTimer.currentState!.save();

                  var js = jsonEncode(verifyNumber);

                  sendCode(code: js);
                  print(js);
                },
                child: new Icon(
                  Icons.navigate_next,
                  color: bl.withOpacity(1),
                )),
          ),
        ],
      )),
    );
  }

  void onEnd() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => phonePage()));
  }

  void sendCode({code}) async {
    var url = Uri.parse(
        'https://appgatewaytech.kargozareman.com/v1/signin/verification');
    var response = await http.post(url,
        headers: {"Content-type": "application/json"}, body: code);

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => menu()));
    } else {}
    print(code);
    print(response.body);
    print(response.statusCode);
    ;
  }
}
