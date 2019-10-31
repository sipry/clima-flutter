import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'd2ec74669daa08ea565c61d0eafcce82';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    print('getLocationWeather');
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '  🌩';
    } else if (condition < 400) {
      return '  🌧';
    } else if (condition < 600) {
      return '  ☔️';
    } else if (condition < 700) {
      return '  ☃️';
    } else if (condition < 800) {
      return '  🌫';
    } else if (condition == 800) {
      return '  ☀️';
    } else if (condition <= 804) {
      return '  ☁ ';
    } else {
      return '  🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Temperatura alta';
    } else if (temp > 20) {
      return 'Temperatura ambiente';
    } else if (temp < 10) {
      return 'Recuerda llevar tu abrigo 🧥';
    } else {
      return 'Pasa un bonito dia';
    }
  }
}
