import 'package:flutter/material.dart';
import '../models/car.dart';
import '../models/maintenance_record.dart';
import '../objectbox_store.dart';

class CarDetailsScreen extends StatefulWidget {
  final Car car;

  CarDetailsScreen({required this.car});

  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  List<MaintenanceRecord> records = [];

  @override
  void initState() {
    super.initState();
    _loadMaintenanceRecords();
  }

  void _loadMaintenanceRecords() {
    final car = store.box<Car>().get(widget.car.id);

    if (car != null) {
      setState(() {
        records = car.maintenanceRecords.toList();
      });
    }
  }

  void _deleteRecord(int index) {
    final record = records[index];
    store.box<MaintenanceRecord>().remove(record.id);

    setState(() {
      records.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.car.name} Details"),
        backgroundColor: Colors.grey[850],
      ),
      body: records.isEmpty
          ? Center(child: Text("No Maintenance Records"))
          : ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return ListTile(
            title: Text(record.type),
            subtitle: Text(record.detail),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteRecord(index),
            ),
          );
        },
      ),
    );
  }
}
