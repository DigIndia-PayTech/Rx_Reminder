import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Landing extends StatefulWidget {
  const Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  var data;

  getData() async {
    Uri url =
    Uri.parse("https://expressrechargestore.co.in/Test/transaction_info");
    var response = await http.get(url);
    data = jsonDecode(response.body)[0]["data"];
    print("Data:$data");
    return data;
  }

  parseTime(String temp) {
    var split = temp.split(":");
    String unParsedTime = temp; //split[1];
    int hh = int.parse(split[0]);
    String time;
    if (hh > 11) {
      if (hh == 12) {
        time = "$unParsedTime PM";
      }
    else {
      time = "${hh - 12}:${unParsedTime.substring(3, 5)} PM";
    }
  } else {
    time = "$unParsedTime AM";
    }
    return
    time;
  }

  dataCard(data) {
    String status = data["status"];
    status = status.toLowerCase();
    status = status[0].toUpperCase() + status.substring(1).toLowerCase();
    var temp = data["timestamp"].toString().split(" ");
    String time = parseTime(temp[1].substring(0, 5));
    String number = "${data["recharge_number"]}";
    String operator = "${data["operator_name"]}";

    return InkWell(
      onTap: () {
        print("Type:${data["service_type"]}");
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 5),
            ],
            color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Icon(
                    data["service_type"] == "prepaid"
                        ? Icons.wifi_tethering_outlined
                        : Icons.settings_input_antenna,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data["service_type"]} Recharge of",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(number,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    Text(operator,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w700))
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      status == "Success" ? Colors.green : Colors.deepOrange,
                      status == "Success"
                          ? Colors.lightGreenAccent
                          : Colors.orangeAccent
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Icon(
                    status == "Success" ? Icons.done : Icons.close,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: status == "Success" ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
          appBar: AppBar(
            title: Text("History"),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: FutureBuilder(
            future: getData(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: snapShot.data.length,
                  itemBuilder: (context, index) {
                    return dataCard(snapShot.data[index]);
                  },
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),]
      ),
    );
  }
}
