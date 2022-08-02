import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/fetch_cart_controller/fetch_it_admin_cubit.dart';

import 'package:tasky/views/order_screen.dart';

import '../data/fproductcontroller.dart';
import '../shared_component/cart_datatable.dart';

class OrderAdmin extends StatefulWidget {
  final FirebaseProductsCart ps;

  const OrderAdmin({Key? key, required this.ps}) : super(key: key);

  @override
  State<OrderAdmin> createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<FetchItAdminCubit>().getIt(widget.ps.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController updateController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Product Detail"),
        ),
      ),
      body: BlocConsumer<FetchItAdminCubit, FetchItAdminState>(
        listener: (context, state) {
          if (state is FetchItAdminLoaded) {
            if (state.pr.products.isEmpty) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const OrderScreen()));
            }
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FetchItAdminLoaded) {
            if (state.pr.products.isNotEmpty) {
              return ListView(
                children: [
                  Container(
                    height: 300,
                    color: Colors.grey,
                    child: ListView(
//
                      scrollDirection: Axis.horizontal,
                      children: [
                        CartDataTable(
                            ps: state.pr,
                            updateController: updateController,
                            widget: widget),
                      ],
                    ),
                  ),
                  Text(
                    'Total Price: \$ ${state.pr.totalPrice}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    'Net Price: \$ ${state.pr.netPrice}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Container(
                    height: 100,
                    color: state.pr.status == false
                        ? Colors.red
                        : Colors.greenAccent,
                    child: Center(
                        child: Text(
                            state.pr.status == false ? "pending" : "Approved")),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      context.read<FetchItAdminCubit>().changeStatus(
                          widget.ps.id,
                          state.pr.status == false ? true : false);
// showDialog(context: context, builder: (context)=> AlertDialog(content: SizedBox(
//     height: 100,
//     child: Column(
//       children: const [
//         Text("Changing Status"),
//         Center(child: CircularProgressIndicator(),),
//       ],
//     )),));
//  await Future.delayed(const Duration(seconds: 2));
//  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderScreen()));

                      //context.read<FetchItAdminCubit>().getit(widget.ps.id);
                    },
                    color: Colors.indigo,
                    child: const Text("Change status"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      context
                          .read<FetchItAdminCubit>()
                          .deleteWholeCart(widget.ps.id);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: SizedBox(
                                    height: 100,
                                    child: Column(
                                      children: const [
                                        Text("Changing Status"),
                                        Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    )),
                              ));
                      Future.delayed(const Duration(seconds: 2));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderScreen()));
                    },
                    color: Colors.black,
                    child: const Text(
                      "Delete Whole Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            } else {
              context.read<FetchItAdminCubit>().deleteWholeCart(widget.ps.id);
              return const Center(
                child: Text("No data"),
              );
            }
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }
}

// BlocBuilder<FetchItAdminCubit, FetchItAdminState>(
// builder: (context, state) {
// if (state is FetchItAdminLoaded)
// {
// return ListView(
//
// children: [
// DataTable(columns: const [
// DataColumn(label: Text('Product Name')),
// DataColumn(label: Text('Price')),
// DataColumn(label: Text('Quantity'))
//
// ], rows:
// state.pr.map((e) {
// return DataRow(cells: [ DataCell(Text(e.title)),
// DataCell(Text(e.price.toString())),
// DataCell(Text(e.quantity.toString())),
//
// ]);
// }).toList(),
//
// ),
//
// ],
//
// );}
// else{
//
// return Center(child: CircularProgressIndicator(),);
// }
// },
// )
