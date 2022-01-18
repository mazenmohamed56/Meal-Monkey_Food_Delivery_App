import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/MapScreen/cubit/states.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';

class MapScreenCubit extends Cubit<MapScreenStates> {
  MapScreenCubit() : super(InitMapState());
  static MapScreenCubit get(context) => BlocProvider.of(context);
  CameraPosition initCammira = CameraPosition(target: LatLng(0, 0));
  Map selectedAddress = {'address': '', 'geoPoint': GeoPoint(0, 0)};
  Map<String, Map> addresses = <String, Map>{
    'Home Address': {
      'type': 'Home Address',
      'address': '',
      'geoPoint': GeoPoint(0, 0)
    },
    'Current Location': {
      'type': 'Current Location',
      'address': '',
      'geoPoint': GeoPoint(0, 0)
    },
    'Selected Location': {
      'type': 'Selected Location',
      'address': '',
      'geoPoint': GeoPoint(0, 0)
    }
  };
  getUserAddressPosition(context) async {
    if (CacheHelper.getData(key: 'uId') != null) {
      GeoPoint geoAddress = HomeCubit.get(context).model.geoAddress;
      LatLng point = LatLng(geoAddress.latitude, geoAddress.longitude);
      initCammira = CameraPosition(target: point, zoom: 16);
      addMarker(MarkerId('Origin'), point, 'Home address');
      setAddressesList('Home Address');
      emit(GetUserAddressPositionSuccessState());
    }
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('Origin'): Marker(
        infoWindow: InfoWindow(title: 'Home'),
        markerId: MarkerId('Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)),
    MarkerId('currentLocation'): Marker(
        infoWindow: InfoWindow(title: 'CurrentLocation'),
        markerId: MarkerId('Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
    MarkerId('selectedLocation'): Marker(
      markerId: MarkerId('selectedLocation'),
      infoWindow: InfoWindow(title: 'Selected Location'),
    )
  };
  setAddressesList(String type) async {
    markers.forEach((key, value) async {
      if (value.position != LatLng(0.0, 0.0))
        addresses[type] = {
          'type': type,
          'address': await getAddressFromLatLong(value.position),
          'geoPoint': value.position,
        };
    });
    print(addresses);
    emit(AddMarkMapState());
  }

  setSelectedAddress(String type) {
    selectedAddress = {
      'address': addresses[type]!['address'],
      'geoPoint': addresses[type]!['geoPoint']
    };
  }

  getCurrentLocation(var _controller) async {
    final GoogleMapController controller = await _controller;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng currentLang = LatLng(position.latitude, position.longitude);
    print(currentLang);
    CameraPosition currentPosition = CameraPosition(
      target: currentLang,
      zoom: 18.4746,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
    addMarker(MarkerId('currentLocation'), currentLang, 'Current Location');
  }

  void addMarker(MarkerId id, LatLng pos, String type) {
    markers[id] = markers[id]!.copyWith(positionParam: pos);
    setAddressesList(type);

    emit(AddMarkMapState());
  }

  Future<String> getAddressFromLatLong(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemarks[1]);
    Placemark place = placemarks[1];

    String address =
        '${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.country}';
    print(address);
    return address;
  }
}
