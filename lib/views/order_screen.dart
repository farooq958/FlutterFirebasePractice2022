import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/fetch_cart_controller/fecth_controller_cubit.dart';
import 'package:tasky/views/order_screen_admin.dart';
import 'package:tasky/views/product_screen.dart';

import '../shared_component/appbar_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<FecthControllerCubit>().fetchit2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigoAccent,
        automaticallyImplyLeading: false,
        flexibleSpace: const AppBarContainer(
          appBarTitle: 'Your Order',
        ),
      ),
      body: Container(
        height: 700,
        color: Colors.black12,
        child: BlocConsumer<FecthControllerCubit, FecthControllerState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FecthControllerLoaded) {
              if (state.ps.isEmpty) {
                return SizedBox(
                  height: 500,
                  width: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("No Cart Data"),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductScreen()));
                        },
                        color: Colors.green,
                        child: const Text('Add Some data '),
                      )
                    ],
                  ),
                );
              } else {
                //List View builder for data of firebase fetched
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ps.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //   print(index.toString());
                          // var ls= state.ls[index];
                          var ps = state.ps[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderAdmin(
                                        ps: ps,
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          height: 200,
                          // color: Colors.brown,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.black12,
                                  Colors.grey,
                                ],
                              ),
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Order ID ',
                                        style: TextStyle(
                                            color: Colors.white12,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        //state.ls[index].id.toString(),
                                        child: Text(
                                          state.ps[index].id,
                                          style: const TextStyle(
                                              color: Colors.white24,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Owner Name',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        FirebaseAuth
                                            .instance.currentUser!.displayName
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Total Price',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      //state.ls[index].TPrice.toString()
                                      child: Text(
                                        state.ps[index].totalPrice.toString(),
                                        style: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Discount',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ), //state.ls[index].discount.toString()
                                  Expanded(
                                    child: Text(
                                      "${state.ps[index].discount}%",
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Net Total',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      //state.ls[index].NPrice.toString()
                                      child: Text(
                                        state.ps[index].netPrice.toString(),
                                        style: const TextStyle(
                                            color: Colors.limeAccent,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    state.ps[index].status == true
                                        ? "Approved"
                                        : "Pending",
                                    style: TextStyle(
                                        color: state.ps[index].status == true
                                            ? Colors.green
                                            : Colors.red),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
            if (state is FecthControllerInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
