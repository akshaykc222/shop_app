class OrderStatusChange {
  final String id;
  final String status;

  OrderStatusChange(this.id, this.status);
  toJson() => {"order_id": id, "status": status};
}
