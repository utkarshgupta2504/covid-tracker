import 'networking.dart';

const String url = 'https://api.covid19api.com/summary';

class CoronaStatsModel {
  Future<dynamic> getStats() async {
    NetworkHelper networkHelper = NetworkHelper(url);

    var stats = await networkHelper.getData();

    print(stats);
    return stats;
  }
}
