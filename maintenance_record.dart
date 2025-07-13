import 'package:objectbox/objectbox.dart';
import 'car.dart';

@Entity()
class MaintenanceRecord {
  int id;
  final car = ToOne<Car>();
  String type;
  String detail;

  MaintenanceRecord({this.id = 0, required this.type, required this.detail});
}
