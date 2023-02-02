class OrderStatusChange {
  final int id;
  final String status;

  OrderStatusChange(this.id, this.status);
  toJson() => {"order_id": id, "status": status};
}
