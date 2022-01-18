import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/CartScreen/cart_screen.dart';
import 'package:meal_monkey/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        bool isPassword = false,
        required String? Function(String? val)? validate,
        double radius = 0.0,
        required String label,
        IconData? prefix,
        IconData? suffix,
        Function? suffixPressed,
        bool isClickable = true,
        double width = double.infinity}) =>
    Container(
      width: width,
      height: 56,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: (e) {
          if (onSubmit != null) onSubmit(e);
        },
        validator: validate,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.amber,
          ),
          border: InputBorder.none,
          labelText: label,
          hintText: label,
          prefixIcon: Icon(
            prefix,
          ),
          hintStyle: TextStyle(
              fontFamily: 'Metropolis-Regular',
              fontSize: 16,
              color: placeholder),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 60,
  Color backgroundColor = mainColor,
  Color borderColor = mainColor,
  Color fontColor = Colors.white,
  bool isUpperCase = true,
  String fontFamily = 'Metropolis-SemiBold',
  double radius = 3.0,
  double borderWidth = 0,
  double fontSize = 16.0,
  required Function function,
  required String text,
  IconData? prefix,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null)
              FaIcon(
                prefix,
                size: 20,
                color: Color(0xFFffffff),
              ),
            if (prefix != null)
              SizedBox(
                width: 20,
              ),
            Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                  color: fontColor, fontSize: fontSize, fontFamily: fontFamily),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
    );

IconButton cartIcon(
    {required BuildContext context, Color color = primaryFontColor}) {
  return IconButton(
    icon: Icon(
      FontAwesomeIcons.shoppingCart,
      color: color,
      size: 25,
    ),
    onPressed: () {
      navigateTo(context, CartScreen());
    },
  );
}

Widget mySeparator() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[500],
    );
void showToast({
  required String msg,
}) async =>
    await Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.deepOrange,
        fontSize: 16.0);
