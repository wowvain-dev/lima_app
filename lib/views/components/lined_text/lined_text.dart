/// Flutter
import 'package:flutter/material.dart';

class LinedText extends StatelessWidget {
  LinedText(
  this.text, 
  {
    this.thickness, 
    this.textStyle, 
    this.lineColor,
    this.leftFlex = 1, 
    this.rightFlex = 1,
    this.textAlign = TextAlign.center,
  }); 

  String? text;
  double? thickness;
  Color? lineColor;
  TextAlign textAlign;
  TextStyle? textStyle;
  int leftFlex = 1;
  int rightFlex = 1;

  @override 
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: leftFlex,
          child: Container(
            child: Divider(
              thickness: thickness ?? 1,
              color: lineColor ?? Colors.white, 
            )
          )
        ), 
        Text(text ?? '',
          style: textStyle ?? TextStyle(color: Colors.white, fontSize: 20), 
          textAlign: textAlign
        ), 
        Flexible(
          flex: rightFlex,
          child: Container(
            child: Divider(
              thickness: thickness ?? 1,
              color: lineColor ?? Colors.white, 
            )
          )
        ), 
      ]
    );
  }
}