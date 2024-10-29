import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearbyAttractionsMap extends StatefulWidget {
  @override
  _NearbyAttractionsMapState createState() => _NearbyAttractionsMapState();
}

class _NearbyAttractionsMapState extends State<NearbyAttractionsMap> {
  GoogleMapController? mapController;  // Nullable mapController
  LatLng? _currentPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      _fetchNearbyAttractions();
    });
  }

  void _fetchNearbyAttractions() {
    List<LatLng> attractions = [
      LatLng(_currentPosition!.latitude + 0.01, _currentPosition!.longitude + 0.01),
      LatLng(_currentPosition!.latitude - 0.01, _currentPosition!.longitude - 0.01),
      LatLng(_currentPosition!.latitude + 0.02, _currentPosition!.longitude - 0.01),
    ];

    setState(() {
      _markers.clear();
      for (var attraction in attractions) {
        _markers.add(Marker(
          markerId: MarkerId(attraction.toString()),
          position: attraction,
          infoWindow: InfoWindow(
            title: 'Attraction',
            snippet: 'Tourist spot nearby',
          ),
        ));
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentPosition != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Attractions')),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 14.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchNearbyAttractions,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
