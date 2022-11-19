import 'package:coffee/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeDetail extends StatelessWidget {
  const CoffeeDetail({super.key, required this.coffee});

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.shopping_bag_outlined, color: Colors.black))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: Hero(
              tag: "text_${coffee.name}",
              child: Material(
                child: Text(coffee.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned(
                    left: size.width * 0.85,
                    child: const Icon(Icons.add_box_outlined,
                        color: Colors.black, size: 30)),
                Positioned.fill(
                  child: Hero(
                      tag: coffee.name,
                      child: Image.asset(coffee.image, fit: BoxFit.fitHeight)),
                ),
                Positioned(
                    left: size.width * 0.05,
                    bottom: 0,
                    child: TweenAnimationBuilder(
                      tween: Tween(begin: 1.0, end: 0.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                            offset: Offset(-100 * value, 240 * value),
                            child: child);
                      },
                      duration: const Duration(milliseconds: 500),
                      child: Text('\$${coffee.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  spreadRadius: 20,
                                ),
                              ])),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
