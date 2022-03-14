import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = 'ba5076dc10c9f7f90566f16f6d087ef5';
const weatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  getCityWeather(city) async {
    Network network =
        Network(url: '$weatherURL?q=$city&appid=$apiKey&units=metric');
    var data = await network.getData();
    return data;
  }

  getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Network network = Network(
        url:
            '$weatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var data = await network.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
