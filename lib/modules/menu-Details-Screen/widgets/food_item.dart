import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/item_data_modell.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../../item Details Screen/item_details_sceen.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    Key? key,
    required this.item,
    this.fromOffers,
    this.width,
  }) : super(key: key);

  final ItemModel item;
  final double? width;
  final bool? fromOffers;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ItemDetailsScreen(item));
      },
      child: Container(
        height: 200,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(36, 48, 78, 0.80),
              offset: Offset(0.4, 0.5),
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(item.imagepath,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                height: 200,
                width: width ?? double.infinity,
              );
            }, height: 200, width: width ?? double.infinity, fit: BoxFit.fill),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 20,
                color: Colors.black.withOpacity(0.04),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 21, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.title}',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: defaultColor,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text('${item.rate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: defaultColor)),
                          const SizedBox(width: 5),
                          Text('(rating)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white)),
                          const SizedBox(width: 25),
                          Text('${item.category}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (item.discount != 0 && fromOffers == null)
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: defaultColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'OFFER',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
