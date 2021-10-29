

import 'package:appwrite_flutter/appwrite.dart';
import 'package:appwrite_flutter/collection_repository.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:sandbox/configuration/settings.dart';
import 'package:sandbox/entities/customer.dart';

abstract class ICustomerRepository {
  Future<Customer> saveCustomer(Customer customer);
  Future<List<Customer>> search(String? searchText);
}

class CustomerRepository extends CollectionRepository<Customer> implements ICustomerRepository {

  CustomerRepository(IAppWrite appWrite, MapSerializer<Customer> serializer)
      : super(appWrite, serializer, collectionId: GlobalConfiguration().getValue(CUSTOMER_COLLECTION));

  Future<Customer> saveCustomer(Customer customer) async => super
      .save(customer, readPermissions: ['*'], writePermissions: ['*']);

  @override
  Future<List<Customer>> search(String? searchText) => super.searchAll(searchText: searchText);

}
