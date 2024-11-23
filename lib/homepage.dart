import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // State variables for filters
  String selectedCategory = 'All';
  double minPrice = 500;
  double maxPrice = 1000;
  String selectedSize = 'All';
  String selectedColor = 'All';
  String selectedDesigner = 'All';
  double selectedRating = 3;

  // Options for dropdowns
  final List<String> categories = ['All', 'dresses', 'shoes', 'accessories'];
  final List<String> sizes = ['All', 'S', 'M', 'L', 'XL'];
  final List<String> colors = ['All', 'red', 'blue', 'black', 'white'];
  final List<String> designers = [
    'All',
    'Alice',
    'Bob',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Fashion Items"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: Row(
        children: [
          // Filter Column
          filters(),

          // Data Column
          items(
            selectedCategory: selectedCategory,
            minPrice: minPrice,
            maxPrice: maxPrice,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            selectedDesigner: selectedDesigner,
            selectedRating: selectedRating,
          ),
        ],
      ),
    );
  }

  // Filters Section
  Expanded filters() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filterDropdown(
              label: "Category:",
              value: selectedCategory,
              items: categories,
              onChanged: (value) => setState(() => selectedCategory = value!),
            ),
            const SizedBox(height: 16),
            const Text("Price Range (₹):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: RangeValues(minPrice, maxPrice),
              min: 500,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                  minPrice.toStringAsFixed(0), maxPrice.toStringAsFixed(0)),
              onChanged: (values) {
                setState(() {
                  minPrice = values.start;
                  maxPrice = values.end;
                });
              },
            ),
            const SizedBox(height: 16),
            filterDropdown(
              label: "Size:",
              value: selectedSize,
              items: sizes,
              onChanged: (value) => setState(() => selectedSize = value!),
            ),
            const SizedBox(height: 16),
            filterDropdown(
              label: "Color:",
              value: selectedColor,
              items: colors,
              onChanged: (value) => setState(() => selectedColor = value!),
            ),
            const SizedBox(height: 16),
            filterDropdown(
              label: "Designer/Brand:",
              value: selectedDesigner,
              items: designers,
              onChanged: (value) => setState(() => selectedDesigner = value!),
            ),
            const SizedBox(height: 16),
            // Clear Filter Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Reset all filters to their default values
                    selectedCategory = 'All';
                    minPrice = 500;
                    maxPrice = 1000;
                    selectedSize = 'All';
                    selectedColor = 'All';
                    selectedDesigner = 'All';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.red, // Customize button color
                ),
                child: const Text(
                  "Clear Filters",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Helper for Dropdown Filters
  Widget filterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Items Section
  Expanded items({
    required String selectedCategory,
    required double minPrice,
    required double maxPrice,
    required String selectedSize,
    required String selectedColor,
    required String selectedDesigner,
    required double selectedRating,
  }) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: getFilteredData(
            selectedCategory: selectedCategory,
            minPrice: minPrice,
            maxPrice: maxPrice,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            selectedDesigner: selectedDesigner,),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print("${snapshot.error}");
              return Center(
                child: Text(
                  "Error fetching data: ${snapshot
                      .error}. Please check your Firebase console for missing indexes.",
                  textAlign: TextAlign.center,
                ),
              );
            }


            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No items found."));
            }

            var documentList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documentList.length,
              itemBuilder: (context, index) {
                var data = documentList[index].data() as Map<String, dynamic>;

                return Card(
                  margin:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Container(
                                height: 100,
                                width: 100,
                                color: Colors.purpleAccent,
                                child: Icon(Icons.account_circle))),
                        Text(
                          data['name'] ?? 'No Name',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Category: ${data['category'] ?? 'N/A'}'),
                        Text('Price: ₹${data['price']?.toString() ?? '0.00'}'),
                        Text('Size: ${data['size']?.join(', ') ?? 'N/A'}'),
                        Text('Color: ${data['color']?.join(', ') ?? 'N/A'}'),
                        Text('Designer: ${data['designer'] ?? 'N/A'}'),
                        Text('Rating: ${data['rating'] ?? 'N/A'} ⭐'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getFilteredData({
    required String selectedCategory,
    required double minPrice,
    required double maxPrice,
    required String selectedSize,
    required String selectedColor,
    required String selectedDesigner,
  }) {
    // Start with the base collection
    Query query = FirebaseFirestore.instance.collection('database');

    if (selectedCategory != 'All') {
      query = query.where('category', isEqualTo: selectedCategory);
    }
    if (selectedColor != 'All') {
      query = query.where('color', arrayContains: selectedColor);
    }
    else if (selectedSize != 'All') {
      query = query.where('size', arrayContains: selectedSize);
    }
    if (selectedDesigner != 'All') {
      query = query.where('designer', isEqualTo: selectedDesigner);
    }
    if (minPrice != 500 || maxPrice != 1000) {
      query = query
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice);
    }
    return query.snapshots();
  }
}