import 'package:blablacar/dummy_data/dummy_data.dart';
import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../theme/theme.dart';

class LocationPickerScreen extends StatefulWidget {
  final String title;
  const LocationPickerScreen({super.key, required this.title});

  @override
  State<LocationPickerScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LocationPickerScreen> {
  List<Location> filterLocation = [];
  final TextEditingController searchBar = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterLocation;
  }

  void searchChange(String input) {
    setState(() {
      if (input.isEmpty) {
        filterLocation = [];
      } else {
        filterLocation = fakeLocations.where((loc) {
          return loc.name.toLowerCase().contains((input.toLowerCase()));
        }).toList();
      }
    });
  }

  void clear() {
    setState(() {
      searchBar.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios, color: BlaColors.iconLight),
                ),
                Expanded(
                  child: TextField(
                    controller: searchBar,
                    autofocus: true,
                    onChanged: searchChange,
                    decoration: InputDecoration(
                      hintText: widget.title,
                      fillColor: BlaColors.backgroundAccent,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BlaSpacings.s),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: searchBar.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                searchBar.clear();
                                searchChange("");
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterLocation.length,
              itemBuilder: (context, index) {
                final location = filterLocation[index];
                return ListTile(
                  title: Text(location.name, style: BlaTextStyles.body),
                  subtitle: Text(
                    location.country.name,
                    style: BlaTextStyles.label,
                  ),
                  onTap: () => Navigator.pop(context, location),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
