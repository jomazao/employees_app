import 'dart:convert';

import 'package:employees_app/src/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeRepository {
  final endpoint =
      'https://raw.githubusercontent.com/sapardo10/content/master/RH.json';

  Future<List<Employee>> getAll() {
    final request = http.get(endpoint);

    return request.then((result) {
      if (result.statusCode == 200) {
        final body = jsonDecode(result.body);
        return (body['employees'] as List)
            .map((empMap) => Employee.fromMap(empMap))
            .toList();
      }
      //TODO Manage bad requests and unexpected server problems
      return null;
    });
  }
}
