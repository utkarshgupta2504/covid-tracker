import 'package:covid_tracker/Components/stat_card.dart';
import 'package:covid_tracker/constants.dart';
import 'package:flutter/material.dart';

class MainStatsPage extends StatefulWidget {
  @override
  _MainStatsPageState createState() => _MainStatsPageState();
}

class _MainStatsPageState extends State<MainStatsPage> {
  String dropdownText = 'India';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF303753),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/Virus_bg.png'),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: DropdownButton(
                    underline: null,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                    value: dropdownText,
                    items: [
                      DropdownMenuItem(
                        child: Text('India'),
                        value: 'India',
                      ),
                      DropdownMenuItem(
                        child: Text('World'),
                        value: 'World',
                      ),
                    ],
                    onChanged: (change) {
                      print(change);
                      setState(() {
                        dropdownText = change;
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StatCard(
                          title: 'Confirmed',
                          value: '3000000',
                          increment: '+25666',
                          textColor: kConfirmedColor,
                        ),
                        StatCard(
                          title: 'Active',
                          value: '3000000',
                          increment: '+25666',
                          textColor: kActiveColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StatCard(
                          title: 'Recovered',
                          value: '3000000',
                          increment: '+25666',
                          textColor: kRecoveredColor,
                        ),
                        StatCard(
                          title: 'Deceased',
                          value: '3000000',
                          increment: '+25666',
                          textColor: kDeceasedColor,
                        ),
                      ],
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
}
