class Treatment {
  final int id;
  final String name;
  final String price;

  Treatment({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
