import 'package:flutter/material.dart';

import 'constants.dart';

var kUnpressedShadow =
const BoxShadow(
    color: Colors.black,
    spreadRadius: 0,
    blurRadius: 0,
    offset: Offset(3, 2)
);

class CustomIconButton extends StatelessWidget {
  final onPressed;
  final Image icon;
  final Color backgroundColor;
  final double width;
  final double height;
  CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.blueAccent
  });


  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              width: 2.0,
              color: Colors.black,
            ),
            boxShadow: [kUnpressedShadow],
        ),
        child: IconButton(
          padding: const EdgeInsets.all(0.0),
          icon: icon,
          onPressed: onPressed,
    )
    );
    }
  }

class CustomTextField extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const CustomTextField({super.key, required this.text, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Colors.black,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(3, 2)
            )
          ]
      ),
      constraints: const BoxConstraints(
          maxWidth: 120
      ),
      height: 40,
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            fillColor: backgroundColor,
            filled: true
        ),
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kCommonAppBarMargin,
      child: CustomIconButton(
        icon: Image.asset('assets/icons/arrow.png', width: 27, height: 20),
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: kMainColor,
        width: 44,
        height: 42,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final onPressed;
  final Text text;
  Color color;

  CustomTextButton({super.key, required this.onPressed, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
              width: 3.0,
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            boxShadow: const [
              boxShadow
            ]
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(15, 19, 15, 19),
          ),
          onPressed: onPressed,
          child: text,
        )
    );
  }
}