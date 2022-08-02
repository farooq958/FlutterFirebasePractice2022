import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubitss/fetch_cart_controller/fetch_it_admin_cubit.dart';
import '../data/fproductcontroller.dart';
import '../views/order_screen_admin.dart';

class CartDataTable extends StatelessWidget {
  const CartDataTable(
      {Key? key,
      required this.updateController,
      required this.widget,
      required this.ps})
      : super(key: key);

  final TextEditingController updateController;
  final OrderAdmin widget;
  final FirebaseProductsCart ps;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Product Name')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Edit')),
        DataColumn(label: Text('Delete'))
      ],
      rows:

          //another way to do is to use collection package which get indexed >/:<
          ps.products
              .asMap()
              .map((i, e) {
                //updateController.text=e.quantity.toString();

                return MapEntry(
                    i,
                    DataRow(cells: [
                      DataCell(Text(e.title)),
                      DataCell(Text(e.price.toString())),
                      DataCell(Text(e.quantity.toString())),
                      DataCell(GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: SizedBox(
                                        height: 200,
                                        child: Column(
                                          children: <Widget>[
                                            const Text("Change Quantity"),
                                            TextField(
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(),
                                              controller: updateController,
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                context
                                                    .read<FetchItAdminCubit>()
                                                    .changeQuantity(
                                                        ps.id,
                                                        int.parse(
                                                            updateController
                                                                .text),
                                                        widget.ps,
                                                        i);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Changed Success")));
                                              },
                                              color: Colors.deepOrange,
                                              child: const Text("Change  "),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: const Icon(Icons.edit))),
                      DataCell(GestureDetector(
                          onTap: () {
                            context
                                .read<FetchItAdminCubit>()
                                .deleteAnItem(ps, i, e.price, e.quantity);
                          },
                          child: const Icon(Icons.delete))),
                    ]));
              })
              .values
              .toList(),
    );
  }
}
