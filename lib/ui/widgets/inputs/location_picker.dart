import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../services/locations_service.dart';
import '../../theme/theme.dart';
import '../../widgets/display/bla_divider.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;
  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String currentSearchText = "";

  @override
  void initState() {
    super.initState();
    if (widget.initLocation != null) {
      currentSearchText = widget.initLocation!.name;
    }
  }

  void onSearchChanged(String search) {
    setState(() {
      currentSearchText = search;
    });
  }

  void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  List<Location> get filteredLocations {
    if (currentSearchText.length < 2) return [];

    return LocationsService.availableLocations
        .where(
          (location) => location.name.toLowerCase().contains(
            currentSearchText.toLowerCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Added SafeArea to prevent UI overlapping with phone status bar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              const SizedBox(height: BlaSpacings.s),
              LocationSearchBar(
                initSearch: currentSearchText,
                onBackTap: onBackTap,
                onSearchChanged: onSearchChanged,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) => LocationTile(
                    location: filteredLocations[index],
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationSearchBar extends StatefulWidget {
  final String initSearch;
  final VoidCallback onBackTap;
  final ValueChanged<String> onSearchChanged;

  const LocationSearchBar({
    super.key,
    required this.onBackTap,
    required this.onSearchChanged,
    required this.initSearch,
  });

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  late final TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void onClearTap() {
    _searchController.clear();
    widget.onSearchChanged(""); 
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlaColors.greyLight,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _searchController,
              autofocus: true, 
              onChanged: (value) {
                widget.onSearchChanged(value);
                setState(() {}); 
              },
              style: TextStyle(color: BlaColors.textNormal), 
              decoration: const InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
              ),
            ),
          ),
          if (_searchController
              .text
              .isNotEmpty) 
            IconButton(
              onPressed: onClearTap,
              icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
            ),
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final Location location;
  final ValueChanged<Location> onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          leading: Icon(Icons.location_on_outlined, color: BlaColors.iconLight),
          title: Text(location.name, style: BlaTextStyles.body),
          subtitle: Text(
            location.country.name,
            style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: BlaColors.iconLight,
            size: 16,
          ),
        ),
        const BlaDivider(),
      ],
    );
  }
}
