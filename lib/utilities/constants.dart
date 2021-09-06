import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
        fontFamily: 'Spartan MB', fontSize: 100.0, fontWeight: FontWeight.bold);

const kMessageTextStyle = TextStyle(
        fontFamily: 'Spartan MB', fontSize: 60.0, fontWeight: FontWeight.bold);

const kButtonTextStyle = TextStyle(
        fontSize: 30.0,
        fontFamily: 'Spartan MB',
        color: Colors.white,
        fontWeight: FontWeight.bold);

const kConditionTextStyle = TextStyle(
    fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
        Icons.location_city,
        color: Colors.white,
    ),
    hintText: 'Nome da cidade',
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0),
        ),
        borderSide: BorderSide.none,
    ),
);
