import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:sandbox/entities/customer.dart';
import 'package:sandbox/repositories/customer_repository.dart';
import 'package:kotlin_flavor/scope_functions.dart';


class HomeController {
  final StreamController<List<Customer>> _controller =
      new StreamController<List<Customer>>.broadcast();

  final CustomerRepository _personRepository = Inject().get<CustomerRepository>();
  final TextEditingController searchField = TextEditingController();
  final TextEditingController nameField = TextEditingController();
  final TextEditingController ssnField = TextEditingController();
  final TextEditingController emailField = TextEditingController();
  bool validationsPerformed = false;

  Stream<List<Customer>> get persons$ => _controller.stream;

  String? get nameFieldValidationError => (validationsPerformed && nameField.text.isEmpty) ? 'Name must be not empty' : null;

  void getPersons() async {
    _controller.sink.add(await _personRepository.search(null));
  }

  void filter(String text) async {
    if (text.isNotEmpty) {
      _controller.sink.add((await _personRepository.search(text+'*')));

    } else {
      _controller.sink.add([]);
    }
  }

  bool _formFieldsAreValid() {
    validationsPerformed = true;
    if (nameField.text.isEmpty) return false;
    return true;
  }

  Future<Customer?> addPerson() async {

    if (!_formFieldsAreValid()) {
      print('form validation fails');
      return null;
    }

    Customer customer = Customer(
        dni: ssnField.text,
        name: nameField.text,
        email: emailField.text
    );
    return _personRepository
        .saveCustomer(customer)
        .also((self) {
      clear();
    });
  }

  void close() {
    _controller.close();
  }

  void clear() {
    nameField.clear();
    ssnField.clear();
    emailField.clear();
    validationsPerformed = false;
  }
}
