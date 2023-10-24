import 'package:flutter/material.dart';

class SahaButtonFullParent extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final Color? textColor;
  final Color? color;
  final Color? colorBorder;
  final bool? isLoading;

  const SahaButtonFullParent(
      {Key? key,
      this.onPressed,
      this.text,
      this.textColor,
      this.color,
      this.colorBorder,
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isLoading == true ? Colors.grey : color,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            side: colorBorder == null
                ? const BorderSide(width: 0, color: Colors.transparent)
                : BorderSide(
                    width: 1.0,
                    color: colorBorder!,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (isLoading == true || onPressed == null) {
            return;
          }

          onPressed!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 3, bottom: 3),
                  child: Text(
                    "$text",
                    style: TextStyle(
                        color: textColor ??
                            Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SahaButtonSizeChild extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final Color? textColor;
  final Color? color;
  final double? width;
  final double? height;

  const SahaButtonSizeChild(
      {Key? key,
      this.onPressed,
      this.text,
      this.textColor,
      this.color,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: MaterialButton(
        minWidth: width,
        height: height,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        color: onPressed == null
            ? Colors.grey
            : (color ?? Theme.of(context).primaryColor),
        onPressed: () {
          onPressed!();
        },
        child: Text(
          "$text",
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
class ViewProfileBTN extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const ViewProfileBTN({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(100),
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(10)),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            onPressed!();
          },
          child:  Text(
            text,
            style: const TextStyle(color: Colors.deepOrange),

          ),
        ),
      ),
    );
  }
}
