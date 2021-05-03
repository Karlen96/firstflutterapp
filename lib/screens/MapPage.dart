import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMapScreen();
  }
}

class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen({Key key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controlder) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(40.181942, 44.514287),
          infoWindow: InfoWindow(
            title: 'branch',
            snippet: 'branch description',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      initialCameraPosition:
          CameraPosition(target: LatLng(40.181941, 44.514287), zoom: 16),
    );
  }
}
