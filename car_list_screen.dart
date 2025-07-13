import 'package:flutter/material.dart';
import '../models/car.dart';
import '../objectbox_store.dart';
import 'add_car_screen.dart';
import 'car_details_screen.dart';// Import Car model

class CarListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cars List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[850], // Dark grey
        centerTitle: true,
      ),
      body: FutureBuilder<List<Car>>(
        future: _getCars(), // Fetch cars from ObjectBox
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Cars Available"));
          }

          final cars = snapshot.data!;

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/${car.name.toLowerCase().replaceAll(' ', '_')}.jpg', // Dynamically load image
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "${car.name} (${car.year})",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    "Year: ${car.year}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarDetailsScreen(car: car),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300], // Light grey
        child: Icon(Icons.add, color: Colors.black), // Icon in black
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddCarScreen()),
          );
        },
      ),
    );
  }

  // Fetch all cars from ObjectBox
  Future<List<Car>> _getCars() async {
    final carBox = store.box<Car>();
    return carBox.getAll();
  }
}
