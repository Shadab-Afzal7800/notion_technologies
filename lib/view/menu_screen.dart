import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu List",
          style: GoogleFonts.hachiMaruPop(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange[100],
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildFilterButton("Veg", true, Colors.green),
                    const SizedBox(width: 10),
                    _buildFilterButton("Non-veg", false, Colors.red),
                  ],
                ),
                Row(
                  children: [
                    _buildSortButton("Low To High"),
                    const SizedBox(width: 10),
                    _buildSortButton("High To Low"),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),

          // Menu List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 4, // Example static list
              itemBuilder: (context, index) {
                return _buildMenuItem(
                  hotelName: "New Hotel",
                  foodName: "Chicken Hakka Noodles",
                  isVeg: index % 2 == 0, // Alternate Veg/Non-Veg
                  originalPrice: 175,
                  discountedPrice: 160,
                  rating: 4.5,
                  imageUrl: "", // Placeholder for now
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Filter Button
  Widget _buildFilterButton(String label, bool isSelected, Color color) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.hachiMaruPop(
            fontSize: 14,
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Sort Button
  Widget _buildSortButton(String label) {
    return Text(
      label,
      style: GoogleFonts.hachiMaruPop(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // Menu Item Card
  Widget _buildMenuItem({
    required String hotelName,
    required String foodName,
    required bool isVeg,
    required double originalPrice,
    required double discountedPrice,
    required double rating,
    required String imageUrl,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Container(
              height: 60,
              width: 60,
              color: Colors.grey[300],
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        "MM",
                        style: GoogleFonts.hachiMaruPop(fontSize: 14),
                      ),
                    ),
            ),
            const SizedBox(width: 10),

            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: GoogleFonts.hachiMaruPop(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    foodName,
                    style: GoogleFonts.hachiMaruPop(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: isVeg ? Colors.green : Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            size: 16,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "₹$originalPrice",
                        style: GoogleFonts.hachiMaruPop(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "₹$discountedPrice",
                        style: GoogleFonts.hachiMaruPop(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[100],
                foregroundColor: Colors.orange,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "ADD",
                style: GoogleFonts.hachiMaruPop(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
