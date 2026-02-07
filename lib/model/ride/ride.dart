import '../../utils/date_time_util.dart';
import '../user/user.dart';
import 'locations.dart';

enum RideStatus { created, published, ongoing, finished }

/// add enum for filter the time
///
enum TimeSlot { morning, afternoon, evening, night }

extension RideTimeSlot on Ride {
  TimeSlot get timeSlot {
    final hour = departureDate.hour;
    if (hour >= 6 && hour < 12) return TimeSlot.morning;
    if (hour >= 12 && hour < 18) return TimeSlot.afternoon;
    if (hour >= 18 && hour < 22) return TimeSlot.evening;
    return TimeSlot.night;
  }
}

///
/// This model describes a  Ride.
///
class Ride {
  final Location departureLocation;
  final DateTime departureDate;

  final Location arrivalLocation;
  final DateTime arrivalDateTime;

  final User driver;

  final int availableSeats;
  final double pricePerSeat;

  //add the paramter smoking,pet and music
  final bool smokingAllowed;
  final bool petAllowed;
  final bool musicAllowed;

  RideStatus status = RideStatus.created;

  final List<User> passengers = [];

  Ride({
    required this.departureLocation,
    required this.departureDate,
    required this.arrivalLocation,
    required this.arrivalDateTime,
    required this.driver,
    required this.availableSeats,
    required this.pricePerSeat,

    //add new
    required this.smokingAllowed,
    required this.petAllowed,
    required this.musicAllowed
  });

  void addPassenger(User passenger) {
    passengers.add(passenger);
  }

  int get remainingSeats => availableSeats - passengers.length;

  @override
  String toString() {
    return 'Ride from $departureLocation at ${DateTimeUtils.formatDateTime(departureDate)} '
        'to $arrivalLocation arriving at ${DateTimeUtils.formatDateTime(arrivalDateTime)}, '
        'Driver: $driver, Seats: $availableSeats, Price: \$${pricePerSeat.toStringAsFixed(2)}';
  }
}
