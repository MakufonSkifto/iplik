import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final Icon? icon;
  final Color? textColor;
  final Function() onTap;

  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    this.icon,
    this.textColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Color(0x65919191),
              spreadRadius: 0.01,
              blurRadius: 8,
              offset: Offset(0.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox(),
              const SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(fontSize: 15, color: textColor ?? Colors.white)
              ),
            ],
          ),
        ),
      ),
    );
  }

}