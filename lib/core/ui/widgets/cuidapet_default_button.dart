import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
    
class CuidapetDefaultButton extends StatelessWidget {
  final String label;
  final  VoidCallback? onPressed;
  final double borderRadius;
  final Color? color;
  final Color? labelColor;
  final double labelSize;
  final double padding;
 final double width;
 final double height;
  
  const CuidapetDefaultButton({ 
    Key? key, 
    required this.onPressed,
    required this.label,
    this.color,
    this.labelColor,
    this.borderRadius =10,
    this.labelSize = 20,
    this.padding = 10,
    this.width = double.infinity,
    this.height = 66
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
       width: width,
       height: height,
       child: ElevatedButton(
        onPressed: onPressed,
        style:ElevatedButton.styleFrom(
          backgroundColor:color ?? context.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        )  ,
        child:Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor?? Colors.white
          ),
        ),
        ),
    );
  }
}