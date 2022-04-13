import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/components/components.dart';
import '../searche_screen.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return defaultFormField(
        radius: 50,
        prefix: FontAwesomeIcons.magnifyingGlass,
        controller: searchController,
        type: TextInputType.text,
        validate: (value) {
          return;
        },
        onChange: (s) {
          if (searchController.text != '')
            navigateTo(
                context,
                SearchScreen(
                  s: s,
                ));
        },
        label: 'Search Food');
  }
}
