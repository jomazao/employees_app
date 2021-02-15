import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class NewEmployeesService {
  final _newsStreamController = StreamController<List<int>>.broadcast();

  static final NewEmployeesService _instance = NewEmployeesService._internal();

  factory NewEmployeesService() {
    return _instance;
  }

  NewEmployeesService._internal();

  Sink get newsSink => _newsStreamController.sink;
  Stream<List<int>> get newsStream => _newsStreamController.stream;

  Future<List<int>> getNewEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ids = prefs.getString('news') ?? '';
    return ids == '' ? [] : ids.split(',').map((e) => int.parse(e)).toList();
  }

  void addNewEmployee(int id) async {
    final bIds = await getNewEmployees();
    bIds.add(id);
    final aIds = bIds.toSet().toList(); //ensure not repeating ids
    await saveNewEmployees(aIds);
  }

  void removeNewEmployee(int id) async {
    final ids = await getNewEmployees();
    ids.remove(id);
    saveNewEmployees(ids);
  }

  Future<void> saveNewEmployees(List<int> ids) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('news', ids.join(','));

    newsSink.add(await getNewEmployees());
  }

  void dispose() {
    _newsStreamController.close();
  }
}
