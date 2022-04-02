import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_cab/configs/rick.dart';
import 'package:timelines/timelines.dart';

import '../configs/configs.dart';
import '../models/car.dart';
import '../models/ride_history.dart';
import '../widgets/widgets.dart';

import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //🚕🚗🛵🛻

  List<Car> cars = [
    Car(carEmoji: '🚕', name: 'Taxi'),
    Car(carEmoji: '🚗', name: 'Car'),
    Car(carEmoji: '🛵', name: 'Scooter'),
    Car(carEmoji: '🛻', name: 'Pickup'),
  ];

  List<RideHistory> ridesHistoryData = [
    RideHistory(
      date: DateTime.now().subtract(const Duration(days: 1)),
      total: 87,
      pickUpLocation: 'Internet city - Business tower',
      dropOffLocation: 'Mall of the Emirates Metro ',
    ),
    RideHistory(
      date: DateTime.now().subtract(const Duration(days: 3)),
      total: 69,
      pickUpLocation: 'Sa bahay',
      dropOffLocation: 'Dyan lang sa may kanto',
    ),
    RideHistory(
      date: DateTime.now().subtract(const Duration(days: 3)),
      total: 69,
      pickUpLocation: 'Sa bahay',
      dropOffLocation: 'Dyan lang sa may kanto',
    ),
    RideHistory(
      date: DateTime.now().subtract(const Duration(days: 3)),
      total: 69,
      pickUpLocation: 'Sa bahay',
      dropOffLocation: 'Dyan lang sa may kanto',
    ),
    RideHistory(
      date: DateTime.now().subtract(const Duration(days: 3)),
      total: 69,
      pickUpLocation: 'Sa bahay',
      dropOffLocation: 'Dyan lang sa may kanto',
    ),
  ];

  Widget promotion() {
    var theme = Theme.of(context);
    return SizedBox(
      height: 240,
      width: double.infinity,
      //color: Theme.of(context).primaryColor,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 170,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Make your life much easier',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Order now & get 50% off of your first ride',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: lightGrey2.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: CustomButton.small(
                      'Order now',
                      () async {
                        if (!await launch(rickrick))
                          throw 'Could not launch $rickrick';
                      },
                      theme.primaryColor,
                      Colors.white,
                      true,
                      12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset('assets/promotion_model.png'),
        ],
      ),
    );
  }

  Widget carSelection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select a car',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: fontPrimary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildCardsList(),
        ],
      ),
    );
  }

  Widget buildCardsList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cars.length,
        scrollDirection: Axis.horizontal,
        //itemExtent: 100,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ride');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: lightGrey2,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        cars.elementAt(index).carEmoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    cars.elementAt(index).name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: fontPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ridesHistory() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Rides history',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: fontPrimary,
                ),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('See all')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          buildRidesHistory(),
        ],
      ),
    );
  }

  Widget buildRidesHistory() {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        itemCount: ridesHistoryData.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var ride = ridesHistoryData.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: buildRideHistoryCard(
                    rideHistory: RideHistory(
                      date: ride.date,
                      total: ride.total,
                      pickUpLocation: ride.pickUpLocation,
                      dropOffLocation: ride.dropOffLocation,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRideHistoryCard({required RideHistory rideHistory}) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: lightPurple,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat.yMMMEd().format(rideHistory.date).toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  //const Spacer(),
                  Text(
                    '\$${rideHistory.total}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
                    text: rideHistory.pickUpLocation,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  rideLocationLabel(
                    label: 'Drop off',
                    text: rideHistory.dropOffLocation,
                  ),
                ],
              ),
            ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: fontPrimary,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              'assets/avatar.png',
              width: 44,
              height: 44,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: TextStyle(
                    fontSize: 12,
                    color: fontGrey,
                  ),
                ),
                Text(
                  'Delts',
                  style: TextStyle(
                    color: fontPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: lightGrey2),
              ),
              child: const Icon(
                EvaIcons.bellOutline,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            promotion(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  carSelection(),
                  const SizedBox(
                    height: 20,
                  ),
                  ridesHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
