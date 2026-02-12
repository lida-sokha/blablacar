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
    // TODO
    if(widget.initRidePref != null){
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
    else{
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
void OnswitchLocation(){
  setState((){
    final temp = departure;
    departure = arrival;
    arrival = temp;
  });
}

bool get isvalid => departure != null && arrival != null && departureDate != null && requestedSeats >0;

void onSearch(){
  if(isvalid){
    RidePref ridePref = RidePref(
      departureLocation: departure!,
      arrivalLocation: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );
    print("Searching for rides: ${result.departureLocation.name}");
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
            padding: const EdgeInsets.symmetric(horizontal:16),
            children:[
              ListTile(
                Leading: Icon(Icons.location_on_outlined),
                title: Text(departure != null ? departure!.name : "Select departure"),
                trailing: IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: OnswitchLocation,
                ),
                onTap: () {},
              ),
              const Divider(height:1),
              ListTile(
                Leading: Icon(Icons.location_on_outlined),
                title: Text(arrival != null ? arrival!.name : "Select arrival"),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                Leading: Icon(Icons.calendar_today_outlined),
                title: Text(departureDate != null ? departureDate.toLocal().toString().split(' ')[0] : "Select date"),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.grey),
                title: Text("$requestedSeats"),
                onTap: () => {/* Passenger Picker Logic */},
              ),
            ]
          )
        ]);
  }
}
