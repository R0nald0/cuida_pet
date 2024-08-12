

import 'package:cuidapet/app/module/home/home_controller.dart';
import 'package:cuidapet/core/helpers/debaunce.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';

import 'package:flutter/material.dart';

class HomeAppbar extends SliverAppBar{
   final HomeController controller;
   HomeAppbar({super.key, required this.controller }): super(
     expandedHeight: 100,
     collapsedHeight: 100,
   flexibleSpace:  _CuidaPetAppBar(controller:controller ,),
     pinned: true
  );
  
}


class _CuidaPetAppBar extends StatelessWidget {
   final HomeController controller ;
   final debounce = Debaunce(milliseconds: 500);
    _CuidaPetAppBar({required this.controller}):super();
  
  @override
  Widget build(BuildContext context) {
   final outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.green[200]!)
   );

     return AppBar(
      title: const Padding(
        padding: EdgeInsets.only( bottom: 12.0),
        child: Text("Cuida Pet"),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
         IconButton(onPressed:() {controller.goToAddressPage();}, icon: const Icon(Icons.location_on))
      ],
      flexibleSpace: Stack(
         children: [
          Container(
            height: 110.h.toDouble(),
            color: context.primaryColor,
          ),
           Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: .9.sw.toDouble(),
              child:  Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: TextField(
                  onChanged: (value) {
                    debounce.run(() { 
                      controller.filterByName(value);
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search ,size: 25,)),
                    border: outlinedBorder,
                    enabledBorder: outlinedBorder,
                    focusedBorder: outlinedBorder
                  ),
                ),
              ),
            ),
          )
         ],
         
        ),
      backgroundColor: Colors.grey[100],
      
     );
  }
    
}