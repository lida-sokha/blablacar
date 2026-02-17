import 'package:blablacar/ui/widgets/inputs/location_picker.dart';
import 'package:blablacar/utils/date_time_util.dart';
import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/actions/blabutton.dart';
import '../widgets/ride_prefs_input.dart';
import '../../../../utils/animations_util.dart';
import '../ride_screen.dart';

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
      departure != null && arrival != null && departure != arrival;

  void onSubmit() {
    if (isvalid) {
      RidePref selectedRidePref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RideScreen(ridePref: selectedRidePref),
        ),
      );
    }
  }

  void onDeparturePressed() async {
    final Location? selectedLocation = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: departure),
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    final Location? selectedLocation = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: arrival),
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;
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
              RidePrefInput(
                title: departureLabel,
                onPressed: onDeparturePressed,
                leftIcon: Icons.location_on,
                isPlaceHolder: showDeparturePLaceHolder,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible ? onSwitchLocation : null,
              ),
              const Divider(height: 1),

              RidePrefInput(
                title: arrivalLabel,
                onPressed: onArrivalPressed,
                leftIcon: Icons.location_on,
                isPlaceHolder: showArrivalPLaceHolder,
              ),
              const Divider(height: 1),

              RidePrefInput(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () => {},
              ),
              const Divider(height: 1),

              RidePrefInput(
                title: numberLabel,
                onPressed: () => {},
                leftIcon: Icons.person_2_outlined,
              ),
            ],
          ),
        ),

        BlaButton(label: "Search", onPressed: onSubmit),
      ],
    );
  }
}
