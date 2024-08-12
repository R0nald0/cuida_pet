
part of '../address_page.dart';
class AddressItem extends StatelessWidget {
final String address;
final String addtional ;
final VoidCallback onTap;

  const AddressItem({required this.address,required this.addtional ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.symmetric(vertical: 10),
      child:  ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
            ),
        ),
        title: Text(address),
        subtitle: Text(addtional),
      ),
    );
  }
}