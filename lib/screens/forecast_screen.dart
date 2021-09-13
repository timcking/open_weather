import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:intl/intl.dart';
import 'package:clima/utilities/utility.dart';
import 'package:clima/services/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastScreen extends StatefulWidget {
  ForecastScreen({this.forecastWeather});

  final forecastWeather;

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {

  List<String> listForecast = [];
  List<IconData> listIcons = [];
  List<String> listDateTime = [];

  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    buildForecast(widget.forecastWeather);
  }

  void buildForecast(dynamic forecastData) {
    int count = forecastData['cnt'];

    for (int i = 0; i < count; i++) {

      String forecastString = '';

      // Datetime list
      var epochDate = forecastData['list'][i]['dt'];
      String theDate = formatDate(epochDate);
      listDateTime.add(theDate);

      // Forecast list
      int temp = forecastData['list'][i]['main']['temp'].toInt();
      String temperature = temp.toString();

      int condition = forecastData['list'][i]['weather'][0]['id'];
      String description = forecastData['list'][i]['weather'][0]['main'];

      forecastString = temperature +  '°' + '  ' + description;
      listForecast.add(forecastString);

      // Icon list
      int hour = calcHour(epochDate);
      IconData weatherIcons = weather.getWeatherIcon(condition, hour);
      listIcons.add(weatherIcons);
    }
  }

  String formatDate(epochDate) {
    DateTime localDate = new DateTime.fromMillisecondsSinceEpoch(epochDate * 1000);
    var format = new DateFormat('E MM/dd h a');
    String myDate = format.format(localDate);

    return myDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.indigo
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 40.0,
                  ),
                ),
              ),
              // TCK
              // https://stackoverflow.com/questions/52801201/flutter-renderbox-was-not-laid-out
              SizedBox(height: 10.0),
              Expanded(
                child:  ListView.separated(
                  itemCount: listForecast.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(listIcons[index],
                          size: 60.0,
                      ),
                      title: Align(
                        child: Text(
                          listForecast[index].toString(),
                          style: TextStyle(
                          fontSize: 25.0, // insert your font size here
                          ),
                        ),
                        alignment: Alignment(-0.5, 0),
                      ),
                      subtitle: Align(
                        child: Text(
                          listDateTime[index],
                        ),
                        alignment: Alignment(-0.5, 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
