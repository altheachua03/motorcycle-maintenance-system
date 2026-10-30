import 'dart:io';

abstract class Motorcycle {
  String brand;
  String model;
  int year;

  double _price;

  List<MaintenanceRecord> maintenanceRecords = [];

  Motorcycle(this.brand, this.model, this.year, this._price);

  double getPrice() {
    return _price;
  }

  void setPrice(double newPrice) {
    if (newPrice > 0 && newPrice.isFinite) {
      _price = newPrice;
    } else {
      print('Invalid price!');
    }
  }

  String describeMotorcycle();

  void addMaintenanceRecord(MaintenanceRecord record) {
    maintenanceRecords.add(record);
  }

  Future<String> saveMotorcycleData() async {
    await Future.delayed(Duration(seconds: 2));

    return 'Motorcycle data saved successfully: $brand - $model';
  }

  void displayInfo() {
    print('Brand: $brand');
    print('Model: $model');
    print('Year: $year');
    print('Price: PHP ${_price.toStringAsFixed(2)}');
    print('Description: ${describeMotorcycle()}');
    print('Maintenance Records: ${maintenanceRecords.length}');
    print('-------------------------');
  }
}

class HondaMotorcycle extends Motorcycle {
  HondaMotorcycle(String brand, String model, int year, double price)
    : super(brand, model, year, price);

  @override
  String describeMotorcycle() {
    return 'A Honda motorcycle for everyday riding.';
  }

  @override
  void displayInfo() {
    print('HONDA MOTORCYCLE');
    super.displayInfo();
  }
}

class YamahaMotorcycle extends Motorcycle {
  YamahaMotorcycle(String brand, String model, int year, double price)
    : super(brand, model, year, price);

  @override
  String describeMotorcycle() {
    return 'A Yamaha motorcycle for comfortable city travel.';
  }

  @override
  void displayInfo() {
    print('YAMAHA MOTORCYCLE');
    super.displayInfo();
  }
}

class MaintenanceRecord {
  String serviceType;
  String serviceDate;
  String description;
  double cost;

  MaintenanceRecord(
    this.serviceType,
    this.serviceDate,
    this.description,
    this.cost,
  );

  void displayRecord() {
    print('Service Type: $serviceType');
    print('Service Date: $serviceDate');
    print('Description: $description');
    print('Service Cost: PHP ${cost.toStringAsFixed(2)}');
    print('-------------------------');
  }
}

mixin MaintenanceReminder {
  void showMaintenanceReminder() {
    print('Reminder: Check the tires, brakes, and engine regularly.');
  }
}

class MotorcycleMaintenance with MaintenanceReminder {}

String readRequiredText(String prompt) {
  stdout.write(prompt);

  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    throw FormatException('Input cannot be empty.');
  }

  return input.trim();
}

int readPositiveInt(String prompt) {
  stdout.write(prompt);

  String? input = stdin.readLineSync();

  int? value = int.tryParse(input ?? '');

  if (value == null || value <= 0) {
    throw FormatException('Enter a valid positive number.');
  }

  return value;
}

double readPositiveDouble(String prompt) {
  stdout.write(prompt);

  String? input = stdin.readLineSync();

  double? value = double.tryParse(input ?? '');

  if (value == null || value <= 0 || !value.isFinite) {
    throw FormatException('Enter a valid positive amount.');
  }

  return value;
}

double readNonNegativeDouble(String prompt) {
  stdout.write(prompt);

  String? input = stdin.readLineSync();

  double? value = double.tryParse(input ?? '');

  if (value == null || value < 0 || !value.isFinite) {
    throw FormatException('Enter a valid non-negative amount.');
  }

  return value;
}

void registerMotorcycle(List<Motorcycle> motorcycles) {
  print('\n===== REGISTER MOTORCYCLE =====');

  print('1. Honda');
  print('2. Yamaha');

  int brandChoice = readPositiveInt('Select motorcycle brand: ');

  if (brandChoice != 1 && brandChoice != 2) {
    throw FormatException('Please select 1 or 2.');
  }

  String brand = brandChoice == 1 ? 'Honda' : 'Yamaha';

  String model = readRequiredText('Enter motorcycle model: ');
  int year = readPositiveInt('Enter motorcycle year: ');
  double price = readPositiveDouble('Enter motorcycle price: ');

  Motorcycle motorcycle;

  if (brandChoice == 1) {
    motorcycle = HondaMotorcycle(brand, model, year, price);
  } else {
    motorcycle = YamahaMotorcycle(brand, model, year, price);
  }

  motorcycles.add(motorcycle);

  print('\nMotorcycle registered successfully!');
}

void displayMotorcycles(List<Motorcycle> motorcycles) {
  print('\n===== REGISTERED MOTORCYCLES =====');

  if (motorcycles.isEmpty) {
    print('No motorcycles registered yet.');
    return;
  }

  for (int i = 0; i < motorcycles.length; i++) {
    print('Motorcycle ${i + 1}');
    motorcycles[i].displayInfo();
  }
}

void recordMaintenance(List<Motorcycle> motorcycles) {
  print('\n===== RECORD MAINTENANCE =====');

  if (motorcycles.isEmpty) {
    print('Please register a motorcycle first.');
    return;
  }

  for (int i = 0; i < motorcycles.length; i++) {
    print('${i + 1}. ${motorcycles[i].brand} - ${motorcycles[i].model}');
  }

  int choice = readPositiveInt('Select motorcycle number: ');

  if (choice > motorcycles.length) {
    throw FormatException('Motorcycle number does not exist.');
  }

  Motorcycle selectedMotorcycle = motorcycles[choice - 1];

  String serviceType = readRequiredText('Enter service type: ');
  String serviceDate = readRequiredText('Enter service date: ');
  String description = readRequiredText('Enter service description: ');
  double cost = readNonNegativeDouble('Enter service cost: ');

  MaintenanceRecord record = MaintenanceRecord(
    serviceType,
    serviceDate,
    description,
    cost,
  );

  selectedMotorcycle.addMaintenanceRecord(record);

  print('\nMaintenance record added successfully!');
}

void displayMaintenanceRecords(List<Motorcycle> motorcycles) {
  print('\n===== MAINTENANCE RECORDS =====');

  if (motorcycles.isEmpty) {
    print('No motorcycles registered yet.');
    return;
  }

  bool hasRecords = false;

  for (Motorcycle motorcycle in motorcycles) {
    print('\n${motorcycle.brand} - ${motorcycle.model}');

    if (motorcycle.maintenanceRecords.isEmpty) {
      print('No maintenance records available.');
    } else {
      hasRecords = true;

      for (MaintenanceRecord record in motorcycle.maintenanceRecords) {
        record.displayRecord();
      }
    }
  }

  if (!hasRecords) {
    print('\nNo maintenance records have been added yet.');
  }
}

Future<void> saveAllMotorcycles(List<Motorcycle> motorcycles) async {
  print('\n===== SAVING MOTORCYCLE DATA =====');

  if (motorcycles.isEmpty) {
    print('There is no motorcycle data to save.');
    return;
  }

  for (Motorcycle motorcycle in motorcycles) {
    print('Saving ${motorcycle.model}...');

    String result = await motorcycle.saveMotorcycleData();

    print(result);
  }

  print('\nSaving operation completed.');
}

void displaySummary(List<Motorcycle> motorcycles) {
  int totalMotorcycles = motorcycles.length;
  int totalMaintenanceRecords = 0;
  double totalMaintenanceCost = 0;

  for (Motorcycle motorcycle in motorcycles) {
    totalMaintenanceRecords += motorcycle.maintenanceRecords.length;

    for (MaintenanceRecord record in motorcycle.maintenanceRecords) {
      totalMaintenanceCost += record.cost;
    }
  }

  print('\n===== APPLICATION SUMMARY =====');
  print('Total Motorcycles: $totalMotorcycles');
  print('Total Maintenance Records: $totalMaintenanceRecords');
  print(
    'Total Maintenance Expenses: PHP '
    '${totalMaintenanceCost.toStringAsFixed(2)}',
  );
}

Future<void> main() async {
  List<Motorcycle> motorcycles = [];

  MotorcycleMaintenance maintenance = MotorcycleMaintenance();

  bool isRunning = true;

  print('======================================');
  print(' MOTORCYCLE MAINTENANCE MANAGEMENT SYSTEM');
  print('======================================');

  while (isRunning) {
    print('\nMAIN MENU');
    print('1. Register Motorcycle');
    print('2. Display Motorcycles');
    print('3. Record Maintenance');
    print('4. Display Maintenance Records');
    print('5. Save Motorcycle Data');
    print('6. Show Maintenance Reminder');
    print('7. Display Application Summary');
    print('8. Exit');

    try {
      int choice = readPositiveInt('\nEnter your choice: ');

      switch (choice) {
        case 1:
          registerMotorcycle(motorcycles);
          break;

        case 2:
          displayMotorcycles(motorcycles);
          break;

        case 3:
          recordMaintenance(motorcycles);
          break;

        case 4:
          displayMaintenanceRecords(motorcycles);
          break;

        case 5:
          await saveAllMotorcycles(motorcycles);
          break;

        case 6:
          print('\n===== MAINTENANCE REMINDER =====');
          maintenance.showMaintenanceReminder();
          break;

        case 7:
          displaySummary(motorcycles);
          break;

        case 8:
          isRunning = false;
          print('\nThank you for using the system!');
          break;

        default:
          print('\nInvalid choice! Please select from 1 to 8.');
      }
    } catch (e) {
      print('\nInvalid input!');
      print('Error: $e');
      print('Please try again.');
    }
  }
}
