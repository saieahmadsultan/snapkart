// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
//
// class MapPickerView extends StatefulWidget {
//   const MapPickerView({super.key});
//
//   @override
//   State<MapPickerView> createState() => _MapPickerViewState();
// }
//
// class _MapPickerViewState extends State<MapPickerView> {
//   GoogleMapController? _mapController;
//   LatLng _pickedLocation = const LatLng(30.6605, 73.1608);
//   String _address = '';
//   final TextEditingController _searchController = TextEditingController();
//   final Geocoding _geocoding = Geocoding();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//
//     // FIX: cursor ko hamesha end pe rakho taake backspace/typing sahi kaam kare
//     _searchController.addListener(() {
//       final text = _searchController.text;
//       _searchController.selection = TextSelection.fromPosition(
//         TextPosition(offset: text.length),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         _showLocationServiceDialog();
//         return;
//       }
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permission denied')),
//           );
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         _showPermissionDeniedDialog();
//         return;
//       }
//
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       setState(() {
//         _pickedLocation = LatLng(position.latitude, position.longitude);
//       });
//
//       _mapController?.animateCamera(CameraUpdate.newLatLng(_pickedLocation));
//       _updateAddress(_pickedLocation);
//     } catch (e) {
//       debugPrint('Location error: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
//     }
//   }
//
//   void _showLocationServiceDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Location Services Disabled'),
//         content: const Text(
//           'Please enable location services to use this feature.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Geolocator.openLocationSettings();
//             },
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showPermissionDeniedDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please enable location permission in app settings.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Geolocator.openAppSettings();
//             },
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _updateAddress(LatLng location) async {
//     try {
//       List<Placemark> placemarks = await _geocoding.placemarkFromCoordinates(
//         location.latitude,
//         location.longitude,
//       );
//
//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;
//         setState(() {
//           _address = '${p.street}, ${p.locality}, ${p.administrativeArea}';
//         });
//       }
//     } catch (e) {
//       debugPrint('Geocoding error: $e');
//       setState(() {
//         _address = 'Address not available';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         title: SizedBox(
//           height: 42,
//           child: Material(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             child: GooglePlaceAutoCompleteTextField(
//               textEditingController: _searchController,
//               googleAPIKey: "AIzaSyBKqoyowWC_4bXrm_L5zdJpX11TIlT0jco",
//               inputDecoration: InputDecoration(
//                 hintText: "Location search karein...",
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 10,
//                 ),
//               ),
//               debounceTime: 600,
//               countries: const ["pk"],
//               isLatLngRequired: true,
//               getPlaceDetailWithLatLng: (Prediction prediction) {
//                 final lat = double.tryParse(prediction.lat ?? '');
//                 final lng = double.tryParse(prediction.lng ?? '');
//                 if (lat != null && lng != null) {
//                   final newLocation = LatLng(lat, lng);
//                   setState(() {
//                     _pickedLocation = newLocation;
//                   });
//                   _mapController?.animateCamera(
//                     CameraUpdate.newLatLngZoom(newLocation, 16),
//                   );
//                   _updateAddress(newLocation);
//                 }
//               },
//               itemClick: (Prediction prediction) {
//                 _searchController.text = prediction.description ?? '';
//                 _searchController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: prediction.description?.length ?? 0),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _pickedLocation,
//               zoom: 15,
//             ),
//             onMapCreated: (controller) => _mapController = controller,
//             onCameraMove: (position) => _pickedLocation = position.target,
//             onCameraIdle: () => _updateAddress(_pickedLocation),
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//           ),
//           const Center(
//             child: Icon(Icons.location_pin, size: 45, color: Colors.red),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 16,
//             right: 16,
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     _address.isEmpty ? 'Fetching address...' : _address,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context, {
//                       'lat': _pickedLocation.latitude,
//                       'lng': _pickedLocation.longitude,
//                       'address': _address,
//                     });
//                   },
//                   child: const Text('Confirm Location'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Colors/app_widgets.dart';

// Yahan apni Google API key paste karein
const String _googleApiKey = 'YOUR_GOOGLE_API_KEY';

// Neeche wale card ke liye jagah (map ka Google logo is ke upar rehta hai)
const double _cardSpace = 190;

class MapPickerView extends StatefulWidget {
  const MapPickerView({super.key});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  GoogleMapController? _mapController;
  LatLng _pickedLocation = const LatLng(30.6605, 73.1608);
  String _address = '';
  final TextEditingController _searchController = TextEditingController();
  final Geocoding _geocoding = Geocoding();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    // FIX: cursor ko hamesha end pe rakho taake backspace/typing sahi kaam kare
    _searchController.addListener(() {
      final text = _searchController.text;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationServiceDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _snack('Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showPermissionDeniedDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() {
        _pickedLocation = LatLng(position.latitude, position.longitude);
      });

      _mapController?.animateCamera(CameraUpdate.newLatLng(_pickedLocation));
      _updateAddress(_pickedLocation);
    } catch (e) {
      debugPrint('Location error: $e');
      _snack('Error getting location: $e');
    }
  }

  // ============================================================
  // DIALOGS
  // ============================================================

  void _showInfoDialog({
    required String title,
    required String message,
    required VoidCallback onOpenSettings,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.cardBackground(context),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary(context),
          ),
        ),
        content: Text(
          message,
          style: TextStyle(color: AppColors.textSecondary(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onOpenSettings();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showLocationServiceDialog() {
    _showInfoDialog(
      title: 'Location Services Disabled',
      message: 'Please enable location services to use this feature.',
      onOpenSettings: Geolocator.openLocationSettings,
    );
  }

  void _showPermissionDeniedDialog() {
    _showInfoDialog(
      title: 'Permission Denied',
      message: 'Please enable location permission in app settings.',
      onOpenSettings: Geolocator.openAppSettings,
    );
  }

  // ============================================================
  // ADDRESS
  // ============================================================

  Future<void> _updateAddress(LatLng location) async {
    try {
      List<Placemark> placemarks = await _geocoding.placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (!mounted) return;

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          _address = '${p.street}, ${p.locality}, ${p.administrativeArea}';
        });
      }
    } catch (e) {
      debugPrint('Geocoding error: $e');
      if (!mounted) return;
      setState(() {
        _address = 'Address not available';
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background(context),
        foregroundColor: AppColors.textPrimary(context),
        toolbarHeight: 64,
        titleSpacing: 0,
        title: _searchField(context),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 15,
            ),
            padding: const EdgeInsets.only(bottom: _cardSpace),
            onMapCreated: (controller) => _mapController = controller,
            onCameraMove: (position) => _pickedLocation = position.target,
            onCameraIdle: () => _updateAddress(_pickedLocation),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          ),

          // CENTER PIN (nok bilkul map ke center par)
          IgnorePointer(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: _cardSpace + 48),
                child: const Icon(
                  Icons.location_pin,
                  size: 48,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),

          // BOTTOM CARD
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _bottomCard(context),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH FIELD
  // ============================================================

  Widget _searchField(BuildContext context) {
    return Container(
      height: 46,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: _searchController,
        googleAPIKey: _googleApiKey,
        textStyle: TextStyle(
          fontSize: 14,
          color: AppColors.textPrimary(context),
        ),
        inputDecoration: InputDecoration(
          hintText: 'Search for a location...',
          hintStyle: TextStyle(color: AppColors.textSecondary(context)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            size: 22,
            color: AppColors.secondary,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
        debounceTime: 600,
        countries: const ['pk'],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          final lat = double.tryParse(prediction.lat ?? '');
          final lng = double.tryParse(prediction.lng ?? '');
          if (lat != null && lng != null) {
            final newLocation = LatLng(lat, lng);
            setState(() {
              _pickedLocation = newLocation;
            });
            _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(newLocation, 16),
            );
            _updateAddress(newLocation);
          }
        },
        itemClick: (Prediction prediction) {
          _searchController.text = prediction.description ?? '';
          _searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description?.length ?? 0),
          );
        },
      ),
    );
  }

  // ============================================================
  // BOTTOM CARD (address + confirm)
  // ============================================================

  Widget _bottomCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const IconBox(
                Icons.location_on_outlined,
                color: AppColors.success,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected location',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _address.isEmpty ? 'Fetching address...' : _address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GradientButton(
            text: 'Confirm Location',
            icon: Icons.check_circle_outline,
            onTap: () {
              Navigator.pop(context, {
                'lat': _pickedLocation.latitude,
                'lng': _pickedLocation.longitude,
                'address': _address,
              });
            },
          ),
        ],
      ),
    );
  }
}
