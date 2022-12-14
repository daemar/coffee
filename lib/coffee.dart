import 'dart:math';

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + 1;
final random = Random();
final coffees = List.generate(
    _names.length,
    (index) => Coffee(
          image: 'assets/coffee/${index + 1}.png',
          name: _names[index],
          price: _doubleInRange(random, 3, 7),
        ));

class Coffee {
  final String name;
  final String image;
  final double price;
  int? qty;
  Coffee({required this.image, required this.price, required this.name});
}

final _names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];
