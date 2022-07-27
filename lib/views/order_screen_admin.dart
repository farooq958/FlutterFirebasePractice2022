import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/fetch_cart_controller/fetch_it_admin_cubit.dart';
import 'package:tasky/data/cart_model.dart';

import '../cubitss/fetch_cart_controller/fecth_controller_cubit.dart';

class OrderAdmin extends StatefulWidget {
  Productscart ps;

  Cartmodel ls;

  OrderAdmin({Key? key, required this.ls, required this.ps}) : super(key: key);

  @override
  State<OrderAdmin> createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin> {
@override
  void initState() {
    // TODO: implement initState
  context.read<FetchItAdminCubit>().getit(widget.ls.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text("Product Detail"),),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.grey,
            child: BlocBuilder<FetchItAdminCubit, FetchItAdminState>(
              builder: (context, state) {
                if (state is FetchItAdminLoaded)
                  {
                return ListView(

                  children: [
                    DataTable(columns: const [
                      DataColumn(label: Text('Product Name')),
                      DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Quantity'))

                    ], rows:
                    state.pr.map((e) {
                      return DataRow(cells: [ DataCell(Text(e.title)),
                        DataCell(Text(e.price.toString())),
                        DataCell(Text(e.quantity.toString())),

                      ]);
                    }).toList(),

                    ),

                  ],

                );}
                else{

                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),

          ),
          Container(height: 100,color: widget.ls.status==false?Colors.red:Colors.greenAccent,

          child: Center(child: Text(widget.ls.status==false?'Pending': 'Approved')),
          ),
          MaterialButton(onPressed: (){
 context.read<FetchItAdminCubit>().changestatus(widget.ls.id, widget.ls.status==false?true:false);

          }
          ,color: Colors.indigo
          ,child: const Text("Change status"),

          )
        ],
      ),

    );
  }
}
