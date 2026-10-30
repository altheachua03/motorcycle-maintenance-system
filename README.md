## Week 12 Terminal Assessment: Motorcycle Maintenance Management System

**Student Name:** Althea Chua  
**Block:** 3.1BSIT  
**Activity:** Week 12 Terminal Assessment

## Project Overview

The Motorcycle Maintenance Management System is a beginner-friendly, menu-driven Dart console application. It allows users to register Honda and Yamaha motorcycles, view registered motorcycles, record maintenance activities, view maintenance records, display reminders, and view a simple summary.

This project extends the motorcycle examples and Dart programming concepts practiced in Weeks 7–11.

## Features

1. Register a Honda or Yamaha motorcycle.
2. Display all registered motorcycles and their details.
3. Add a maintenance record to a selected motorcycle.
4. View maintenance records.
5. Display a basic motorcycle maintenance reminder.
6. Demonstrate an asynchronous save operation using `Future`, `async`, `await`, and `Future.delayed`.
7. Display the number of motorcycles, maintenance records, and total maintenance expenses.
8. Validate user input and handle invalid values.

## Requirements

- Dart SDK 3.0.0 or later
- A code editor such as Visual Studio Code (optional)
- A terminal or command prompt

## How to Run

1. Install the Dart SDK.
2. Open the project folder in Visual Studio Code or a terminal.
3. Open a terminal in the project folder.
4. Run the following command:

   ```bash
   dart run motorcycle_maintenance.dart
   ```

5. Follow the numbered menu and enter the requested information.

## Project Structure

```text
MotorcycleMaintenanceSystem/
├── motorcycle_maintenance.dart
└── README.md
```

## Main Program Components

### 1. Motorcycle Abstract Class

Stores shared motorcycle information, including brand, model, year, price, and maintenance records.

It also includes:
- A getter and setter for price.
- An abstract description method.
- An asynchronous simulated save method.

### 2. HondaMotorcycle and YamahaMotorcycle

These subclasses inherit from the `Motorcycle` class and override the description and display methods.

This demonstrates inheritance and polymorphism.

### 3. MaintenanceRecord

Represents one maintenance activity. Each record contains:
- Date
- Service description
- Cost

### 4. MaintenanceReminder Mixin

Provides a reusable maintenance reminder method that can be added to the system class.

### 5. MotorcycleMaintenance Class

Manages the list of motorcycles and provides methods for:
- Registering motorcycles
- Displaying motorcycle information
- Simulating the save operation
- Calculating the system summary

### 6. Input and Validation Functions

The program uses helper functions to reject:
- Empty text
- Invalid whole numbers
- Invalid decimal numbers
- Negative amounts where they are not allowed

It also uses `try`, `catch`, and `FormatException` to handle invalid input.

## Dart Concepts Demonstrated

- Variables and data types
- Lists and objects
- Conditional statements and `switch`
- `while` and `for` loops
- Functions and methods
- User input using `dart:io`
- `try`, `catch`, and `FormatException`
- Classes, constructors, and objects
- Encapsulation through the private `_price` field and getter/setter
- Inheritance and method overriding
- Abstract classes and abstract methods
- Mixins
- Asynchronous programming using `Future`, `async`, and `await`

## Important Note About Saving

The save operation is simulated using `Future.delayed`. It demonstrates asynchronous programming but does not write data to a file or database.

Motorcycle and maintenance information is stored in memory while the program is running. All entered data is lost when the application is closed.

## Suggested Test Cases

| Test | Action | Expected Result |
|---|---|---|
| 1 | Register a Honda motorcycle with valid details | Motorcycle is registered. |
| 2 | Register a Yamaha motorcycle with valid details | Motorcycle is registered. |
| 3 | Enter letters for a year or price | Program asks for valid input. |
| 4 | Leave a required text field blank | Program asks for input again. |
| 5 | Add maintenance to a registered motorcycle | Record is added. |
| 6 | View maintenance records | Added records are displayed. |
| 7 | Try adding maintenance before registering a motorcycle | Program asks the user to register first. |
| 8 | Choose the save option | Simulated save messages appear after a delay. |
| 9 | Display summary | Counts and total maintenance expenses are displayed. |

## Relationship to Weeks 7–11

- **Week 7:** Variables, data types, calculations, and comparisons are used for motorcycle and maintenance information.
- **Week 8:** Input handling, functions, loops, and exception handling are used in the menu and validation.
- **Week 9:** The motorcycle class, fields, constructor, getter, and setter build on class fundamentals.
- **Week 10:** Abstract classes, inheritance, overriding, and a mixin organize related motorcycle behavior.
- **Week 11:** `Future`, `async`, `await`, and `Future.delayed` demonstrate asynchronous operations.

## Limitations

- The application is a console-based program, not a graphical mobile application.
- It supports Honda and Yamaha as the available motorcycle brands.
- It does not use a database or permanent file storage.
- The save feature is a demonstration only.
- The maintenance date is stored as text. The program checks that it is not blank but does not validate its date format.
