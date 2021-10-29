
import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:sandbox/configuration/custom_colors.dart';
import 'package:sandbox/entities/customer.dart';

class ItemSearchClient extends StatelessWidget {
  ItemSearchClient(
      {Key? key,
      required this.person,
      this.onTap,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  final Customer person;
  final VoidCallback? onTap;
  final EdgeInsets margin;

  final Responsive _responsive = Inject().get<Responsive>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(_responsive.size(5)),
              child: Image.asset(
                person.urlImage,
                height: _responsive.size(130),
              ),
            ),
            SizedBox(width: _responsive.size(5)),
            Container(
              width: _responsive.size(250),
              height: _responsive.size(130),
              padding: EdgeInsets.symmetric(horizontal: _responsive.size(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_responsive.size(5)),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    person.name,
                    style: TextStyle(
                      fontSize: _responsive.size(22),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'DNI ${person.dni}',
                    style: TextStyle(
                      fontSize: _responsive.size(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${person.email}',
                    style: TextStyle(
                      fontSize: _responsive.size(16),
                      fontWeight: FontWeight.w600,
                      color: CustomColors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _daysTextBuilder (BuildContext context, AsyncSnapshot<int> snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Container(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(),
      );

    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');

      } else if (snapshot.hasData) {
        return _daysText(context, snapshot.data!);

      } else {
        return const Text('Empty data');
      }

    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  Widget _balanceTextBuilder (BuildContext context, AsyncSnapshot<double> snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Container(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(),
      );

    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');

      } else if (snapshot.hasData) {
        return _balanceText(context, snapshot.data!);

      } else {
        return const Text('Empty data');
      }

    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  Widget _balanceText(BuildContext context, double balance) => Text('\$$balance',
    style: TextStyle(
      fontSize: _responsive.size(20),
      fontWeight: FontWeight.w900,
      color: Colors.red,
    ),
  );

  Widget _daysText(BuildContext context, int days) => Text(
    '$days días',
    style: TextStyle(
      fontSize: _responsive.size(16),
      fontWeight: FontWeight.w900,
      color: CustomColors.blue,
    ),
  );
}
