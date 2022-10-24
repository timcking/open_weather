import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/forecast_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:clima/utilities/utility.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String temperature;
  IconData weatherIcon;
  String cityName;
  String weatherMessage;
  String description;

  List<String> listName = [];
  List<String> listValue = [];

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    String humidity;
    String feelsLike;
    String minTemp;
    String maxTemp;
    int sunrise;
    int sunset;

    listName.clear();
    listValue.clear();

    setState(() {
      if (weatherData == null) {
        temperature = '';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      temperature = weatherData['main']['temp'].round().toString();

      var condition = weatherData['weather'][0]['id'];
      description = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];

      humidity = weatherData['main']['humidity'].toString();
      feelsLike = weatherData['main']['feels_like'].round().toString();
      minTemp = weatherData['main']['temp_min'].round().toString();
      maxTemp = weatherData['main']['temp_max'].round().toString();

      sunrise = weatherData['sys']['sunrise'];
      String sunriseTime = convertTime(sunrise);

      sunset = weatherData['sys']['sunset'];
      String sunsetTime = convertTime(sunset);

      listName.add('Feels Like');
      listName.add('Low');
      listName.add('High');
      listName.add('Humidity');
      listName.add('Sunrise');
      listName.add('Sunset');

      listValue.add(feelsLike + '°');
      listValue.add(minTemp + '°');
      listValue.add(maxTemp + '°');
      listValue.add(humidity + '%');
      listValue.add(sunriseTime.toLowerCase());
      listValue.add(sunsetTime.toLowerCase());

      var epochDate = weatherData['dt'];
      int hour = calcHour(epochDate);

      weatherIcon = weather.getWeatherIcon(condition, hour);
    });
  }

  void getForecastData() async {
    var forecastData = await WeatherModel().getCityForecast(cityName);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ForecastScreen(forecastWeather: forecastData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    style: kButtonStyle,
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.refresh,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    style: kButtonStyle,
                    onPressed: () {
                      getForecastData();
                    },
                    child: Icon(
                      // Icons.wb_sunny,
                      Icons.sunny,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    style: kButtonStyle,
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$temperature°',
                    textAlign: TextAlign.center,
                    style: kTempTextStyle,
                  ),
                  SizedBox(width: 10.0),
                  BoxedIcon(
                    weatherIcon,
                    size: 70.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                '$cityName',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 40),
              ),
              SizedBox(height: 20.0),
              Text(
                '$description',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 30),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: listName.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      visualDensity: VisualDensity(vertical: -3),
                      onTap: () {},
                      title: Align(
                          child: Text(listName[index],
                              style: const TextStyle(
                                fontSize: 26.0,
                              )),
                          alignment: Alignment.centerLeft),
                      trailing: Text(listValue[index].toString(),
                          style: const TextStyle(
                              color: Colors.yellow, fontSize: 26.0)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
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
