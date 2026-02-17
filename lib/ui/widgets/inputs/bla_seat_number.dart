import 'package:flutter/material.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../theme/theme.dart';

class BlaSeatNumber extends StatefulWidget {
  final RidePref? initRidePref;
  const BlaSeatNumber({super.key, required this.initRidePref});

  @override
  State<BlaSeatNumber> createState() => _BlaSeatNumberState();
}

class _BlaSeatNumberState extends State<BlaSeatNumber> {
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      requestedSeats = 1;
    }
  }

  void inCrease() {
    setState(() {
      requestedSeats++;
    });
  }

  void deCrease() {
    if (requestedSeats > 1) {
      setState(() {
        requestedSeats--;
      });
    }
  }

  void onConfirm() {
    Navigator.pop(context, requestedSeats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: BlaColors.primary,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Title(
              color: BlaColors.neutralDark,
              child: Text(
                "Number of seats to book",
                style: BlaTextStyles.heading.copyWith(
                  color: BlaColors.neutralDark,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: deCrease,
                  icon: Icon(
                    Icons.remove_circle_outline,
                    size: 40,
                    color: requestedSeats > 1
                        ? BlaColors.primary 
                        : BlaColors.greyLight,
                  ),
                ),
                Text(
                  "$requestedSeats",
                  style: BlaTextStyles.heading.copyWith(
                    color: BlaColors.neutralDark,
                  ),
                ),
                IconButton(
                  onPressed: inCrease,
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 40,
                    color: BlaColors.primary 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onConfirm,
        backgroundColor: BlaColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}