import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubitss/quantity_controller/quantity_controller_cubit.dart';
import '../data/model.dart';

//ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  int total;
  final Product pr;

  ProductCard({Key? key, required this.total, required this.pr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black12,
              Colors.limeAccent,
            ],
          ),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(child: Image.network(pr.images.first)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  pr.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ))),
                        Expanded(child: Text(pr.description)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ))),
                        Expanded(child: Text(pr.category)),
                      ],
                    ),
                  )
                ],
              )),
          Expanded(
            child: BlocBuilder<QuantityControllerCubit, int>(
              builder: (context, state) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))),
                          Expanded(child: Text('\$ ${pr.price.toString()}')),
                        ],
                      ),
                    ),
                    Flexible(
                        child: GestureDetector(
                            onTap: () {
                              if (pr.quantity > 1) {
                                context
                                    .read<QuantityControllerCubit>()
                                    .increment(pr.quantity--);
                                total = total - pr.price;
                                //decrement
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.brown),
                              child: const Center(
                                  child: Text(
                                '-',
                                style: TextStyle(fontSize: 30),
                              )),
                            ))),
                    Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Text(pr.quantity.toString()),
                            ))),
                    Flexible(
                        child: GestureDetector(
                            onTap: () {
                              context
                                  .read<QuantityControllerCubit>()
                                  .increment(pr.quantity++);
                              total = total + pr.price;
                              //increment
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.brown),
                              child: const Center(
                                  child: Text(
                                '+',
                                style: TextStyle(fontSize: 30),
                              )),
                            ))),
                    const Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Total Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ))),
                    Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "\$$total",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                color: total % 2 == 0
                                    ? Colors.indigo
                                    : total % 3 == 0
                                        ? Colors.black54
                                        : Colors.black),
                          ),
                        ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
