import 'package:cuidapet/app/models/supplier_category_model.dart';
import 'package:cuidapet/app/models/supplier_near_by_me_model.dart';
import 'package:cuidapet/app/module/home/home_controller.dart';
import 'package:cuidapet/app/module/home/widgets/home_appbar.dart';
import 'package:cuidapet/core/life_cycle/page_lificycle_state.dart';
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';

import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'widgets/home_address_widget.dart';
part 'widgets/home_addres_category_widget.dart';
part 'widgets/home_supplier_tab.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends PageLificycleState<HomeController, HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
      headerSliverBuilder: ((context, innerBoxIsScrolled) {
        return <Widget>[
            HomeAppbar(controller: controller, ),
            SliverToBoxAdapter(
            child: HomeAddressWidget(
               controller: controller ,
              ),
           ),
           SliverToBoxAdapter(
            child: HomeAddresCategoryWidget(controller: controller,)
           )
        ];
      }), 
      body:  _HomeSupplierTab(homeController: controller,)
      )
    );
  }
}
