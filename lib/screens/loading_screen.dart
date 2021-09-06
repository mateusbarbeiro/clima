import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: use_key_in_widget_constructors
class LoadingScreen extends StatefulWidget {
    @override
    State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
    @override
    void initState() {
        super.initState();
        getLocationData();
    }

    void getLocationData() async {
        var weatherData = await WeatherModel().getLocationWeather();
        
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocationScreen(
                    locationWeather: weatherData,
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return const Scaffold(
            body: Center(
                child: SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 100.0,
                ),
            ),
        );
    }
}
