
import 'models/car.dart';
import 'models/maintenance_record.dart';
import 'objectbox.g.dart';

late final Store store;
late final Box<Car> carBox;
late final Box<MaintenanceRecord> recordBox;

Future<void> initObjectBox() async {
  store = await openStore();
  carBox = store.box<Car>();
  recordBox = store.box<MaintenanceRecord>();
}
