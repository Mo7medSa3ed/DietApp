import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/checout.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class MapScrean extends StatefulWidget {
  @override
  _MapScreanState createState() => _MapScreanState();
}

class _MapScreanState extends State<MapScrean> {
   final scaffoldkey =GlobalKey<ScaffoldState>(); 
  Position location;
  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    getCurrantLocation();
  }

  getCurrantLocation() async {
    await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        Geolocator.getCurrentPosition().then((value) {
          setState(() {
            location = value;
          });
        });
      } else {
        buildDialogforNotification(
            context: context,
            test: false,
            text: "Allow your Location",
            desc: "we will need your location to give you better experience.",
            img: "location.png",
            conTap: () {
              Geolocator.requestPermission().then((value) {
                if (value == LocationPermission.always ||
                    value == LocationPermission.whileInUse) {
                  Geolocator.getCurrentPosition().then((value) {
                    setState(() {
                      location = value;
                    });
                  });
                } else {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => CheckoutScrean()));
                }
              });
            },
            backTap: () {
              Navigator.of(context).pop();
            },
            conText: "Sure, I'd Like that",
            backText: "Not now");
      }
    });
  }

  Set<Marker> setMarker() {
    Set<Marker> marker = {};
    return marker
      ..clear()
      ..add(Marker(
        markerId: MarkerId(Random().nextDouble().toString()),
        position: LatLng(location.latitude, location.longitude),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        drawer: buildDrawer(context),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              buildAppBarForPages(context, "Address", ()=>scaffoldkey.currentState.openDrawer(),),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        child: Container(
                          child: location != null
                              ? GoogleMap(
                                  //myLocationEnabled: true,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController = controller;
                                    setMarker();
                                  },
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(location.latitude,
                                          location.longitude),
                                      zoom: 16.0),
                                  markers: setMarker(),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: kprimary2,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 40,
                        right: 40,
                        top: 20,
                        child: location != null
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                          color: ksecondary.withOpacity(0.5),
                                          blurRadius: 20,
                                          offset: Offset(0, 5),
                                          spreadRadius: 1)
                                    ],
                                    borderRadius: BorderRadius.circular(50)),
                                child: SearchMapPlaceWidget(
                                  apiKey: APIKEY,
                                  // The language of the autocompletion
                                  language: 'en',
                                  placeholder: "search area",
                                  iconColor: Colors.grey,

                                  // The position used to give better recomendations. In this case we are using the user position
                                  location: LatLng(
                                      location.latitude, location.longitude),
                                  radius: 30000,
                                  onSelected: (Place place) async {
                                    final geolocation = await place.geolocation;

                                    _mapController.animateCamera(
                                        CameraUpdate.newLatLng(
                                            geolocation.coordinates));
                                    _mapController.animateCamera(
                                        CameraUpdate.newLatLngBounds(
                                            geolocation.bounds, 0));
                                  },
                                ),
                              )
                            : Container()),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          height:(MediaQuery.of(context).size.height*0.25)<225.0? 225:MediaQuery.of(context).size.height*0.25,
                          decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                    color: kcolor1,
                                    blurRadius: 20,
                                    spreadRadius: 5)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              buildCityCard(
                                  text: "As Salam",
                                  desc: "Riyadh 11562",
                                  img: "city.png"),
                              SizedBox(
                                height: 15,
                              ),
                              buildIconElevatedButton(
                                icon: Icon(Icons.location_on),
                                label: "Select this location",
                                onpressed: () {},
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildCityCard({text, desc, img}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: response.setHeight(96),
          width: response.screenWidth - 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35), color: kwhite),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: response.setHeight(90),
                width: response.setWidth(90),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/$img"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.grey[200]),
              ),
              SizedBox(
                width: response.setWidth(10),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    buildText(text),
                    buildText2(desc, fontsize: 16.0)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
