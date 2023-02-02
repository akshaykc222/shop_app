import 'package:shop_app/shop/data/data_sources/remote/deliveryman_data_source.dart';
import 'package:shop_app/shop/data/models/deliveryman_detail_model.dart';
import 'package:shop_app/shop/data/models/deliveryman_model.dart';
import 'package:shop_app/shop/data/models/requests/deliver_man_adding_request.dart';
import 'package:shop_app/shop/data/models/requests/delivery_man_list_request.dart';
import 'package:shop_app/shop/domain/repositories/deliveryman_repository.dart';

class DeliveryManRepositoryImpl extends DeliveryManRepository {
  final DeliveryManDataSource dataSource;

  DeliveryManRepositoryImpl(this.dataSource);

  @override
  Future<DeliverymanList> deliverymanList(DeliveryManListRequest request) {
    return dataSource.deliverymanList(request);
  }

  @override
  Future<String> addDeliveryMan(DeliveryManAddRequest request) {
    return dataSource.addDeliveryMan(request);
  }

  @override
  Future<String> updateDeliveryMan(DeliveryManAddRequest request) {
    return dataSource.updateDeliveryMan(request);
  }

  @override
  Future<DeliveryManDetailModel> getDeliveryManDetail(int id) {
    return dataSource.getDeliveryManDetail(id);
  }
}
