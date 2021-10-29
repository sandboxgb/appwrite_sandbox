import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.margin = EdgeInsets.zero,
    required this.child,
    required this.onPressed,
    this.color = Colors.white,
    this.width = double.infinity,
    this.height = 50,
  }) : super(key: key);

  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: ElevatedButton(
        child: widget.child,
        onPressed: widget.onPressed,
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size(widget.width, widget.height)),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => widget.color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
