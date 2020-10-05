import 'package:covid_tracker/Components/stat_card.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class CountryStatsScreen extends StatelessWidget {
  CountryStatsScreen({this.stats});

  final stats;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        stats['Country'],
                        style: TextStyle(fontSize: 25.0),
                      ),
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
                          value: (stats != null ? formatNumber(stats['TotalConfirmed']) : '--'),
                          increment: (stats != null ? formatNumber(stats['NewConfirmed']) : '--'),
                          textColor: kConfirmedColor,
                        ),
                        StatCard(
                          title: 'Active',
                          value: (stats != null
                              ? formatNumber(stats['TotalConfirmed'] -
                                  stats['TotalRecovered'] -
                                  stats['TotalDeaths'])
                              : '--'),
                          increment: (stats != null
                              ? formatNumber(stats['NewConfirmed'] -
                                  stats['NewRecovered'] -
                                  stats['NewDeaths'])
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
                          value: (stats != null ? formatNumber(stats['TotalRecovered']) : '--'),
                          increment: (stats != null ? formatNumber(stats['NewRecovered']) : '--'),
                          textColor: kRecoveredColor,
                        ),
                        StatCard(
                          title: 'Deceased',
                          value: (stats != null ? formatNumber(stats['TotalDeaths']) : '--'),
                          increment: (stats != null ? formatNumber(stats['NewDeaths']) : '--'),
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
