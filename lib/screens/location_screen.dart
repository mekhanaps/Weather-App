import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key, required this.locationWeather}) : super(key: key);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temp;
  late String weatherIcon;
  String? message;
  late String city;
  late String state;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  updateUI(data) {
    setState(() {
      if (data == null) {
        temp = 404;
        weatherIcon = '';
        message = 'ERROR';
        city = '';
        return;
      }
      double temperature = data['main']['temp'];
      temp = temperature.toInt();
      city = data['name'];
      int condition = data['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      message = weather.getMessage(temp);
      state = data['weather'][0]['main'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background1.jfif'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var data = await weather.getLocationWeather();
                      updateUI(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var data = await weather.getCityWeather(typedName);
                        updateUI(data);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                state,
                textAlign: TextAlign.center,
                style: kStateTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  city,
                  textAlign: TextAlign.center,
                  style: kCityTextStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0,
                    child: Text(
                      '°',
                      style: kTempTextStyle,
                    ),
                  ),
                  Text(
                    '$temp°',
                    style: kTempTextStyle,
                  ),
                ],
              ),
              Expanded(child: SizedBox.expand()),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
