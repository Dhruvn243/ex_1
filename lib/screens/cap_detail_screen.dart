import 'package:flutter/material.dart';
import '../models/cap.dart';

class CapDetailScreen extends StatefulWidget {
  final Cap cap;
  final void Function(Cap cap, String size) onAdd;

  const CapDetailScreen({required this.cap, required this.onAdd});

  @override
  _CapDetailScreenState createState() => _CapDetailScreenState();
}

class _CapDetailScreenState extends State<CapDetailScreen> {
  String selectedSize = 'M';
  final List<String> sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Match cap image background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Top Bar with Back and Title
              SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'assets/icons/home.png',
                        width: 20, // Smaller size
                        height: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.cap.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Cap Image with Curve
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    widget.cap.imagePath,
                    height: height * 0.50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Price
              Text(
                '\$${widget.cap.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),

              const SizedBox(height: 16),

              // Size Selector
              const Text('Select Size', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: sizes.map((size) {
                  final isSelected = size == selectedSize;
                  return ChoiceChip(
                    label: Text(size),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),

              const Spacer(), // Pushes button to bottom without overflow

              // Add to Bag Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAdd(widget.cap, selectedSize);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Add to Bag',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
