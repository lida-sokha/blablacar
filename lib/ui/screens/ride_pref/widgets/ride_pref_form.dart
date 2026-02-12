import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onSwitchLocation() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  bool get isvalid =>
      departure != null &&
      arrival != null &&
      departure != arrival; 

void onSearch() {
  }
    
  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------



  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.grey),
                title: Text(departure?.name ?? "Leaving from"),
                trailing: IconButton(
                  icon: const Icon(Icons.swap_vert, color: Colors.blue),
                  onPressed: onSwitchLocation,
                ),
                onTap: () {}, 
              ),
              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.grey),
                title: Text(arrival?.name ?? "Going to"),
                onTap: () {}, 
              ),
              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.calendar_month_outlined, color: Colors.grey),
                title: Text("${departureDate.day} Feb"), 
                onTap: () {}, 
              ),
              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.grey),
                title: Text("$requestedSeats"),
                onTap: () {}, 
              ),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: onSearch,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00AFF5), 
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            minimumSize: const Size(double.infinity, 50),
            elevation: 0, 
          ),
          child: const Text(
            "Search",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}