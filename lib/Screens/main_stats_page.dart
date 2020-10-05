import 'package:covid_tracker/Components/stat_card.dart';
import 'package:covid_tracker/Screens/country_stats_screen.dart';
import 'package:covid_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/Services/corona_stats.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class MainStatsPage extends StatefulWidget {
  @override
  _MainStatsPageState createState() => _MainStatsPageState();
}

class _MainStatsPageState extends State<MainStatsPage> {
  var globalStats;
  var countryStats;

  List<TableRow> countryTableList = [
    TableRow(
      children: [
        TableColumnHeaderCell(
          value: 'Country',
        ),
        TableColumnHeaderCell(
          value: 'C',
          color: kConfirmedColor,
        ),
        TableColumnHeaderCell(
          value: 'A',
          color: kActiveColor,
        ),
        TableColumnHeaderCell(
          value: 'R',
          color: kRecoveredColor,
        ),
        TableColumnHeaderCell(
          value: 'D',
          color: kDeceasedColor,
        ),
      ],
    ),
  ];

  void populateStats() async {
    var stats = await CoronaStatsModel().getStats();

    setState(() {
      globalStats = stats['Global'];
      countryStats = stats['Countries'];

      countryStats
          .map((countryStat) => TableRow(
                children: [
                  GestureDetector(
                    child: TableRowHeaderCell(
                      value: countryStat['Country'],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryStatsScreen(
                                    stats: countryStat,
                                  )));
                    },
                  ),
                  TableCell(
                    value: countryStat['TotalConfirmed'],
                  ),
                  TableCell(
                    value: countryStat['TotalConfirmed'] -
                        countryStat['TotalRecovered'] -
                        countryStat['TotalDeaths'],
                  ),
                  TableCell(
                    value: countryStat['TotalRecovered'],
                  ),
                  TableCell(
                    value: countryStat['TotalDeaths'],
                  ),
                ],
              ))
          .toList()
          .forEach((item) => countryTableList.add(item));
    });

    print(countryTableList);
  }

  @override
  void initState() {
    super.initState();

    populateStats();
  }

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'World',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Text('Click on a country to expand stats'),
                    ],
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
                          value: (globalStats != null
                              ? formatNumber(globalStats['TotalConfirmed'])
                              : '--'),
                          increment: (globalStats != null
                              ? formatNumber(globalStats['NewConfirmed'])
                              : '--'),
                          textColor: kConfirmedColor,
                        ),
                        StatCard(
                          title: 'Active',
                          value: (globalStats != null
                              ? formatNumber(globalStats['TotalConfirmed'] -
                                  globalStats['TotalRecovered'] -
                                  globalStats['TotalDeaths'])
                              : '--'),
                          increment: (globalStats != null
                              ? formatNumber(globalStats['NewConfirmed'] -
                                  globalStats['NewRecovered'] -
                                  globalStats['NewDeaths'])
                              : '--'),
                          textColor: kActiveColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StatCard(
                          title: 'Recovered',
                          value: (globalStats != null
                              ? formatNumber(globalStats['TotalRecovered'])
                              : '--'),
                          increment: (globalStats != null
                              ? formatNumber(globalStats['NewRecovered'])
                              : '--'),
                          textColor: kRecoveredColor,
                        ),
                        StatCard(
                          title: 'Deceased',
                          value: (globalStats != null
                              ? formatNumber(globalStats['TotalDeaths'])
                              : '--'),
                          increment:
                              (globalStats != null ? formatNumber(globalStats['NewDeaths']) : '--'),
                          textColor: kDeceasedColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(2),
                        },
                        border: TableBorder.all(
                          width: 4.0,
                          color: Color(0xFF303753),
                          style: BorderStyle.none,
                        ),
                        children: countryTableList,
                      ),
                    )
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

class TableColumnHeaderCell extends StatelessWidget {
  TableColumnHeaderCell({this.value, this.color = Colors.white});

  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Color(0x22CCCCCC),
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class TableRowHeaderCell extends StatelessWidget {
  TableRowHeaderCell({this.value, this.color = Colors.white});

  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Color(0x22CCCCCC),
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  TableCell({this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Color(0x11CCCCCC),
        ),
        child: Text(
          NumberFormat.compact().format(value).toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
