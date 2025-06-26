import 'dart:async';

import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/router/app_router.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/address/bloc/address_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsSelectAddressScreen extends StatefulWidget {
  const MapsSelectAddressScreen({super.key});

  @override
  State<MapsSelectAddressScreen> createState() => _MapsSelectAddressScreenState();
}

class _MapsSelectAddressScreenState extends State<MapsSelectAddressScreen> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  static const LatLng _defaultLocation = LatLng(-11.9593339, -77.0706197); // Ubicación por defecto (ej: Lima)
  //static const LatLng _pUpn = LatLng(-11.9593339, -77.0706197);
  // Guarda la ubicación actual del usuario o la selección manual
  LatLng? _currentP;
  geo.Placemark? _selectedPlace;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      // 1. Verifica si el servicio de ubicación está habilitado
      bool serviceEnabled = await _locationController.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _locationController.requestService();
        if (!serviceEnabled) {
          _setDefaultLocation();
          return;
        }
      }

      // 2. Verifica permisos
      PermissionStatus permissionGranted = await _locationController.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _locationController.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          _setDefaultLocation();
          return;
        }
      }

      // 3. Obtiene la ubicación actual
      LocationData locationData = await _locationController.getLocation();
      setState(() {
        _currentP = LatLng(locationData.latitude!, locationData.longitude!);
      });

      // 4. Mueve la cámara a la ubicación
      if (_currentP != null) {
        _camaraToPosition(_currentP!);
      }
    } catch (e) {
      //print("Error al obtener ubicación: $e");
      _setDefaultLocation();
    }
  }

  void _setDefaultLocation() {
    setState(() {
      _currentP = _defaultLocation;
    });
  }

  Future<void> _camaraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(pos, 15), // Zoom más cercano (15)
    );
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        setState(() {
          _selectedPlace = placemarks.first;
          _currentP = position; // Actualiza la posición seleccionada
        });

        _showAddressDetails(placemarks.first, position);
      }
    } catch (e) {
      //print("Error al obtener dirección: $e");
    }
  }

  void _showAddressDetails(geo.Placemark place, LatLng position) {
    //print(place.toString());
    final nameController = TextEditingController();
    final streetController =
        TextEditingController(text: (place.street != null && place.street != 'Unnamed Road') ? place.street : '');
    final localityController = TextEditingController(text: place.locality ?? '');
    final stateController = TextEditingController(text: place.subAdministrativeArea ?? '');
    final countryController = TextEditingController(text: place.country ?? '');
    final postalCodeController = TextEditingController(text: place.postalCode ?? '');

    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      isScrollControlled: true, // Para que el modal ocupe más espacio si hay teclado
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirma o completa la dirección',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // CAMBIA: Aquí usamos campos editables
                // * label
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name:',
                  ),
                ),
                // * Addresss line pero eso se calcula
                TextField(
                  controller: streetController,
                  decoration: const InputDecoration(
                    // o  street
                    labelText: 'Calle y número',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: localityController,
                  decoration: const InputDecoration(
                    labelText: 'Localidad / Ciudad',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'Provincia / Estado',
                  ),
                ),
                TextField(
                  controller: countryController,
                  decoration: const InputDecoration(
                    labelText: 'País',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: postalCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Código postal',
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.trim() == "") {
                          return;
                        }
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthStateSignedIn) {
                          final accessToken = authState.authResponse!.session!.accessToken;

                          // CAMBIA: Toma los valores finales desde los controladores
                          context.read<AddressBloc>().add(
                                AddressEventCreate(
                                  accessToken: accessToken,
                                  label: nameController.text,
                                  addressLine: streetController.text.trim(),
                                  city: localityController.text.trim(),
                                  state: stateController.text.trim(),
                                  country: countryController.text.trim(),
                                  postalCode: postalCodeController.text.trim(),
                                  latitude: position.latitude,
                                  longitude: _currentP!.longitude,
                                ),
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddressDetails2(geo.Placemark place) {
    final streetController =
        TextEditingController(text: (place.street != null && place.street != 'Unnamed Road') ? place.street : '');
    final localityController = TextEditingController(text: place.locality ?? '');
    final postalCodeController = TextEditingController(text: place.postalCode ?? '');
    final countryController = TextEditingController(text: place.country ?? '');
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ubicación seleccionada',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              if (place.street != null) Text('Calle: ${place.street}'),
              if (place.locality != null) Text('Localidad: ${place.locality}'),
              if (place.postalCode != null) Text('Código postal: ${place.postalCode}'),
              if (place.country != null) Text('País: ${place.country}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final authState = context.read<AuthBloc>().state;
                      if (authState is AuthStateSignedIn) {
                        final accessToken = authState.authResponse!.session!.accessToken;

                        //print("city ${_selectedPlace!.country}");
                        /* context.read<AddressBloc>().add(
                              AddressEventCreate(
                                accessToken: accessToken,
                                label: _selectedPlace!.name!,
                                //addressLine: _selectedPlace!.administrativeArea!,
                                addressLine:
                                    "${_selectedPlace!.street} ${_selectedPlace!.subThoroughfare ?? ''}"
                                        .trim(),

                                city: _selectedPlace!.country!,
                                state: _selectedPlace!.locality!,
                                country: _selectedPlace!.street!,
                                postalCode: _selectedPlace!.postalCode!,
                              ),
                            ); */
                        // aqui eta solo pop
                        GoRouter.of(context).go(AppRoutes.addressRoute);
                        //return; // me parece que esta demas
                      }
                      // no se puedo nose me parece que no por que se ejecuta
                      //Navigator.pop(context, place);
                    },
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ) /* .then((value) {
      if (value != null && _currentP != null) {
        Navigator.pop(context, {
          'latitude': _currentP!.latitude,
          'longitude': _currentP!.longitude,
          'address': _formatAddress(value),
          'zipCode': value.postalCode ?? '',
        });
      }
    }) */
        ;
  }

  String _formatAddress(geo.Placemark place) {
    return '${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) async {
        if (state is AddressStateLoaded) {
          if (state.isSuccess != null) {
            if (state.isSuccess!) {
              Navigator.pop(context);
            }
          }
          if (state.isLoading) {
            LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'loading ...',
            );
          } else {
            LoadingScreen().hide();
          }
          if (state.exception != null) {
            await showErrorDialog(context, state.exception.toString());
          }
        }

        //Navigator.of(context, rootNavigator: true).pop();
      },
      child: /* _currentP == null
          ? const Center(
              child: Text("Loading"),
            )
          : */
          Scaffold(
        appBar: AppBar(
          title: const Text('Selecciona una ubicación'),
        ),
        body: GoogleMap(
          myLocationEnabled: true, // Muestra el punto azul del usuario
          // Oculta el botón de ubicación (opcional)
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },

          initialCameraPosition: CameraPosition(
            target: _currentP ?? _defaultLocation,
            zoom: 12.0,
          ),
          onTap: (LatLng position) {
            _getAddressFromLatLng(
              position,
            ); // Al tocar el mapa, selecciona una ubicación
          },
          /* markers: {
            Marker(
              markerId: const MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
              position: _currentP!,
            ),
          }, */ // Sin marcadores adicionales
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.my_location),
          onPressed: () {
            if (_currentP != null) {
              _camaraToPosition(
                _currentP!,
              ); // Centra la cámara en la ubicación actual
            }
          },
        ),
      ),
    );
  }
}

// * ---------------------------------------------------Repaso

class MapsSelectAddressScreenRepaso extends StatefulWidget {
  const MapsSelectAddressScreenRepaso({super.key});

  @override
  State<MapsSelectAddressScreenRepaso> createState() => _MapsSelectAddressScreenRepasoState();
}

class _MapsSelectAddressScreenRepasoState extends State<MapsSelectAddressScreenRepaso> {
  Location _locationController = Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  static const LatLng _pUpn = LatLng(-11.9593339, -77.0706197);
  static const LatLng _pMegaPlaza = LatLng(-11.9982355, -77.0766225);
  LatLng? _currentP;

  geo.Placemark? _selectedPlace;
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  Future<void> getLocationUpdates() async {
    // * Permite saber si podemos obtener la ubicación del usuario
    bool _serviceEnabled;
    // * Determina si el usuario nos concede permiso
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      //print("location no habilitado");
      return;
    }

    // ! que pasa si el usuario no da permiso a su ubicacion
    // ! volvermos a pantalla anterior o lo dejamos en un punto pero donde?

    _serviceEnabled = await _locationController.requestService();

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    /* _locationController.onLocationChanged.listen(
      (LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            _currentP =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            // _camaraToPosition(_currentP!); de momento no lo vamos a usar
          });
        }
      },
    ); */
  }

  Future<void> _camaraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCamaraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCamaraPosition),
    );
  }

  // * -----------------------------------------
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        setState(() {
          _selectedPlace = placemarks.first;
          _currentP = position;
        });

        // Muestra los detalles de la ubicación
        _showAddressDetails(placemarks.first);
      }
    } catch (e) {
      //print("Error al obtener la dirección: $e");
    }
  }

  void _showAddressDetails(geo.Placemark place) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ubicación seleccionada',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              if (place.street != null) Text('Calle: ${place.street}'),
              if (place.locality != null) Text('Localidad: ${place.locality}'),
              if (place.postalCode != null) Text('Código postal: ${place.postalCode}'),
              if (place.country != null) Text('País: ${place.country}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí puedes devolver la ubicación seleccionada
                      Navigator.pop(context, place);
                    },
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        // El usuario ha confirmado la selección
        if (context.mounted) {
          Navigator.pop(context, {
            'latitude': _currentP!.latitude,
            'longitude': _currentP!.longitude,
            'address': _formatAddress(value),
            'zipCode': value.postalCode ?? '',
          });
        }
      }
    });
  }

  String _formatAddress(geo.Placemark place) {
    return '${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // o mostrar la ubicacion del pais
      appBar: AppBar(),
      body: _currentP == null
          ? const Center(
              child: Text("Loading"),
            )
          : GoogleMap(
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              initialCameraPosition: const CameraPosition(
                //target: _currentP!,
                target: _pUpn,
                zoom: 12.0,
              ),
              onTap: (LatLng position) {
                _getAddressFromLatLng(position);
              },
              markers: {
                Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  position: _pUpn,
                ),
                /* Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  position: _currentP!,
                ), */
                // * Otros
                /*  const Marker(
                  markerId: MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pUpn,
                ),
                const Marker(
                  markerId: MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pMegaPlaza,
                ), */
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.select_all),
        onPressed: () {
          if (_currentP == null) {
            //print("nullllllllllllllllllllll!!!");
            return;
          }
          //print(_currentP!.latitude);
          //print(_currentP!.longitude);
          //print(_formatAddress(_selectedPlace!));
          //print(_selectedPlace!.postalCode ?? '');
        },
      ),
    );
  }
}

// ! mira esto puedes retornar valores pero usare bloc
/*
floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          if (_selectedPlace != null && _currentP != null) {
            Navigator.pop(context, {
              'latitude': _currentP!.latitude,
              'longitude': _currentP!.longitude,
              'address': _formatAddress(_selectedPlace!),
              'zipCode': _selectedPlace!.postalCode ?? '',
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor selecciona una ubicación')),
            );
          }
        },
      ),
 */
