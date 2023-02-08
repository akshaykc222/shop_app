class EditOrderDetailModel {
  EditOrderDetailModel(
      {required this.productData,
      required this.orderId,
      required this.editReason});

  List<ProductDatum> productData;
  final int orderId;
  final String editReason;
  Map<String, dynamic> toJson() => {
        "edit_reason": editReason,
        "product_data": List<dynamic>.from(productData.map((x) => x.toJson())),
      };
}

class ProductDatum {
  ProductDatum({
    required this.id,
    required this.quantity,
  });

  String id;
  String quantity;

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}
