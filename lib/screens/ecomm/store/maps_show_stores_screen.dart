
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsShowStoresScreen extends StatefulWidget {
  final LatLng initialP;
  const MapsShowStoresScreen({super.key, required this.initialP});

  @override
  State<MapsShowStoresScreen> createState() => _MapsShowStoresScreenState();
}

class _MapsShowStoresScreenState extends State<MapsShowStoresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GoogleMap(
          /* myLocationEnabled: true, // Muestra el punto azul del usuario
          myLocationButtonEnabled:
              false, // Oculta el botón de ubicación (opcional) */
          /* onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          }, */

          initialCameraPosition: CameraPosition(
            target: widget.initialP,
            zoom: 12.0,
          ),
          
          markers: {
              Marker(
                markerId: const MarkerId("_currentLocation"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue,
                ),
                position: widget.initialP,
              ),
            }, // Sin marcadores adicionales
        ),
    );
  }
}