import 'package:flutter/material.dart';
import '../models/cap.dart';

class BagScreen extends StatefulWidget {
  final List<Map<String, dynamic>> bag;

  BagScreen({required this.bag});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  void removeItem(int index) {
    setState(() {
      widget.bag.removeAt(index);
    });
  }

  double get totalPrice {
    return widget.bag.fold(0.0, (sum, item) {
      final cap = item['cap'] as Cap;
      return sum + cap.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F8FA), // Light grey background to match image
    appBar: AppBar(
    leading: IconButton(
    icon: Image.asset(
    'assets/icons/home.png',
    width: 24,
    height: 24,
    ),
    onPressed: () {
    Navigator.of(context).pop();
    },
    ),
    title: Text('Bag'),
    centerTitle: true,
    backgroundColor: Colors.white, // Optional: match the AppBar to overall theme
    elevation: 0, // Optional: remove AppBar shadow for cleaner look
    ),


    body: Column(
        children: [
          Expanded(
            child: widget.bag.isEmpty
                ? Center(child: Text('Your bag is empty.'))
                : ListView.builder(
              itemCount: widget.bag.length,
              itemBuilder: (context, i) {
                final cap = widget.bag[i]['cap'] as Cap;
                final size = widget.bag[i]['size'] as String;

                return ListTile(
                  leading: Image.asset(cap.imagePath, width: 60, height: 60),
                  title: Text(cap.name),
                  subtitle: Text(
                    'Size: $size   •   \$${cap.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Image.asset(
                      'assets/icons/remove.png', // Replace with your image path
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () => removeItem(i),
                  ),

                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.yellow[700], // Bright yellow
                      foregroundColor: Colors.black, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Checkout successful!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
