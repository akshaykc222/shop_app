import 'package:shop_app/shop/data/models/requests/deliver_man_adding_request.dart';
import 'package:shop_app/shop/data/models/requests/delivery_man_list_request.dart';

import '../../data/models/deliveryman_detail_model.dart';
import '../../data/models/deliveryman_model.dart';

abstract class DeliveryManRepository {
  Future<DeliverymanList> deliverymanList(DeliveryManListRequest request);
  Future<String> addDeliveryMan(DeliveryManAddRequest request);
  Future<String> updateDeliveryMan(DeliveryManAddRequest request);
  Future<DeliveryManDetailModel> getDeliveryManDetail(int id);
}
