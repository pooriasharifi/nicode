import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:nicode/constans.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<dynamic> items = [];
  bool loading = true;
  var ph;
  // late fetchItem pro;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(body: _BuildBody());
  }

  void fetchData() async {
    var url = Uri.parse(
        'https://appgatewaytech.kargozareman.com/v1/crowds/proposals/approved');
    var response =
        await http.get(url, headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map<String, dynamic> jsonRespons =
          jsonDecode(utf8.decode(response.bodyBytes));

      items = await jsonRespons["data"];
      ph = items[0]['gallery'][0];
      print(items[0]["title"]);
      setState(() {
        loading = false;
      });
    } else {
      setState(() {});
    }
  }

  Widget _BuildBody() {
    if (loading) {
      return new Center(
        child: new SpinKitCubeGrid(
          color: bl.withOpacity(1),
          size: 60,
        ),
      );
    }
    return new SafeArea(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: [
            new SizedBox(
              height: 15,
            ),
            Center(
              child: new Text(
                '${items[0]['title']}',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
            new Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              elevation: 4,
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      height: 250,
                      width: 470,
                      child: Image.network(
                        items[0]['gallery'][0],
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new RichText(
                    text: new TextSpan(
                        style: Theme.of(context).textTheme.headline1,
                        children: <TextSpan>[
                          new TextSpan(
                              text:
                                  '${items[0]['amountRequired'].toString().seRagham(separator: ",")}',
                              style: Theme.of(context).textTheme.headline2),
                          new TextSpan(text: ' تومان'),
                        ]),
                  ),
                  new Text(
                    '${items[0]['userAccount']['firstName']} ${items[0]['userAccount']['lastName']}',
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
            new SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      height: 150,
                      width: 200,
                      child: new Card(
                        color: Color(0XE6F1FB).withOpacity(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        elevation: 4,
                        child: new Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.airline_seat_individual_suite_sharp,
                                color: bl.withOpacity(1),
                                size: 30,
                              ),
                              new SizedBox(
                                height: 5,
                              ),
                              new Text(
                                'سرمایه گذاری تا الان',
                                style: TextStyle(
                                    fontFamily: 'vazir',
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              new SizedBox(
                                height: 5,
                              ),
                              new Text(
                                '${items[0]['payedAmounts'].toString().seRagham(separator: ",")}',
                                style: Theme.of(context).textTheme.headline1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      height: 150,
                      width: 200,
                      child: new Card(
                        color: Color(0XE6F1FB).withOpacity(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        elevation: 4,
                        child: new Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.person,
                                color: bl.withOpacity(1),
                                size: 30,
                              ),
                              new SizedBox(
                                height: 5,
                              ),
                              new Text(
                                'تعداد سرمایه گذار',
                                style: TextStyle(
                                    fontFamily: 'vazir',
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              new SizedBox(
                                height: 5,
                              ),
                              new Text(
                                '${items[0]['investorsCount']}',
                                style: Theme.of(context).textTheme.headline1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      height: 150,
                      width: 200,
                      child: new Card(
                        color: Color(0XE6F1FB).withOpacity(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        elevation: 4,
                        child: new Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.timer,
                                color: bl.withOpacity(1),
                                size: 30,
                              ),
                              new SizedBox(
                                height: 5,
                              ),
                              new Text(
                                'زمان باقی مانده',
                                style: TextStyle(
                                    fontFamily: 'vazir',
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              new SizedBox(
                                height: 5,
                              ),
                              new Text(
                                '  روز30',
                                style: Theme.of(context).textTheme.headline1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
