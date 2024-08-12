import 'dart:convert';

import 'package:cuidapet/app/models/supplier_service_model.dart';

class ScheduleViewModel {
  ScheduleViewModel({
    required this.idSupplier,
    required this.services
  });
  final int idSupplier;
  final List<SupplierServiceModel> services;


  Map<String, dynamic> toMap() {
    return {
      'idSupplier': idSupplier,
      'services': services.map((x) => x.toMap()).toList(),
    };
  }

  factory ScheduleViewModel.fromMap(Map<String, dynamic> map) {
    return ScheduleViewModel(
      idSupplier: map['idSupplier']?.toInt() ?? 0,
      services: List<SupplierServiceModel>.from(map['services']?.map((x) => SupplierServiceModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleViewModel.fromJson(String source) => ScheduleViewModel.fromMap(json.decode(source));
}
