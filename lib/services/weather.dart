import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '051a103367cc7eac59fc0b4686e138d3';
const openWeatherMapUrl = 'api.openweathermap.org';

class WeatherModel {
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
            return 'É dia para 🍦';
        } else if (temp > 20) {
            return 'É dia para um shorts e 👕';
        } else if (temp < 10) {
            return 'Você irá precisar de um 🧣 e 🧤';
        } else {
            return 'Traga um 🧥 só por precaução';
        }
    }

    Future<dynamic> getLocationWeather() async {
        Location location = Location();
        await location.getCurrentLocation();

        NetworkHelper networkHelper = NetworkHelper(
            url: Uri.https(
                openWeatherMapUrl,
                'data/2.5/weather',
                {
                    'lat': location.latitude.toString(),
                    'lon': location.longitude.toString(),
                    'appid': apiKey,
                    'units': 'metric'
                },
            ),
        );

        return await networkHelper.getData();
    }

    Future<dynamic> getCityWeather(String cityName) async {
        NetworkHelper networkHelper = NetworkHelper(
            url: Uri.https(
                openWeatherMapUrl,
                'data/2.5/weather',
                {
                    'q': cityName,
                    'appid': apiKey,
                    'units': 'metric'
                },
            ),
        );

        return await networkHelper.getData();
    }
}
