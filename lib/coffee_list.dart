import 'package:coffee/coffee.dart';
import 'package:coffee/coffee_detail.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class CoffeeList extends StatefulWidget {
  const CoffeeList({super.key});

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final _pageTextController = PageController(initialPage: _initialPage.toInt());
  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page!;
    });
  }

  void _textScrollListener() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeScrollListener);
    _pageCoffeeController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Stack(children: [
        Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.2,
            height: size.height * 0.3,
            child: const DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Colors.brown,
                blurRadius: 90,
                spreadRadius: 45,
              )
            ]))),
        Transform.scale(
          scale: 1.6,
          alignment: Alignment.bottomCenter,
          child: PageView.builder(
              controller: _pageCoffeeController,
              scrollDirection: Axis.vertical,
              itemCount: coffees.length,
              onPageChanged: (value) {
                if (value < coffees.length) {
                  _pageTextController.animateToPage(value,
                      duration: _duration, curve: Curves.easeOut);
                }
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final coffee = coffees[index - 1];
                print(coffee.image);
                final result = _currentPage - index + 1;
                print('RESULTADO:  ${result}');
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: CoffeeDetail(
                              coffee: coffee,
                            ),
                          );
                        }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                            1.0,
                            MediaQuery.of(context).size.height /
                                2.6 *
                                (1 - value).abs(),
                          )
                          ..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: coffee.name,
                              child: Image.asset(coffee.image,
                                  fit: BoxFit.fitHeight),
                            ))),
                  ),
                );
              }),
        ),
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: TweenAnimationBuilder(
              tween: Tween(begin: 1.0, end: 0.0),
              builder: (context, value, child) {
                return Transform.translate(
                    offset: Offset(0.0, -100 * value), child: child);
              },
              duration: _duration,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageTextController,
                        itemCount: coffees.length,
                        itemBuilder: (context, index) {
                          final opacity =
                              (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                          print(coffees[index].name);
                          return Opacity(
                            opacity: opacity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.2),
                              child: Hero(
                                tag: "text_${coffees[index].name}",
                                child: Material(
                                  child: Text(
                                    coffees[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  AnimatedSwitcher(
                    duration: _duration,
                    child: Text(
                      '\$ ${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}',
                      key: Key(coffees[_currentPage.toInt()].name),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
      ]),
    );
  }
}
