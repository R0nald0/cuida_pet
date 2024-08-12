part of '../home_page.dart';    
class HomeAddressWidget extends StatelessWidget {
  final HomeController controller;

   const HomeAddressWidget({ super.key,required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
            const Text("Estabelecimentos próximos de "),
            Observer(
              builder: (_){
                return Text(
                 controller.addressEntity?.address ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              );
              })
            
        ],
      ),
    );
  }
}