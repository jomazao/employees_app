import 'package:employees_app/src/data/employee_repository.dart';
import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeListBloc extends ChangeNotifier {
  final employeeRepository = EmployeeRepository();

  List<Employee> employees = [];
  bool loading = false;
  void loadEmployees() async {
    loading = true;
    notifyListeners();
    final employees = await employeeRepository.getAll();
    if (employees != null) {
      this.employees = employees;
      loading=false;

    }else{
      loading=true;

    }
    notifyListeners();
  }
}
