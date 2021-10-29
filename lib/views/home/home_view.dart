
import 'package:botanico_rx/botanico_rx.dart';
import 'package:inject/inject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:sandbox/configuration/custom_colors.dart';
import 'package:sandbox/entities/customer.dart';
import 'package:sandbox/widgets/item_search_client/item_search_client.dart';

import 'home_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Responsive _responsive = Inject().get<Responsive>();
  final HomeController _controller = Inject().get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('search / add customer'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: _responsive.size(20),
            right: _responsive.size(20),
            left: _responsive.size(20),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(children: <Widget>[
            _buildSearch(),
            SizedBox(height: _responsive.size(20)),
            _buildPersons(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _buildNewPerson();
        },
      ),
    ));
  }

  Widget _buildSearch() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller.searchField,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.all(_responsive.size(14)),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black),
              ),
              hintText: 'Search by SSN, name or email',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(width: _responsive.size(10)),
        ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            _controller.filter(_controller.searchField.text);
          },
          child: Icon(
            Icons.search,
            size: _responsive.size(30),
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(_responsive.size(20), _responsive.size(50))),
          ),
        ),
      ],
    );
  }

  Widget _buildPersons() {
    return Orx<List<Customer>>(
      stream: _controller.persons$,
      onSuccess: (value) => Column(
        children: value!
            .map(
              (p) => ItemSearchClient(
                person: p,
                margin: EdgeInsets.only(top: _responsive.size(20)),
                onTap: () {
                  //TODO: add logic here after customer Tap
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _buildNewPerson() {
    setState(() {
      _controller.clear();
    });
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Add Customer',
            style: TextStyle(color: CustomColors.blue),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _controller.nameField,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Name',
                  errorText: _controller.nameFieldValidationError,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controller.ssnField,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'SSN',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controller.emailField,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.redAccent)),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.addPerson().then((savedCustomer) {
                  if (savedCustomer != null) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                    });
                  }
                });
              },
              child: Text('Add'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => CustomColors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
