import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/delivery_area_bloc/delivery_area_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

class DeliveryArea extends StatefulWidget {
  const DeliveryArea({super.key});

  @override
  State<DeliveryArea> createState() => _DeliveryAreaState();
}

class _DeliveryAreaState extends State<DeliveryArea> {
  late DeliveryAreaBloc deliveryAreaBloc;
  var scrollController = ScrollController();

  @override
  void initState() {
    deliveryAreaBloc = DeliveryAreaBloc.get(context);
    deliveryAreaBloc.add(GetDeliveryAreaEvent());
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      deliveryAreaBloc.add(GetPaginatedAreaEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ))),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Delivery Area's",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              const Expanded(child: SizedBox())
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppPages.deliveryAreaAdd);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<DeliveryAreaBloc, DeliveryAreaState>(
        builder: (context, state) {
          return state is DeliveryAreaLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is DeliveryAreaLoaded
                  ? ListView.builder(
                      controller: scrollController,
                      itemCount: state.data.length + 1,
                      itemBuilder: (context, index) => index >=
                              state.data.length
                          ? state is PageLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                            AppPages.deliveryAreaAdd,
                                            extra: state.data[index]);
                                      },
                                      title: Text(state.data[index].name),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(state.data[index].pinCode),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Delivery : ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: state.data[index]
                                                            .deliveryAvialble
                                                        ? 'On'
                                                        : 'Off',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: state.data[index]
                                                                .deliveryAvialble
                                                            ? Colors.green
                                                            : Colors.red)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      trailing: Column(
                                        children: [
                                          state.data[index].codAvialble
                                              ? const Text(
                                                  "COD",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(height: 5),
                                          Text(
                                              "Delivery Charge : ${state.data[index].deliveryCharge}")
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            deleteDialog(
                                                title: "Delete Area",
                                                message:
                                                    "Are you sure you want to delete ${state.data[index].name}",
                                                delete: () {},
                                                context: context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              AppAssets.delete,
                                              width: 25,
                                              height: 25,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ))
                  : const SizedBox();
        },
      ),
    );
  }
}
