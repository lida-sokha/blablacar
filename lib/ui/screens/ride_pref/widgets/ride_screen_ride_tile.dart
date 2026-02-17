import 'package:flutter/material.dart';
import '../../../../model/ride/ride.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final VoidCallback onTap;
  const RideTile({super.key, required this.ride, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text("Departure: ${ride.departureLocation.name}"),
          Text("Arrival: ${ride.arrivalLocation.name}"),
          Text(
            "Time: ${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')}",
          ),
          Text("Departure:${ride.departureDate.day}"),
        ],
      ),
    );
  }
}
