import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/SearchSCreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/item_details_sceen.dart';
import 'package:meal_monkey/modules/menu-Details-Screen/widgets/food_item.dart';
import 'package:meal_monkey/shared/components/components.dart';

import '../../shared/styles/colors.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final String s;
  const SearchScreen({required this.s});
  @override
  Widget build(BuildContext context) {
    TextEditingController serachTextController = TextEditingController();
    serachTextController.text = s;

    return BlocProvider(
      create: (context) => SearchScreenCubit()..initData(s),
      child: BlocConsumer<SearchScreenCubit, SearchScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, FocusScope.of(context).unfocus);

              return true;
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(FontAwesomeIcons.chevronLeft,
                        size: 20, color: placeholder),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                            radius: 50,
                            prefix: FontAwesomeIcons.magnifyingGlass,
                            controller: serachTextController,
                            type: TextInputType.text,
                            validate: (value) {
                              return;
                            },
                            onChange: (s) =>
                                SearchScreenCubit.get(context).search(s),
                            label: 'Search Food'),
                        const SizedBox(
                          height: 24,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (conntext) =>
                              SearchScreenCubit.get(context)
                                  .searchList
                                  .isNotEmpty,
                          widgetBuilder: (context) => ListView.separated(
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    ItemDetailsScreen(
                                        SearchScreenCubit.get(context)
                                            .searchList[index]),
                                  );
                                },
                                child: FoodItem(
                                  item: SearchScreenCubit.get(context)
                                      .searchList[index],
                                )),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemCount: SearchScreenCubit.get(context)
                                .searchList
                                .length,
                          ),
                          fallbackBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
