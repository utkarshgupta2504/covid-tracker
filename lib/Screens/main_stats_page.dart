import 'package:covid_tracker/Components/stat_card.dart';
import 'package:covid_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/Services/corona_stats.dart';

class MainStatsPage extends StatefulWidget {
  @override
  _MainStatsPageState createState() => _MainStatsPageState();
}

class _MainStatsPageState extends State<MainStatsPage> {
  var globalStats;
  var countryStats;

  void populateStats() async {
    var stats = await CoronaStatsModel().getStats();

    setState(() {
      globalStats = stats['Global'];
      countryStats = stats['Countries'];
    });
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
                  child: Text(
                    'World',
                    style: TextStyle(fontSize: 25.0),
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
                        border: null,
                        children: <TableRow>[
                          TableRow(
                            children: [
                              Text(
                                'Country',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kConfirmedColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'A',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kActiveColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'R',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kRecoveredColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'D',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kDeceasedColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
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
