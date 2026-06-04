class OrderModel {
  final String id;
  final String createdAt;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String paymentMethod;
  final List<Map<String, dynamic>> items;

  const OrderModel({
    required this.id,
    required this.createdAt,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.items,
  });

  int get itemCount => items.fold<int>(
        0,
        (sum, item) => sum + ((item['quantity'] as int?) ?? 1),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'totalAmount': totalAmount,
      'status': status,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'items': items,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'processing',
      deliveryAddress: json['deliveryAddress'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      items: json['items'] != null
          ? List<Map<String, dynamic>>.from(
              (json['items'] as List).map(
                (e) => Map<String, dynamic>.from(e as Map),
              ),
            )
          : [],
    );
  }
}
