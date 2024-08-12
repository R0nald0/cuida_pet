import 'package:cuidapet/app/models/supplier_service_model.dart';
import 'package:cuidapet/app/module/supplier/supplier_controller.dart';
import 'package:cuidapet/core/helpers/text_formatter.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ServiceSupplierWidget extends StatelessWidget {
  final SupplierServiceModel serviceModel;
  final SupplierController controllerServiceSupplier;
  const ServiceSupplierWidget(
      {super.key,
      required this.serviceModel,
      required  this.controllerServiceSupplier});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(serviceModel.name),
        leading: CircleAvatar(
          backgroundColor: context.primaryColorLight,
          child: const Icon(Icons.pets),
        ),
        subtitle: Text(TextFormatter.formatReal(serviceModel.price)),
        trailing: Observer(
          builder: (_) {
            return IconButton(
              onPressed: () {
                controllerServiceSupplier.addOrRemoveService(serviceModel);
              },
              icon: controllerServiceSupplier.isServiceSelected(serviceModel) 
              ? const Icon(Icons.remove_circle, size: 30, color: Colors.red)
              :Icon(Icons.add_circle, size: 30, color: context.primaryColor),
            );
          }
        ));
  }
}
