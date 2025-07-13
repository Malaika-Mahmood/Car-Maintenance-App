

import 'package:objectbox/objectbox.dart';
import 'maintenance_record.dart';

@Entity()
class Car {
  int id;
  String name;
  String year;
  String imagePath;

  @Backlink()
  final maintenanceRecords = ToMany<MaintenanceRecord>();

  Car({this.id = 0, required this.name, required this.year, required this.imagePath});
}
