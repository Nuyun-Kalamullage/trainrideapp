import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:trainrideapp/components/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

const LatLng sourceLocation = LatLng(6.911085, 79.848371);
const LatLng destination = LatLng(5.951821, 80.543526);
const LatLng destination1 = LatLng(6.729222, 80.012193);

LocationData? currentLocation;
class _HomeState extends State<Home> {

  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor myLocationIcon = BitmapDescriptor.defaultMarker ;



  getCurrentLocation() async{
    Location location = Location();
    location.getLocation().then(
          (location){
        if(currentLocation != location){
          setState((){});
        }
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newLoc){
      currentLocation = newLoc;
      googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: 11,
                  target: LatLng(
                    newLoc.latitude!,
                    newLoc.longitude!,
                  )
              )
          )
      );
      setState((){});
    }
    );
  }
  void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(

        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode:TravelMode.walking,
    );

    if (result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      if (kDebugMode) {
        print("GET POLY POINTS NOT EMPTY");
      }
      setState(() {});
    }
  }

  Future<void> setCustomMarkerIcon() async {
    // BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,"assets/mypin.png").then(
    //     (icon) {
    //       myLocationIcon = icon;
    //     }
    // );
    final Uint8List markerIcon = await getBytesFromAsset('assets/profile.png', 100);
    myLocationIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  @override
  void initState(){
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null ) {
      return ElevatedButton(
        onPressed: (){
          setState(() {});
        },
        child: const Text("Loading the map"),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 330,
            child:
            Column(
              children: [
                Container(
                  height: 200,
                  width: 325,
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:270,
                        child: Card(
                          elevation: 4.0,
                          color: const Color.fromARGB(255, 33, 149, 241),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(width: 3, color: Color.fromARGB(255, 80, 90, 95)),

                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              const Text("Remaining Time",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[Shadow(color: Colors.white,blurRadius: 2,offset: Offset(0,0))],
                                ),

                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateFormat('hh:mm').format(DateTime.now(),),//Have to add remaining time here as a DateTime.
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[Shadow(color: Colors.white,blurRadius: 2,offset: Offset(0,0))],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(side: const BorderSide(color: Color.fromARGB(
                                    255, 80, 90, 95),width: 2),elevation: 5,
                                    shape:const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    minimumSize: const Size(120, 40)),
                                onPressed: (){},
                                child: const Text("End Tour",
                                  style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  // shadows: <Shadow>[Shadow(color: Colors.white,blurRadius: 2,offset: Offset(0,0))],
                                ),) ,
                              )
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(side: const BorderSide(color: Color.fromARGB(
                            255, 80, 90, 95),width: 2),elevation: 5,
                            shape:const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            minimumSize: const Size(40, 40)),
                        onPressed: (){},
                        child: const Icon(Icons.delete) ,
                      )
                    ],
                  ),

                ),
                Container(
                  // height: 80,
                    padding:const EdgeInsets.only(
                      top: 90,
                    ),
                    child: const Text("My Location",style: TextStyle(fontSize: 28, color: Colors.white, shadows: <Shadow>[Shadow(color:Color.fromARGB(255, 80, 90, 95),blurRadius: 15,offset: Offset(2,0))], fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),

          SizedBox(
            //width: MediaQuery.of(context).size.width, // or use fixed size like 200
            height: 250,
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 80, 90, 95),width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(28)),

                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                    zoom: 15,
                  ),
                  polylines: {
                    Polyline(
                      polylineId: PolylineId("route"),
                      // points: [sourceLocation, destination, destination1],
                      points: polylineCoordinates,
                      visible:true,
                      color: primaryColor,
                      width: 6,
                    )
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                      icon: myLocationIcon,
                      infoWindow: InfoWindow(title: "Nuyun",snippet: "Your CurrentLocation",onTap:(){ } ),
                    ),

                    const Marker(
                      markerId: MarkerId("source"),
                      position: sourceLocation,
                    ),

                    const Marker(markerId: MarkerId("destination"),
                      position: destination,
                    ),

                  },
                  onMapCreated:(mapController){
                    _controller.complete(mapController);
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

}
