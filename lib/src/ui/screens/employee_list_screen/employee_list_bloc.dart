import 'package:employees_app/src/data/employee_repository.dart';
import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeListBloc extends ChangeNotifier {
  final employeeRepository = EmployeeRepository();

  List<Employee> employees = [];
  List<Employee> filteredEmployees = [];

  String sort;

  bool loading = false;
  void loadEmployees() async {
    loading = true;
    notifyListeners();
    final employees = await employeeRepository.getAll();
    if (employees != null) {
      this.employees = employees;
      filteredEmployees = employees;
      loading = false;
    } else {
      loading = true;
    }
    notifyListeners();
  }

  void filterByName(String name) {
    if (name != '') {
      filteredEmployees = employees
          .where((element) =>
              element.name.toUpperCase().contains(name.toUpperCase()))
          .toList();
    } else {
      filteredEmployees = employees;
    }
    if (sort != null) {
      sortBySalary(upward: sort == 'upward');
    }
    notifyListeners();
  }

  void sortBySalary({bool upward = true}) {
    sort = upward ? 'upward' : 'backward';
    //The next sort algorithm implements BubbleSort

    for (int i = 0; i < filteredEmployees.length; i++) {
      for (int j = 0; j < filteredEmployees.length; j++) {
        final a = filteredEmployees[i];
        final b = filteredEmployees[j];
        bool shift = false;
        if ((a.wage > b.wage) && upward) {
          shift = true;
        } else if ((a.wage < b.wage) && !upward) {
          shift = true;
        }
        if (shift) {
          final aux = a;
          filteredEmployees[i] = b;
          filteredEmployees[j] = aux;
        }
      }
    }
    notifyListeners();
  }
}
