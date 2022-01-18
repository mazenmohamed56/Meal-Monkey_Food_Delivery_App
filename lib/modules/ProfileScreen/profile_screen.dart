import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/components/constants.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var nameController = TextEditingController();
        nameController.text = cubit.model.name;
        var phoneController = TextEditingController();
        phoneController.text = cubit.model.phone;
        var addressController = TextEditingController();
        addressController.text = cubit.model.address.toString();
        var formKey = GlobalKey<FormState>();
        var profileimage = cubit.profileimage;

        return SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(70)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: profileimage != null
                              ? FileImage(profileimage)
                              : NetworkImage(
                                  '${cubit.model.profileImagepath}',
                                ) as ImageProvider,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.3),
                          child: IconButton(
                            onPressed: () {
                              cubit.pickProfilePic();
                            },
                            icon: Icon(
                              FontAwesomeIcons.camera,
                              color: placeholder,
                            ),
                          ),
                          width: 140,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context).changeIsClickForm();
                    },
                    child: Container(
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.pen,
                            size: 10,
                            color: defaultColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Profile',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 10,
                                      color: defaultColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Hi there ${cubit.model.name} !',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      signOut(context);
                    },
                    child: Container(
                      width: 50,
                      alignment: Alignment.center,
                      height: 30,
                      child: Text(
                        'Sign Out',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      isClickable: cubit.isClickable,
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return '         Name must not be empty';
                        }
                      },
                      label: 'name',
                      radius: 30),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      isClickable: cubit.isClickable,
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return '         Mobile No must not be empty';
                        }
                      },
                      label: 'Mobile No',
                      radius: 30),
                  const SizedBox(
                    height: 17,
                  ),
                  defaultFormField(
                      isClickable: cubit.isClickable,
                      controller: addressController,
                      type: TextInputType.streetAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return '         Address must not be empty';
                        }
                      },
                      label: 'Address',
                      radius: 30),
                  const SizedBox(
                    height: 25,
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => true,
                    widgetBuilder: (BuildContext context) => defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                geoAddress: GeoPoint(0, 0));
                          }
                        },
                        text: 'Save',
                        radius: 30,
                        isUpperCase: false),
                    fallbackBuilder: (contex) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 28,
                  )
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
