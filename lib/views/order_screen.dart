
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/fetch_cart_controller/fecth_controller_cubit.dart';
import 'package:tasky/views/order_screen_admin.dart';


import '../data/cart_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<FecthControllerCubit>().fetchit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    num gettotalprice(List<Productscart> ps,index) {
      int p = 0;
      for (  var i=0; i<4;i++) {
        p += ps[i].price * ps[1].quantity;
        print(ps[index].quantity.toString());
       // break;

      }
     // print(p.toString());
      return p;
    }
    num getnettotalprice(List<Productscart> ps,index,List<Cartmodel> crt) {
      double p = 0;
   var dat=   gettotalprice(ps,index);
      for (  var i=0; i<ps.length;i++) {
        p = (dat * crt[index].discount)/100;
      }
      return dat-p;
    }
// total(price,qauntity)
// {
//
//
//
//   return price * qauntity;
//
// }
//  gettotalprice(state.ps,index).toString()


    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Your Order')),
      ),
      body: Container(
        height: 700,
        color: Colors.blueGrey,
        child: BlocConsumer<FecthControllerCubit, FecthControllerState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FecthControllerLoaded) {

              return ListView.builder(


                  shrinkWrap: true,
                  itemCount: state.ls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        print(index.toString());
                        var ls= state.ls[index];
                        var ps= state.ps[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderAdmin(ls: ls,ps: ps,)));


                      },
                      child: Container(
                        height: 200,
                       // color: Colors.brown,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30)

                        ),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),

                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                 const Expanded(
                                    child:  Text(
                                      'Order ID ',
                                      style: TextStyle(
                                        color: Colors.white12,
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        state.ls[index].id.toString(),
                                        style: const TextStyle(
                                          color: Colors.white24,
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
SizedBox(height: 20,),
                            Row(
                              children: [
                               const Expanded(
                                  child:  Text(
                                    'Owner Name',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                 Expanded(
                                   flex: 2,
                                   child: Align(
                                     alignment: Alignment.bottomLeft,
                                     child: Text(
                                     FirebaseAuth.instance.currentUser!.displayName.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                   ),
                                 ),
                              ],
                            ),const SizedBox(height: 20,),
                            Row(
                              children: [
                                const Expanded(
                                  child:  Text(
                                    'Total Price',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(state.ls[index].TPrice.toString()
                                  ,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child:   Text(
                                    'Discount',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(child:  Text(
                                  state.ls[index].discount.toString()+"%",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),)
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                const Expanded(
                                  child:  Text(
                                    'Net Total',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      state.ls[index].NPrice.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(child: Text(state.ls[index].status==true?"Approved":"Pending")),


                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            if (state is FecthControllerInitial) {
              return Center(child: const CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
