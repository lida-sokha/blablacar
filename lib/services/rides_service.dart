import 'package:blablacar/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(List<Ride> rides, Location departure) {
    return rides
        .where((rides) => rides.departureLocation == departure)
        .toList();
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(
    List<Ride> rides,
    int requestedSeat,
  ) {
    return rides
        .where((rides) => rides.availableSeats >= requestedSeat)
        .toList();
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> result = availableRides;
    if (departure != null) {
      result = _filterByDeparture(result, departure);
    }
    if (seatRequested != null) {
      result = _filterBySeatRequested(result, seatRequested);
    }
    return result;
  }

  /// add time fliter
  static List<Ride> _filterByTime(List<Ride> rides, TimeSlot timeslot) {
    return rides.where((rides) => rides.timeSlot == timeslot).toList();
  }

  //flter by smoking
  static List<Ride> _filterBySmoking(List<Ride> rides, bool smokingAllowed) {
    return rides
        .where((rides) => rides.smokingAllowed == smokingAllowed)
        .toList();
  }

  static List<Ride> _filterByPetAllow(List<Ride> rides, bool petAllowed) {
    return rides.where((rides) => rides.petAllowed == petAllowed).toList();
  }

  static List<Ride> _filterByMusicAllow(List<Ride> rides, bool musicAllowed) {
    return rides.where((rides) => rides.musicAllowed == musicAllowed).toList();
  }

  static List<Ride> _filterByprice(
    List<Ride> rides,
    double minPrice,
    double maxPrice,
  ) {
    return rides
        .where(
          (rides) =>
              rides.pricePerSeat >= minPrice && rides.pricePerSeat <= maxPrice,
        )
        .toList();
  }
}
