import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick_cab/models/place.dart';
import 'package:quick_cab/widgets/circle_icon.dart';
import 'package:quick_cab/widgets/custom_textfield.dart';
import 'package:quick_cab/widgets/widgets.dart';
import 'package:timelines/timelines.dart';
import 'package:shimmer/shimmer.dart';

import '../configs/configs.dart';

enum steps { order, pickup, otw }

class RideSCreen extends StatefulWidget {
  const RideSCreen({Key? key}) : super(key: key);

  @override
  State<RideSCreen> createState() => _RideSCreenState();
}

class _RideSCreenState extends State<RideSCreen> {
  final Completer<GoogleMapController> _controller = Completer();

  var pickedLocation = const LatLng(37.42796133580664, -122.085749655962);
  bool hasLocationPicked = false;

  static const CameraPosition _manila = CameraPosition(
    target: LatLng(14.5995, 120.9842),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  bool confirmPickup = false;
  bool isLoading = false;
  steps step = steps.order;

  var rng = Random();

  var selectedLocation = '';
  var completeLocation = '';

  final Set<Marker> _markers = {};

  var selectedCoordinates = const LatLng(0, 0);

  final iconData = EvaIcons.pin;
  final pictureRecorder = PictureRecorder();

  GeoCode geo = GeoCode();
  Future<void> getLocationName(LatLng latlng) async {
    try {
      var addresses = geo.reverseGeocoding(
        latitude: latlng.latitude,
        longitude: latlng.longitude,
      );
      addresses.then((value) {
        setState(() {
          selectedLocation =
              '${value.streetNumber ?? ''} ${value.streetAddress}, ${value.city}';
          completeLocation =
              '${value.streetNumber ?? ''} ${value.streetAddress}, ${value.city}, ${value.region} ${value.postal}';
          isLoading = false;
        });
      });
    } catch (e) {
      selectedLocation = e.toString();
    }
  }

  List<Place> places = [
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Never gonna give you up',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Never gonna let you down',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Never gonna run around and desert you',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Never gonna make you cry',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Never gonna say goodbye',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Never gonna tell a lie and hurt you',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Miss na kita',
    ),
    Place(
      name: 'Mall of the Emirates Metro ',
      location: 'Internet city - Business tower',
    ),
  ];

  Widget buildHistroryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: places.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var place = places.elementAt(index);
        return GestureDetector(
          onTap: () {
            setState(() {
              step = steps.pickup;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.asset('assets/map.png').image,
                      child: Icon(
                        EvaIcons.pin,
                        color: secondary,
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: fontPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          place.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: fontGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget orderRide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        const Center(child: Handle()),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Where you want to go ?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(
                hintText: 'Enter destination',
                inputType: TextInputType.name,
                decorated: true,
                prefixIcon: EvaIcons.search,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: fontPrimary,
                ),
              ),
              SizedBox(
                height: 200,
                child: buildHistroryList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget confirm() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          const Center(child: Handle()),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Confirm pickup',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: CircleAvatar(
                    backgroundImage: Image.asset('assets/map.png').image,
                    child: Icon(
                      EvaIcons.pin,
                      color: secondary,
                    ),
                  ),
                  title: isLoading
                      ? Container(
                          height: 40,
                          width: 100,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Shimmer.fromColors(
                              child: Container(
                                color: Colors.white,
                              ),
                              baseColor: lightPurple,
                              highlightColor: lightGrey),
                        )
                      : Text(
                          selectedLocation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: fontPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  subtitle: isLoading
                      ? const SizedBox.shrink()
                      : Text(
                          completeLocation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: fontPrimary,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                    text: 'Confirm ride',
                    showLoading: isLoading,
                    onPressed: () {
                      setState(() {
                        step = steps.otw;
                      });
                    }),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rideLocationLabel({required String label, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 14,
            color: fontGrey,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 16,
            color: fontPrimary,
          ),
        ),
      ],
    );
  }

  Widget driver() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: Image.asset('assets/rick.jpg').image,
              ),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your captain',
                    style: TextStyle(
                      fontSize: 14,
                      color: fontGrey,
                    ),
                  ),
                  Text(
                    'Rick Astley',
                    style: TextStyle(
                      fontSize: 16,
                      color: fontPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const CircleIcon(
            iconData: EvaIcons.phoneCallOutline,
          ),
          const SizedBox(
            width: 14,
          ),
          const CircleIcon(
            iconData: EvaIcons.emailOutline,
          ),
        ],
      ),
    );
  }

  Widget otw() {
    int randomPrice = rng.nextInt(599);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        const Center(child: Handle()),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Driver is on the way',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              driver(),
              const SizedBox(
                height: 14,
              ),
              const Divider(),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      OutlinedDotIndicator(
                        size: 22,
                        color: secondary,
                        borderWidth: 3,
                      ),
                      SizedBox(
                        height: 45.0,
                        child: DashedLineConnector(
                          color: lightGrey,
                        ),
                      ),
                      Icon(
                        EvaIcons.pin,
                        size: 25,
                        color: secondary,
                      ),
                      // OutlinedDotIndicator(
                      //   size: 22,
                      //   color: secondary,
                      //   borderWidth: 3,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rideLocationLabel(
                        label: 'Pickup Location',
                        text: 'Sa puso mo ❤️',
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      rideLocationLabel(
                        label: 'Drop off',
                        text: selectedLocation,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 37,
                            height: 37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: lightGrey,
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 5,
                            child: Text(
                              '🚕',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payment'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Card: .... .... 7846',
                        style: TextStyle(
                          color: fontPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '₱ ${randomPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget aa() {
    return Column(
      children: [
        rideLocationLabel(label: 'label', text: ''),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('🚕'),
          ],
        ),
      ],
    );
  }

  Widget getStep() {
    Widget content = Container();
    if (step == steps.order) {
      content = orderRide();
    } else if (step == steps.pickup) {
      content = confirm();
    } else if (step == steps.otw) {
      content = otw();
    } else {
      content = orderRide();
    }

    return content;
  }

  CameraPosition getPickedLocation(LatLng? target) {
    return CameraPosition(
      target: target ?? _manila.target,
      zoom: 14,
    );
  }

  BitmapDescriptor getIcon() {
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    late BitmapDescriptor bitmapDescriptor;

    Future.delayed(Duration.zero).then((value) async {
      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(48, 48);
      final bytes = await image.toByteData(format: ImageByteFormat.png);

      bitmapDescriptor =
          BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
    });

    return bitmapDescriptor;
  }

  @override
  Widget build(BuildContext context) {
    // return GoogleMap(
    //   mapType: MapType.hybrid,
    //   initialCameraPosition: _manila,
    //   onMapCreated: (GoogleMapController controller) {
    //     _controller.complete(controller);
    //   },
    // );
    LatLng? target;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   color: Colors.red,
          // ),
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: getPickedLocation(target),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setState(() {
                _markers.add(
                  Marker(
                    markerId: const MarkerId('<MARKER_ID>'),
                    position: _manila.target,
                    icon: getIcon(),
                  ),
                );
              });
            },
            onTap: (latLng) async {
              setState(() {
                isLoading = true;
              });
              var picked = CameraPosition(target: latLng, zoom: 14);
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(picked));
              setState(() {
                getLocationName(latLng);
                step = steps.pickup;
              });
            },
          ),
          Container(
            // height: 400,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedContainer(
                    child: getStep(),
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
