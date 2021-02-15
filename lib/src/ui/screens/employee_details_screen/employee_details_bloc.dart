import 'dart:async';

import 'package:employees_app/src/data/new_employees_service.dart';
import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeDetailsBloc extends ChangeNotifier {
  final Employee employee;
  StreamSubscription newsSubscription;
  final _newEmployeesService = NewEmployeesService();
  EmployeeDetailsBloc(this.employee) {
    newsSubscription = _newEmployeesService.newsStream.listen((ids) {
      employee.isNew = ids.any((id) => id == employee.id);
      notifyListeners();
    });
  }

  void changeNew() {
    if (employee.isNew) {
      _newEmployeesService.removeNewEmployee(employee.id);
    } else {
      _newEmployeesService.addNewEmployee(employee.id);
    }
  }

  @override
  void dispose() {
    newsSubscription.cancel();
    super.dispose();
  }
}
