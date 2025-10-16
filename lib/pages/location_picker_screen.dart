import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  LatLng? _currentLocation;
  String _locationName = '';
  final TextEditingController _locationNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _locationNameController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Request location permission
      final permission = await Permission.location.request();
      if (permission != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission is required'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _selectedLocation = _currentLocation;
      });

      // Move camera to current location
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_currentLocation!),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentLocation != null) {
      controller.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
    }
  }

  Widget _buildWebLocationPicker() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 64, color: Color(0xFF0D4A58)),
          const SizedBox(height: 16),
          const Text(
            'Current Location',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFF0D4A58),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Latitude: ${_currentLocation!.latitude.toStringAsFixed(6)}',
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Longitude: ${_currentLocation!.longitude.toStringAsFixed(6)}',
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Note: Interactive map is not available on web.\nUsing current location.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLocation() {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_locationName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a location name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Return the selected location and name
    Navigator.pop(context, {
      'location': _selectedLocation,
      'name': _locationName.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D4A58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Location',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _getCurrentLocation,
            child: const Text(
              'My Location',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFFE04703),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Name Input
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location Name',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0D4A58),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _locationNameController,
                  onChanged: (value) => setState(() => _locationName = value),
                  decoration: InputDecoration(
                    hintText: 'Enter location name (e.g., Home, Office)',
                    hintStyle: const TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF999999),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFB9FAF8),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFB9FAF8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF6B35),
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Map
          Expanded(
            child: _currentLocation == null
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF0D4A58)),
                  )
                : kIsWeb
                ? _buildWebLocationPicker()
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 15.0,
                    ),
                    onTap: _onMapTap,
                    markers: _selectedLocation != null
                        ? {
                            Marker(
                              markerId: const MarkerId('selected_location'),
                              position: _selectedLocation!,
                              infoWindow: const InfoWindow(
                                title: 'Selected Location',
                              ),
                            ),
                          }
                        : {},
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
          ),

          // Confirm Button
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _confirmLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE04703),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Confirm Location',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
