import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    var data = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: data);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100,
      ),
    ));
  }
}
