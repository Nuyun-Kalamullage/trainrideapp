import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectTrain extends StatefulWidget {
  const SelectTrain({super.key});

  @override
  State<SelectTrain> createState() => _SelectTrainState();
}
String? selectedValue ="Nuyun";
final myList = ["Nuyun","Harindu","Sithum","Thameera"];
class _SelectTrainState extends State<SelectTrain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                  "Primary Station"
              ),
            ],
          ),
          DropdownButtonFormField(
            value: selectedValue,
            hint: Text("Primary Station"),
            onChanged: (value) {
              setState(() {
              });
              print(value);
            },
            items: myList.map(
                    (e) {
                      return DropdownMenuItem(child: Text(e),value: e);
                    }
                    ).toList(),

            // items: <String>["Nuyun","Harindu","Sithum","Thameera"],
            // onChanged: onChanged,
          ),
          const Text(
              "Secondary Station"
          ),
          DropdownButtonFormField(
            value: selectedValue,
            hint: const Text("Secondary Station"),
            onChanged: (value) {
              setState(() {
              });
              print(value);
            },
            items: myList.map(
                    (e) {
                  return DropdownMenuItem(child: Text(e),value: e);
                }
            ).toList(),

            // items: <String>["Nuyun","Harindu","Sithum","Thameera"],
            // onChanged: onChanged,
          ),

          const Text(
              "Select the Train"
          ),
          DropdownButtonFormField(
            value: selectedValue,
            hint: const Text("Select the Train"),
            onChanged: (value) {
              setState(() {
              });
              print(value);
            },
            items: myList.map(
                    (e) {
                  return DropdownMenuItem(child: Text(e),value: e);
                }
            ).toList(),

            // items: <String>["Nuyun","Harindu","Sithum","Thameera"],
            // onChanged: onChanged,
          ),
        ],
      ),

    );

    // Padding(
    //   padding: const EdgeInsets.all(24.0),
    //   child: Column(
    //     children: const[
    //       Text('Select Train Page', style: TextStyle(fontSize: 40, color: Colors.blue, fontWeight: FontWeight.bold),),
    //       SizedBox(height: 100,),
    //       CircleAvatar(
    //         radius: 70,
    //         child: Icon(Icons.train, size: 120,),
    //       ),
    //       SizedBox(height: 100,),
    //       Text('Select train Page Content', style: TextStyle(fontSize: 30, color: Colors.blue),),
    //     ],
    //   ),
    // );

  }
}