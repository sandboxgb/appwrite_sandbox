
import 'package:appwrite_flutter/collection_repository.dart';
import 'package:kotlin_flavor/scope_functions.dart';
import 'package:list_map_extensions/maps.dart';

class Customer {
  final String? id;
  final String dni;
  final String name;
  final String email;
  late final String? _urlImage;

  String get urlImage {
    if (_urlImage == null) return 'assets/images/no_photo.jpg';
    return _urlImage!;
  }

  Customer({this.id, required this.dni, required this.name, required this.email,
    String? urlImage}) {
    _urlImage = urlImage;
  }

  @override
  String toString() {
    return 'Customer{id: $id, dni: $dni, name: $name, email: $email, urlImage: $urlImage}';
  }
}

class CustomerSerializer extends MapSerializer<Customer> {

  @override
  Customer fromMap(map) => Customer(
      id: map['\$id'],
      dni: map['document_no'],
      name: map['name'],
      email: map['email'],
      urlImage: map['url_image']
  );

  @override
  Map<String, dynamic> toMap(Customer entity) => {
    'document_no': entity.dni,
    'name': entity.name,
    'email': entity.email,
  }.also((map) {
    map.putIfNotNull("\$id", entity.id);
    map.putIfNotNull("url_image", entity.urlImage);
  });
}
