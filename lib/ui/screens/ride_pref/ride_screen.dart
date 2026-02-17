import 'package:blablacar/ui/screens/ride_pref/widgets/ride_screen_ride_tile.dart';
import 'package:flutter/material.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../model/ride/ride.dart';
import '../../../services/rides_service.dart';
import '../../theme/theme.dart';

class RideScreen extends StatefulWidget {
  final RidePref ridePref;
  const RideScreen({super.key, required this.ridePref});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  late List<Ride> matchingRides;

  @override
  void initState() {
    super.initState();
    matchingRides = RidesService.filterBy(
      departure: widget.ridePref.departure,
      seatRequested: widget.ridePref.requestedSeats,
    );
  }

  void goback() {
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.backgroundAccent,
        elevation: 0,
        leading: IconButton(
          onPressed: goback,
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: matchingRides.length,
          itemBuilder: (context, index) {
            return RideTile(
              ride: matchingRides[index],
              onTap: () {
              },
            );
          },
        ),
      ),
    );
  }
}
