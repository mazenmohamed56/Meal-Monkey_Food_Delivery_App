import 'package:flutter/material.dart';
import 'package:meal_monkey/layouts/HomeScreen/home_layout.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  @required
  String image;
  @required
  String title;
  @required
  String body1;
  @required
  String body2;
  BoardingModel(this.image, this.title, this.body1, this.body2);
}

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        'assets/images/Find food you love vector.png',
        'Find Food You Love',
        'Discover the best foods from over 1,000',
        'restaurants and fast delivery to your doorstep'),
    BoardingModel('assets/images/Delivery vector.png', 'Fast Delivery',
        'Fast food delivery to your home, office', 'wherever you are'),
    BoardingModel(
        'assets/images/Live tracking vector.png',
        'Live Tracking',
        'Real time tracking of your food on the app',
        'once you placed the order'),
  ];
  var pagecontroller = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: pagecontroller,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: boarding.length,
                    itemBuilder: (context, index) =>
                        buildPageItem(boarding[index])),
              ),
              defaultButton(
                  isUpperCase: false,
                  radius: 30,
                  function: () {
                    if (isLast) {
                      skipBoarding();
                    } else {
                      pagecontroller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear);
                    }
                  },
                  text: 'Next'),
              SizedBox(
                height: 50,
              ),
            ],
          )),
    );
  }

  Widget buildPageItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('${model.image}')),
          SizedBox(
            height: 40,
          ),
          SmoothPageIndicator(
            controller: pagecontroller,
            count: boarding.length,
            effect: ExpandingDotsEffect(
              dotColor: Color(0xFFD6D6D6),
              activeDotColor: defaultColor,
              dotHeight: 10,
              expansionFactor: 1.01,
              spacing: 5,
              dotWidth: 10,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '${model.title}',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '${model.body1} ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${model.body2} ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );

  void skipBoarding() {
    CacheHelper.putData(key: 'isOnBoarding', value: true);

    navigateAndFinsh(context, HomeLayOut());
  }
}
