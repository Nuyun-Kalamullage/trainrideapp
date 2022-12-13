import 'package:flutter/material.dart';

class TrainDetails extends StatelessWidget {
  const TrainDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const[
          Text('Train Details Page', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          CircleAvatar(
            radius: 70,
            child: Icon(Icons.directions_train, size: 120,),
          ),
          SizedBox(height: 100,),
          Text('Train Details Page Content', style: TextStyle(fontSize: 30, color: Colors.white),),
        ],
      ),
    );
  }
}