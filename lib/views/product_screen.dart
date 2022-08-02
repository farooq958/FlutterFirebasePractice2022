import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tasky/cubitss/productscubit/productscubitcontroller_cubit.dart';
import 'package:tasky/data/model.dart';
import 'package:tasky/shared_component/appbar_widget.dart';
import 'package:tasky/shared_component/product_widget.dart';
import 'package:tasky/views/detail_cart_screen.dart';

import '../data/suggestion_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<ProductscubitcontrollerCubit>().getProduct();
    super.initState();
  }

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigoAccent,
        automaticallyImplyLeading: false,
        flexibleSpace: const AppBarContainer(
          appBarTitle: 'Shopping Product',
        ),
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
              // Gradient button of Bottom navigation bar
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black12,
                      Colors.blueGrey,
                    ],
                  ),
                ),
                height: 50,
                child: const Center(
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
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
            return Column(
              children: [
                //search field Type ahead functionality
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TypeAheadField(
                        noItemsFoundBuilder: (context) => const Text(
                              "No item found",
                              style: TextStyle(color: Colors.brown),
                            ),
                        itemBuilder: (BuildContext context, itemData) {
                          return Text(itemData.toString());
                        },
                        onSuggestionSelected: (Object? suggestion) {
                          setState(() {
                            searchController.text = suggestion.toString();
                          });
                        },
                        suggestionsCallback: (String pattern) {
                          return SuggestionService.getSuggestions(
                              pattern, state.prod!.products);
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          onChanged: (e) {
                            setState(() {});
                          },
                          autofocus: false,
                          controller: searchController,
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              hintText: 'Search With Product Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                        )),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                    //  state.prod!.products.length
                    itemCount: state.prod!.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name = state.prod!.products[index].title;

                      if (searchController.text.isEmpty) {
                        return ProductCard(
                            pr: state.prod!.products[index],
                            total: state.prod!.products[index].quantity *
                                state.prod!.products[index].price);
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return ProductCard(
                            pr: state.prod!.products[index],
                            total: state.prod!.products[index].quantity *
                                state.prod!.products[index].price);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
