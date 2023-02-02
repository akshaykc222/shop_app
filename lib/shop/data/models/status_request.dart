class OfflineStatusRequest {
  final String status;
  final String? opensIn;

  OfflineStatusRequest({required this.status, required this.opensIn});

  toJson() => {
        "status": status,
        "opens_in": opensIn,
      };
}
