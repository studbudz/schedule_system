import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardSwipeScreen(),
    );
  }
}

class CardSwipeScreen extends StatefulWidget {
  @override
  _CardSwipeScreenState createState() => _CardSwipeScreenState();
}

class _CardSwipeScreenState extends State<CardSwipeScreen> {
  PageController _pageController = PageController(viewportFraction: 0.7);
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
  }

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 5,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              double scale =
                  1 - (0.2 * (currentPage - index).abs()).clamp(0, 1);
              return Transform.scale(
                scale: scale,
                child: CardItem(title: "Event ${index + 1}"),
              );
            },
          ),
          Positioned(
            left: 20,
            child: FloatingActionButton(
              onPressed: previousPage,
              mini: true,
              backgroundColor: Colors.red,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Positioned(
            right: 20,
            child: FloatingActionButton(
              onPressed: nextPage,
              mini: true,
              backgroundColor: Colors.red,
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;

  CardItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
