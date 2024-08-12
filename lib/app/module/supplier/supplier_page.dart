import 'package:cuidapet/app/module/supplier/supplier_controller.dart';
import 'package:cuidapet/app/module/supplier/widgets/service_supplier_widget.dart';
import 'package:cuidapet/app/module/supplier/widgets/supplier_detail.dart';
import 'package:cuidapet/core/life_cycle/page_lificycle_state.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class SupplierPage extends StatefulWidget {
  final int _idSupplier;
  const SupplierPage({super.key, required int supplierId})
      : _idSupplier = supplierId;

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState
    extends PageLificycleState<SupplierController, SupplierPage> {
  @override
  Map<String, dynamic>? get param => {'supplierId': widget._idSupplier};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Observer(
        builder: (_) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: controller.totalServicesSelected > 0 ? 1 : 0,
            child: Visibility(
              visible: controller.totalServicesSelected > 0,
              child: FloatingActionButton.extended(
                onPressed:controller.goToSchedulePage,
                label: const Text(
                  "Fazer Agendamento",
                ),
                icon: const Icon(Icons.schedule),
                backgroundColor: context.primaryColor,
              ),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Observer(builder: (_) {
        final supplier = controller.supplierModel;
        if (supplier == null) {
          return  Center(
            child: Column(
            
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Buscandoo dados do fornecedor...'),
                 CircularProgressIndicator( color: context.primaryColor,)
              ] 
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.4,
                titlePadding: const EdgeInsets.only(left: 50, bottom: 15),
                title: Text(
                  supplier.name,
                  style: TextStyle(
                      fontSize: 18.sp.toDouble(),
                      fontWeight: FontWeight.bold, 
                      color: Colors.white
                      ),
                   overflow: TextOverflow.ellipsis, 
                  textAlign: TextAlign.center,
                ),
                stretchModes: const [
                  StretchMode.fadeTitle,
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      supplier.logo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black.withAlpha(100),
                                  const Color.fromARGB(255, 139, 132, 132)
                                      .withAlpha(100)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter)),
                      ),
                    )
                  ],
                ),
              ),
            ),
             SliverToBoxAdapter(
              child: SupplierDetail(
                supplierModel: supplier,
                onCall:controller.goToPhoneOrCopyToClipBoardData,
                onGotoGeo: controller.goToGeoOrClipBoardAddres,
              ),
            ),
             SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  'Serviços ( ${controller.totalServicesSelected} Selecionado${controller.totalServicesSelected > 1 ? 's':''} )',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: controller.suppllierServices.length,
              (context, index) {
                 final supplierService = controller.suppllierServices[index];
                return ServiceSupplierWidget(
                   serviceModel: supplierService,
                   controllerServiceSupplier : controller
                );
              },
            ))
          ],
        );
      }),
    );
  }
}
