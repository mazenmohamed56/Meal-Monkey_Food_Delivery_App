import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_monkey/modules/MapScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/MapScreen/cubit/states.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

    var cubit = MapScreenCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, MapScreenCubit.get(context).selectedAddress);
        return true;
      },
      child: new BlocConsumer<MapScreenCubit, MapScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: cubit.initCammira,
                  markers: cubit.markers.values.toSet(),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onLongPress: (argument) {
                    cubit.addMarker(MarkerId('selectedLocation'), argument,
                        'Selected Location');
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Set Address To :',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  if (cubit.addresses['Home Address']![
                                          'address'] !=
                                      '')
                                    addressItem(
                                        context,
                                        cubit
                                            .addresses['Home Address']!['type'],
                                        cubit.addresses['Home Address']![
                                            'address']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (cubit.addresses['Current Location']![
                                          'address'] !=
                                      '')
                                    addressItem(
                                        context,
                                        cubit.addresses['Current Location']![
                                            'type'],
                                        cubit.addresses['Current Location']![
                                            'address']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (cubit.addresses['Selected Location']![
                                          'address'] !=
                                      '')
                                    addressItem(
                                        context,
                                        cubit.addresses['Selected Location']![
                                            'type'],
                                        cubit.addresses['Selected Location']![
                                            'address']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                cubit.getCurrentLocation(_controller.future);
              },
              label: Text('Your Current Location'),
              icon: Icon(Icons.location_searching_rounded),
            ),
          );
        },
      ),
    );
  }

  InkWell addressItem(BuildContext context, String title, String data) {
    return InkWell(
      onTap: () {
        MapScreenCubit.get(context).setSelectedAddress(title);

        showToast(msg: 'Seted to $title ');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' $title :',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            ' $data',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 16, color: defaultColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
