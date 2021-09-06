import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LocationScreen extends StatefulWidget {
    // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
    LocationScreen({this.locationWeather});

    // ignore: prefer_typing_uninitialized_variables
    final locationWeather;

    @override
    _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
    WeatherModel weatherModel = WeatherModel();
    late int temperature;
    late String temperatureMessage;
    late String weatherIcon;
    String? cityName;

    void updateUi(dynamic weatherData) {
        setState(() {
            if (weatherData == null) {
                temperature = 0;
                weatherIcon = 'Error';
                temperatureMessage = 'Problema ao buscar informação do clima';
                cityName = '';
                return;
            }
            double temp = weatherData['main']['temp'];
            temperature = temp.toInt();
            temperatureMessage = weatherModel.getMessage(temperature);
            weatherIcon =
                    weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
            cityName = 'em ${weatherData['name']}';
        });
    }

    @override
    void initState() {
        super.initState();

        updateUi(widget.locationWeather);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage('images/location_background.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.8),
                            BlendMode.dstATop,
                        ),
                    ),
                ),
                constraints: const BoxConstraints.expand(),
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    TextButton(
                                        onPressed: () async {
                                            var weatherData = await weatherModel.getLocationWeather();
                                            updateUi(weatherData);
                                        },
                                        child: const Icon(
                                            Icons.near_me,
                                            size: 50.0,
                                            color: Colors.white,
                                        ),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                            var typedName = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => CityScreen(),
                                                ),
                                            );

                                            if (typedName != null) {
                                                var weatherData = await weatherModel.getCityWeather(typedName);
                                                updateUi(weatherData);
                                            }
                                        },
                                        child: const Icon(
                                            Icons.location_city,
                                            size: 50.0,
                                            color: Colors.white,
                                        ),
                                    ),
                                ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                    children: <Widget>[
                                        Text(
                                            '$temperatureº',
                                            style: kTempTextStyle,
                                        ),
                                        Text(
                                            weatherIcon,
                                            style: kConditionTextStyle,
                                        )
                                    ],
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                    '$temperatureMessage $cityName',
                                    textAlign: TextAlign.right,
                                    style: kMessageTextStyle,
                                ),
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}
