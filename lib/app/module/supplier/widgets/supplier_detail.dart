import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:flutter/material.dart';

class SupplierDetail extends StatelessWidget {
  final SupplierModel supplierModel;
  final Function()? onCall;
  final Function()? onGotoGeo;
  const SupplierDetail(
      {super.key, required this.supplierModel, required this.onCall,required this.onGotoGeo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informações do estabelicimento",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: onGotoGeo,
            title: Text(supplierModel.address),
            leading: const Icon(
              Icons.location_city,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: onCall,
            title: Text(supplierModel.phone),
            leading: const Icon(
              Icons.phone,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
