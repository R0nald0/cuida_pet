
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:flutter/material.dart';
  
class RoundedButtonWithIcon extends StatelessWidget {
   final GestureTapCallback onTap;
   final double width;
   final Color color;
   final IconData icon;
   final String label;
  const RoundedButtonWithIcon({ 
    Key? key,
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.width,
  
     }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
       width: width,
       height: 45.h.toDouble(),
       padding:  const EdgeInsets.symmetric(horizontal: 10),
       decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
       ),
       child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 2),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.w.toDouble(),
            ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: VerticalDivider(
                color: Colors.white,
                thickness: 2.0),
              ),
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp.toDouble()
                ),
                ),
            )
        ],
       ),
      ),
    );
  }
}