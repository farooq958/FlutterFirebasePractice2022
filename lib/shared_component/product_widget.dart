

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubitss/quantity_controller/quantity_controller_cubit.dart';
import '../data/model.dart';

class productcard extends StatelessWidget {

int total;
final Product pr;

   productcard({Key? key,required this.total, required this.pr  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
width: 393,
      height:200 ,
color: Colors.white12,
child: Column(
  children:  <Widget>[
    Expanded( flex:1,child: Row(
      children:  <Widget>[
        Expanded(child: Image.network(pr.images.first))
        ,
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(child: Align(alignment:Alignment.bottomCenter,child: Text(pr.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
              Expanded(child: Text(pr.description)),
            ],
          ),
        ),

        Expanded(
          child: Column(
            children: [
              const Expanded(child: Align(alignment: Alignment.bottomCenter, child: Text('Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
              Expanded(child: Text(pr.category) ),
            ],
          ),
        )
        
      ],
    )
    ),

    Expanded(child: BlocBuilder<QuantityControllerCubit, int>(
  builder: (context, state) {
    return Row(
              children:  <Widget>[

                Expanded(
                  child: Column(
                    children: [
                      const Expanded(child: Align(alignment: Alignment.bottomCenter, child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                      Expanded(child: Text( '\$ ${pr.price.toString()}') ),

                    ],
                  ),
                ),
Flexible(child: GestureDetector(
    onTap: ()
    {

      if(pr.quantity > 1) {
        context.read<QuantityControllerCubit>().increment(pr.quantity--);
        total = total-pr.price;
        //decrement
      }
    },
    child: Container(height: 30,width: 20,color: Colors.blueGrey, child: const Center(child: Text('-',style: TextStyle(fontSize: 30),)),))),

                Expanded(child: Align(alignment:Alignment.center,child: SizedBox(height: 30,width: 20, child:Text(pr.quantity.toString()) ,))),
                Flexible(child: GestureDetector(
                    onTap:()
    {
      context.read<QuantityControllerCubit>().increment(pr.quantity++);
      total = total+pr.price;
      //increment

    },child: Container(height: 30,width: 20,color: Colors.blueGrey, child: const Center(child: Text('+',style: TextStyle(fontSize: 30),)),)))
,
                 const Expanded( flex:2,child: Align(alignment:Alignment.centerRight, child: Text('Total Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
     Expanded(flex:2,child: Text(total.toString(),style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 30),))

              ],
            );
  },
),
          )
    ,


  ],
),



    );
  }
}
