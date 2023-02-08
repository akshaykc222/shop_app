import 'package:dio/dio.dart';
import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/requests/deliver_man_adding_request.dart';
import 'package:shop_app/shop/data/models/requests/delivery_man_list_request.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';

import '../../models/deliveryman_detail_model.dart';
import '../../models/deliveryman_model.dart';

abstract class DeliveryManDataSource {
  Future<DeliverymanList> deliverymanList(DeliveryManListRequest request);
  Future<String> addDeliveryMan(DeliveryManAddRequest request);
  Future<String> updateDeliveryMan(DeliveryManAddRequest request);
  Future<DeliveryManDetailModel> getDeliveryManDetail(int id);
}

class DeliverManDataSourceImpl extends DeliveryManDataSource {
  final ApiProvider apiProvider;

  DeliverManDataSourceImpl(this.apiProvider);

  @override
  Future<DeliverymanList> deliverymanList(
      DeliveryManListRequest request) async {
    final data = await apiProvider.get(
        "${AppRemoteRoutes.deliveryMan}/list?q=${request.query}&date_sort=${request.dateSort}&page_no=${request.page}");
    return DeliverymanList.fromJson(data);
  }

  @override
  Future<String> addDeliveryMan(DeliveryManAddRequest request) async {
    prettyPrint((await request.toJson()).toString());
    final data = await apiProvider.post(
        "${AppRemoteRoutes.deliveryMan}/add", {},
        formBody: FormData.fromMap(await request.toJson()));
    return data.toString();
  }

  @override
  Future<String> updateDeliveryMan(DeliveryManAddRequest request) async {
    final data = await apiProvider.post(
        "${AppRemoteRoutes.deliveryMan}/update/${request.id}", {},
        formBody: FormData.fromMap(await request.toJson()));
    return data.toString();
  }

  @override
  Future<DeliveryManDetailModel> getDeliveryManDetail(int id) async {
    final data =
        await apiProvider.get("${AppRemoteRoutes.deliveryManEdit}/$id");
    return DeliveryManDetailModel.fromJson(data['delivery_man']);
  }
}
