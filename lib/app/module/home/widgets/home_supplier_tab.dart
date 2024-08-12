part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {
  final HomeController homeController;
  const _HomeSupplierTab({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(
          homeController: homeController,
        ),
        Expanded(
          child: Observer(builder: (_) {
            return AnimatedSwitcher(
                duration: const Duration(microseconds: 400),
                child: homeController.supplierPageType == SupplierPageType.list
                    ? _HomeSupplierList(
                        homeController: homeController,
                      )
                    : _HomeSupplierGrid(
                        homeController: homeController,
                      ));
          }),
        )
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {
  final HomeController homeController;
  const _HomeTabHeader({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Estabelecimento'),
        const Spacer(),
        InkWell(
          onTap: () {
            homeController.changeTabSuppplier(SupplierPageType.list);
          },
          child: Observer(
            builder: (_) {
              return Icon(
                Icons.view_headline,
                color: homeController.supplierPageType == SupplierPageType.list
                    ? Colors.black
                    : Colors.grey,
              );
            },
          ),
        ),
        InkWell(
          onTap: () {
            homeController.changeTabSuppplier(SupplierPageType.grid);
          },
          child: Observer(
            builder: (_) {
              return Icon(
                Icons.view_comfy,
                color: homeController.supplierPageType == SupplierPageType.grid
                    ? Colors.black
                    : Colors.grey,
              );
            },
          ),
        )
      ],
    );
  }
}

class _HomeSupplierList extends StatelessWidget {
  final HomeController homeController;
  const _HomeSupplierList({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(builder: (_) {
          return SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: homeController.supplierListNears.length,
                  (context, index) {
            final supplerNearModel = homeController.supplierListNears[index];
            return HomeSupplierItemList(
                supplierNearByMeModel: supplerNearModel);
          }));
        })
      ],
    );
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  final HomeController homeController;
  const _HomeSupplierGrid({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) {
            return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                childCount: homeController.supplierListNears.length,
                  (context, index) {
                    final supplierNear = homeController.supplierListNears[index];
                    return _HomeSupplierCardItem(supplierNearByMeModel: supplierNear,);
                  },
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                    
                    ));
          }
        )
      ],
    );
  }
}

class _HomeSupplierCardItem extends StatelessWidget {
  final SupplierNearByMeModel supplierNearByMeModel;
  const _HomeSupplierCardItem({required this.supplierNearByMeModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(RouterCuidaPet.SUPLLIER_MODULE_ROUTE,arguments: supplierNearByMeModel.id);
      },
      child: Stack(
        children: [
          Card(
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox.expand(
              child:  Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 15, right: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                       supplierNearByMeModel.name,
                       style: context.textThem.titleMedium,
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                      ),
                    Text(
                      '${supplierNearByMeModel.distance.toStringAsFixed(2)} km de distância',
                      overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
           Positioned(
              top: 4,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(supplierNearByMeModel.logo),
                ),
              ))
        ],
      ),
    );
  }
}

class HomeSupplierItemList extends StatelessWidget {
  final SupplierNearByMeModel supplierNearByMeModel;
  const HomeSupplierItemList({super.key, required this.supplierNearByMeModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(RouterCuidaPet.SUPLLIER_MODULE_ROUTE,arguments: supplierNearByMeModel.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              width: 1.sw.toDouble(),
              height: 80.h.toDouble(),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          supplierNearByMeModel.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(
                                '${supplierNearByMeModel.distance.toStringAsFixed(2)} km de distância')
                          ],
                        )
                      ],
                    ),
                  )),
                  CircleAvatar(
                    backgroundColor: context.primaryColor,
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        Modular.to.pushNamed(RouterCuidaPet.SUPLLIER_MODULE_ROUTE,arguments: supplierNearByMeModel.id);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100]!, width: 5),
                    color: Colors.grey[100]!,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: NetworkImage(supplierNearByMeModel.logo),
                        fit: BoxFit.contain)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
