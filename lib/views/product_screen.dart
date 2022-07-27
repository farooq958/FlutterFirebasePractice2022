import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/productscubit/productscubitcontroller_cubit.dart';
import 'package:tasky/data/model.dart';
import 'package:tasky/shared_component/product_widget.dart';
import 'package:tasky/views/detail_cart_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<ProductscubitcontrollerCubit>().getproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        automaticallyImplyLeading: false,
        title: const Center(child: Text('ShoppingProducts')),
      ),
      bottomNavigationBar: BlocBuilder<ProductscubitcontrollerCubit,
          ProductscubitcontrollerState>(
        builder: (context, state) {
          if (state is ListOfProductsLoaded) {
            return GestureDetector(
              onTap: () {
                var pr = <Product>[];

                for (int i = 0; i < 4; i++) {
                  pr.add(state.prod!.products[i]);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailCartScreen(dta: pr)));
              },
              child: Container(
                color: Colors.blueGrey,
                height: 50,
                child: Center(
                  child: Text('Proceed'),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      body: BlocBuilder<ProductscubitcontrollerCubit,
          ProductscubitcontrollerState>(
        builder: (context, state) {
          if (state is ProductscubitcontrollerInitial) {
            return const CircularProgressIndicator();
          } else if (state is ListOfProductsLoaded) {
            return ListView.builder(
              //  state.prod!.products.length
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                // debugPrint(productapicontroller.productlist!.length.toString());
                return productcard(
                    pr: state.prod!.products[index],
                    total: state.prod!.products[index].quantity *
                        state.prod!.products[index].price);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
