void main() {
  List<Map<String, dynamic>> products = [
    {'name': 'Celular', 'price': 3000000.0, 'discount': 0.20, 'iva': 0.19},
    {'name': 'Laptop', 'price': 2000000.0, 'discount': 0.15, 'iva': 0.19},
    {'name': 'Keyboard', 'price': 500000.0, 'discount': 0.10, 'iva': 0.19}
  ];

  for (var product in products) {
    double price = product['price'];
    double discount = product['discount'];
    double iva = product['iva'];

    double finalPrice = calcularPrecioFinal(price, discount, iva);

    print(
        'El producto: ${product['name']} tiene un precio final de: ${finalPrice}');
  }
}

double calcularPrecioFinal(double price, double discount, double iva) {
  double discountAmount = price * discount;
  double ivaAmount = price * iva;
  double finalPrice = price - discountAmount + ivaAmount;
  return finalPrice;
}