import 'package:flutter/material.dart';
import '../models/cap.dart';
import '../widgets/cap_card.dart';
import 'bag_screen.dart';
import 'cap_detail_screen.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> capNames = [
    'Vintage Red', 'pista', 'Charcoal Ash', 'Sunset Orange', 'Baby Beigh',
    'Stone Grey', 'Desert Tan', 'Sky White', 'Royal Purple', 'Midnight Navy',
    'Berry Pink', 'Frost White', 'Charcoal Ash', 'Lemon Yellow', 'Moss Green',
    'Peach Coral', 'Denim Fade', 'Cloud Mist', 'Sand Beige', 'Jet Black',
  ];

  late final List<Cap> availableCaps;

  final List<Map<String, dynamic>> bag = [];

  @override
  void initState() {
    super.initState();

    final random = Random();
    availableCaps = List.generate(20, (i) {
      final double price = 20 + random.nextInt(171) + random.nextDouble();
      return Cap(
        name: capNames[i],
        imagePath: 'assets/images/cap${i + 1}.png',
        price: double.parse(price.toStringAsFixed(2)),
      );
    });
  }



  // Shopping bag storing both cap and selected size


  List<Cap> get sortedCaps => [...availableCaps]; // no sorting for now

  // Add cap with size to bag
  void addToBag(Cap cap, String size) {
    setState(() {
      bag.add({'cap': cap, 'size': size});
    });
  }

  // Navigate to bag screen
  void openBag() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BagScreen(bag: bag),
      ),
    );
    setState(() {}); // Refresh after return
  }

  // Navigate to cap detail screen
  void openCapDetails(Cap cap) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CapDetailScreen(
          cap: cap,
          onAdd: (selectedCap, size) {
            addToBag(selectedCap, size);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cap Shop'),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/icons/cart.png',
                  width: 28,
                  height: 28,
                ),
                onPressed: openBag,
              ),
              if (bag.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Text(
                      '${bag.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sortedCaps.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => openCapDetails(sortedCaps[i]),
          child: CapCard(
            cap: sortedCaps[i],
            onAdd: (cap) => addToBag(cap, 'M'), // default size if tapped 'Add'
          ),
        ),
      ),
    );
  }
}
