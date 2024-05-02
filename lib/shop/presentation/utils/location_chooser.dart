import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_places_autocomplete_widgets/widgets/address_autocomplete_textfield.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/delivery_area_bloc/delivery_area_bloc.dart';

import 'app_constants.dart';

void main() {
  runApp(const MaterialApp(
    home: LocationChooser(),
  ));
}

class LocationChooser extends StatefulWidget {
  const LocationChooser({super.key});

  @override
  State<LocationChooser> createState() => _LocationChooserState();
}

class _LocationChooserState extends State<LocationChooser> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kBangalore = CameraPosition(
    target: LatLng(12.971598, 77.594562), // Coordinates for Bangalore
    zoom: 14.0,
  );
  LatLng? selectedLocation;
  Set<Marker> markers = {};
  late DeliveryAreaBloc blocState;
  TextEditingController searchController = TextEditingController();
  final ValueNotifier<Set<Circle>> _circles = ValueNotifier({});
  final ValueNotifier<Set<Marker>> _markers = ValueNotifier({});
  //
  // addFromList() {
  //   for (var e in blocState.regionList) {
  //     _onMapTap(LatLng(e.latitude, e.longitude));
  //   }
  // }

  @override
  void initState() {
    blocState = DeliveryAreaBloc.get(context);
    // addFromList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getAppBar(
      //     context,
      //     const Text(
      //       "Choose Location",
      //       style: TextStyle(fontSize: 18),
      //     )),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: _markers,
                builder: (context, markers, child) {
                  return ValueListenableBuilder(
                      valueListenable: _circles,
                      builder: (context, circles, child) {
                        return GoogleMap(
                          mapType: MapType.hybrid,
                          onTap: (val) {
                            _onMapTap(val);
                            // addFromList();
                          },
                          circles: circles,
                          markers: markers,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          initialCameraPosition: _kBangalore,
                        );
                      });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddressAutocompleteTextField(
                mapsApiKey: AppConstants.mapKey,
                onSuggestionClick: (place) async {
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          tilt: 59.440717697143555,
                          zoom: 19.151926040649414,
                          bearing: 192.8334901395799,
                          target: LatLng(place.lat ?? 0, place.lng ?? 0))));
                  // final GoogleMapController controller = await _controller.future;
                  // await controller.animateCamera(CameraUpdate.newCameraPosition(
                  //     CameraPosition(
                  //         bearing: 192.8334901395799,
                  //         target: LatLng(37.43296265331129, -122.08832357078792),
                  //         tilt: 59.440717697143555,
                  //         zoom: 19.151926040649414)));
                },
                componentCountry: 'in',
                language: 'en-US',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  hintText: "Search Location",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ValueListenableBuilder(
                    valueListenable: _markers,
                    builder: (context, data, child) {
                      return selectedLocation == null
                          ? const SizedBox()
                          : Container(
                              height: 55,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ElevatedButton(
                                onPressed: () {
                                  blocState.add(ChooseLocationEvent(
                                      selectedLocation!, context));
                                  GoRouter.of(context).pop();
                                },
                                child: const Text("Select"),
                              ));
                    }))
          ],
        ),
      ),
    );
  }

  void _onMapTap(LatLng tappedPoint) {
    // setState(() {
    selectedLocation = tappedPoint;
    _markers.value.clear();

    _markers.value.add(
      Marker(
        markerId: const MarkerId('selected-location'),
        position: tappedPoint,
        infoWindow: const InfoWindow(
          title: 'Selected Location',
          snippet: 'Tap again to place marker',
        ),
      ),
    );
    _addCircle(tappedPoint);
    // });
  }

  Future<void> _addCircle(LatLng center) async {
    _circles.value.add(Circle(
      circleId: const CircleId('selected-circle'),
      center: center,
      radius: 5000, // 5 km in meters
      fillColor: Colors.blue.withOpacity(0.3),
      strokeWidth: 0,
    ));
    _markers.notifyListeners();
    _circles.notifyListeners();
  }
}
