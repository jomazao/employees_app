import 'package:employees_app/src/data/new_employees_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('New employees tests', () {
    test('Added new id', () async {
      await NewEmployeesService().clearPrefs();
      await NewEmployeesService().addNewEmployee(15);
      final employees = await NewEmployeesService().getNewEmployees();
      final count = employees.length;
      expect(count, 1);

      expect(employees.first, 15);
    });
    test('Remove added id', () async {
      await NewEmployeesService().clearPrefs();
      await NewEmployeesService().addNewEmployee(15);

      await NewEmployeesService().removeNewEmployee(10);
      var employees = await NewEmployeesService().getNewEmployees();
      var count = employees.length;
      expect(count, 1);
      await NewEmployeesService().removeNewEmployee(15);
      employees = await NewEmployeesService().getNewEmployees();
      count = employees.length;
      expect(count, 0);
    });

    test('Add multiple ids', () async {
      await NewEmployeesService().clearPrefs();
      await NewEmployeesService().addNewEmployee(15);
      await NewEmployeesService().addNewEmployee(14);
      await NewEmployeesService().addNewEmployee(72);
      var employees = await NewEmployeesService().getNewEmployees();
      var count = employees.length;
      expect(count, 3);
      await NewEmployeesService().removeNewEmployee(72);
      employees = await NewEmployeesService().getNewEmployees();
      count = employees.length;
      expect(count, 2);
    });

    test('Adding same id multiple times', () async {
      await NewEmployeesService().clearPrefs();
      await NewEmployeesService().addNewEmployee(15);
      await NewEmployeesService().addNewEmployee(15);
      await NewEmployeesService().addNewEmployee(15);
      var employees = await NewEmployeesService().getNewEmployees();
      var count = employees.length;
      expect(count, 1);
      await NewEmployeesService().removeNewEmployee(15);
      employees = await NewEmployeesService().getNewEmployees();
      count = employees.length;
      expect(count, 0);
    });

    test('Check added id exists', () async {
      await NewEmployeesService().clearPrefs();
      await NewEmployeesService().addNewEmployee(16);
      await NewEmployeesService().addNewEmployee(12);
      await NewEmployeesService().addNewEmployee(25);
      await NewEmployeesService().addNewEmployee(32);
      var employees = await NewEmployeesService().getNewEmployees();

      expect(employees.any((id) => id == 16), true);
      expect(employees.any((id) => id == 12), true);
      expect(employees.any((id) => id == 25), true);
      expect(employees.any((id) => id == 32), true);
      expect(employees.any((id) => id == 100), false);
      expect(employees.any((id) => id == 98), false);
      expect(employees.any((id) => id == 1), false);
      expect(employees.any((id) => id == 2), false);
      expect(employees.length, 4);
      await NewEmployeesService().removeNewEmployee(12);
      await NewEmployeesService().removeNewEmployee(32);
      employees = await NewEmployeesService().getNewEmployees();
      expect(employees.any((id) => id == 16), true);
      expect(employees.any((id) => id == 12), false);
      expect(employees.any((id) => id == 25), true);
      expect(employees.any((id) => id == 32), false);
      expect(employees.length, 2);
    });
  });
}
