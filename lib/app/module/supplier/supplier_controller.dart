import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/models/supplier_service_model.dart';
import 'package:cuidapet/app/module/schedule/schedule_view_model.dart';
import 'package:cuidapet/app/service/supplier/supplier_category_service.dart';
import 'package:cuidapet/core/life_cycle/controller_lifecylce.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';
part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifecylce {
  final SupplierCategoryService _supplierService;
  final AppLogger _log;

  SupplierControllerBase(
      {required SupplierCategoryService serviceSupplier,
      required AppLogger appLoger})
      : _supplierService = serviceSupplier,
        _log = appLoger,
        super();

  int _supplerId = 0;
  @readonly
  SupplierModel? _supplierModel;

  @readonly
  var _suppllierServices = <SupplierServiceModel>[];

  @readonly 
  var _supplierServicesSelceted = <SupplierServiceModel>[].asObservable();

  @override
  void onInit([Map<String, dynamic>? params]) {
    super.onInit(params);

    _supplerId = params?['supplierId'] ?? 0;
  }

  @override
  void onReady() {
    super.onReady();
    try {
  Loader.show();
  Future.wait([
    findSupplierById(),
    findSupplierService()
  ]);
} finally {
  Loader.hide();
}
  }

  @action
  Future<void> findSupplierById() async {
    try {
      _supplierModel = await _supplierService.findByid(_supplerId);
    } catch (e, s) {
      const message = 'Erro ao buscar Supplier';
      _log.error(message, e, s);
      Message.alert(message);
    }
  }

   @action
  Future<void> findSupplierService() async {
    try {
      _suppllierServices =
          await _supplierService.findSupplierService(_supplerId);
        
    } catch (e, s) {
      const message = 'Erro ao buscar serviços do Supplier';
      _log.error(message, e, s);
      Message.alert(message);
    }
  }


    @action  
   void addOrRemoveService(SupplierServiceModel modelSerivice) {
     if (isServiceSelected(modelSerivice)) {
         _supplierServicesSelceted.remove(modelSerivice);
     } else {
        _supplierServicesSelceted.add(modelSerivice);
     }
  }
   
   bool isServiceSelected(SupplierServiceModel model) => _supplierServicesSelceted.contains(model);

   int get totalServicesSelected => _supplierServicesSelceted.length;

   Future<void> goToPhoneOrCopyToClipBoardData() async{
      final phoneUrl = 'tel:${_supplierModel?.phone}';

      if (await canLaunchUrlString(phoneUrl)) {
          launchUrlString(phoneUrl);
      } else {
        await Clipboard.setData(ClipboardData(text: _supplierModel?.phone ?? ''));
         Message.info('Telefone Copiaddo');
      }
   }

   Future<void> goToGeoOrClipBoardAddres()async{
     final geo = 'geo:${_supplierModel?.lat},${_supplierModel?.lng}';
     if (await canLaunchUrlString(geo)) {
        launchUrlString(geo);
     } else {
        Clipboard.setData(ClipboardData(text: _supplierModel?.address  ?? ''));
        Message.info('Endereço copiado');
     }
   } 

   Future<void> goToSchedulePage() async{
      Modular.to.pushNamed(
         RouterCuidaPet.SCHEDULE_MODULE_ROUTE,
        arguments: ScheduleViewModel(
          idSupplier: _supplerId, services: _supplierServicesSelceted.toList())
      );
   }
}
