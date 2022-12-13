// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import 'package:trainrideapp/pages/history.dart';
import 'package:trainrideapp/pages/home.dart';
import 'package:trainrideapp/pages/people.dart';
import 'package:trainrideapp/pages/selecttrain.dart';
import 'package:trainrideapp/pages/traindetails.dart';



void main() {
  runApp(
    const MaterialApp(
      home: MyHomePage(),
      // debugShowCheckedModeBanner: false,
    ),);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  final items = const [
    Icon(Icons.train, size: 30,),
    Icon(Icons.home,size: 30,),
    Icon(Icons.add, size: 30,),
    Icon(Icons.people, size: 30,),
    Icon(Icons.history, size: 30,),
  ];
  int index = 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              index = 1;
              _incrementCounter();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text(
                "",//user name.
                style: TextStyle(fontSize: 18),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person_outline_rounded),
              onPressed: () {},
            ),

            PopupMenuButton(
                icon: const Icon(Icons.menu),
                onSelected: (value) {
                  switch (value) {
                    case 01:
                      log("Home Selected");
                      index =1;
                      _incrementCounter();
                      break;
                    case 02:
                      log("My Profile Selected");
                      break;
                    case 03:
                      log("Find Train Selected");
                      break;
                    case 04:
                      log("Help & Feedback Selected");
                      break;
                    case 05:
                      log("Settings Selected");
                      break;
                    default:
                      log("Nothing Selected");
                  }

                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 01,
                    child: Text("Home"),
                  ),
                  const PopupMenuItem(
                    value: 02,
                    child: Text("My Profile"),
                  ),
                  const PopupMenuItem(
                    value: 03,
                    child: Text("Find Train"),
                  ),
                  const PopupMenuItem(
                    value: 04,
                    child: Text("Help & Feedback"),
                  ),
                  const PopupMenuItem(
                    value: 05,
                    child: Text("Settings"),
                  ),
                ])
          ],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Train Ride"),
        ),

      backgroundColor: Colors.blue,


      bottomNavigationBar: CurvedNavigationBar( //Bottom navigation bar
        items: items,
        index: index,
        onTap: (selectedIndex){
          setState(() {
            index = selectedIndex;
          });
        },
        height: 60,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        buttonBackgroundColor: Colors.white,
        color: Colors.white,
        // animationCurve: ,
      ),
      body: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}){
    Widget widget;

    switch(index){
      case 0:
        widget = const TrainDetails();//Train Details
        break;
      case 1:
        widget = const Home(); // Home
        break;
      case 2:
        widget = const SelectTrain(); //Select Train
        break;
      case 3:
        widget = const People(); //Help Others
        break;
      case 4:
        widget = const History(); //Train History
        break;

      default:
        widget = const Home(); // Home
        break;
    }
    return widget;
  }

}
