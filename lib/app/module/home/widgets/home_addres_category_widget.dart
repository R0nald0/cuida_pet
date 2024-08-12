

 part of'../home_page.dart';    
class HomeAddresCategoryWidget extends StatelessWidget {
  final HomeController controller;
  const HomeAddresCategoryWidget({super.key,  required this.controller}) ;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Observer(
         builder:  (_){ 
        return Center(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.listCategories.length,
            itemBuilder:(context, index) {
               final category = controller.listCategories[index];
               return CategoryItem(categoryModel: category , controller: controller ,);
            }, ),
          );
        }
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
final SupplierCategoryModel categoryModel;
 final HomeController controller;

  const CategoryItem({super.key, required this.categoryModel  ,required this.controller});
  
  static const categoriesIcons = {
    'P' : Icons.pets,
    'V' : Icons.local_hospital,
    'C'  : Icons.store_mall_directory
  } ;

  @override
  Widget build(BuildContext context) {
       return InkWell(
        onTap: (){
            controller.filterSupplierCategory(categoryModel);
        },
         child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Observer(
                builder: (_) {
                  return CircleAvatar(
                  radius: 30,
                    backgroundColor: controller.supplierFilerSelected?.id == categoryModel.id 
                     ? context.primaryColor
                     :context.primaryColorLight,
                    child: Icon(
                       categoriesIcons[categoryModel.type],
                      color: Colors.black,
                      size: 30,
                      ),
                  );
                }
              ),
              const SizedBox(
                 height: 10,
              ),
               Text(categoryModel.name)
            ],
          ),
         ),
       );
  }
  
}