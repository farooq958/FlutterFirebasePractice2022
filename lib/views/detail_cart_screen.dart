import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/cart_controller/cart_controller_cubit.dart';
import 'package:tasky/data/model.dart';
import 'package:tasky/views/order_screen.dart';

//ignore: must_be_immutable
class DetailCartScreen extends StatelessWidget {
  List<Product> dta;

  DetailCartScreen({Key? key, required this.dta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discount = 0;
    getDiscount() {
      for (var i in dta) {
        discount = i.discountPercentage;
      }
      return discount;
    }

//total price
    num getTotalPrice() {
      int p = 0;
      for (var i in dta) {
        p += i.price * i.quantity;
      }
      return p;
    }

// net total
    getTotal() {
      var totaled = (getTotalPrice() * getDiscount()) / 100;

      return getTotalPrice() - totaled;
    }

    return BlocListener<CartControllerCubit, CartControllerState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CartControllerInitial) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text('redirecting you to order Page'),
                          CircularProgressIndicator()
                        ],
                      ),
                    ),
                  ));
        }
        if (state is CartControllerLoaded) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const OrderScreen()));
        }
      },
      child: Scaffold(
          bottomNavigationBar: GestureDetector(
              onTap: () {
                context
                    .read<CartControllerCubit>()
                    .sendData(dta, getTotalPrice(), getTotal(), getDiscount());
              },
              child: Container(
                height: 60,
                color: Colors.deepPurple,
                child: const Center(child: Text('CheckOut')),
              )),
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
            title: const Center(
              child: Text('Detail Cart'),
            ),
          ),
          body: ListView(
            children: [
              // Tabular widget of data of ordered cart
              DataTable(
                columns: const [
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Quantity'))
                ],
                rows: dta.map((e) {
                  return DataRow(cells: [
                    DataCell(Text(e.title)),
                    DataCell(Text(e.price.toString())),
                    DataCell(Text(e.quantity.toString())),
                  ]);
                }).toList(),
              ),
              Text(
                'Total Price \$ ${getTotalPrice()} ',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Discount % ${getDiscount()} ',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Net Total \$ ${getTotal()} ',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
