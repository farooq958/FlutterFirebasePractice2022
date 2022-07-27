import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tasky/cubitss/invoice_cubit/fetch_invoice/fetchcontroller_cubit.dart';
import 'package:tasky/cubitss/invoice_cubit/invoice_cubit.dart';
import 'package:tasky/data/invoicemodel.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var invoicenumbercontroller = TextEditingController();
  var recievrcontroller = TextEditingController();
  var sendercontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    context.read<FetchcontrollerCubit>().fetchInvoice(uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validate()
    {
      if(invoicenumbercontroller.text=="" && sendercontroller.text=="" && recievrcontroller.text=="") {
        return false;
      }
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(

        title: const Center(child: Text('Invoices')),
    flexibleSpace: Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Colors.black, Colors.blue]),
    ),),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

          invoicenumbercontroller.clear();
          sendercontroller.clear();
          recievrcontroller.clear();
          showDialog(context: context, builder: (context) =>
              AlertDialog(
                backgroundColor: Colors.cyan,
title: const Text('Add Invoice')
,                content: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,

                        colors: [
                          Colors.blue,
                          Colors.red,

                        ],
                      ),
                    shape: BoxShape.rectangle,
border: Border.all(color: Colors.black)
                  ),
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const   Expanded(child: Align(alignment: Alignment.bottomLeft, child: Text('Invoice Number', style:  TextStyle(fontSize: 12,color: Colors.greenAccent)))),
                      Expanded(
                        child: TextFormField(
                          controller: invoicenumbercontroller,
                          decoration: const InputDecoration(
                            hintText: 'Invoice number',

                          ),),
                      ),
                      const Expanded(child: Align( alignment: Alignment.bottomLeft,child: Text('Sender Name' ,style: TextStyle(fontSize: 12,color: Colors.greenAccent)))),
                      Expanded(
                        child: TextFormField(
                          controller: sendercontroller,
                          decoration: const InputDecoration(
                            hintText: 'Sender name',

                          ),),
                      ),
                      const   Expanded(child: Align(alignment: Alignment.bottomLeft, child: Text('Reciever name' , style: TextStyle(fontSize: 12,color: Colors.greenAccent),))),
                      Expanded(
                        child: TextFormField(
                          controller: recievrcontroller,
                          decoration: const InputDecoration(
                            hintText: 'Reciever name',

                          ),),
                      )

                    ],
                  ),

                ),
                actions: [
                  MaterialButton(
                    color: Colors.greenAccent,
                    onPressed: () {

                       context.read<InvoiceCubit>().createInvoice(Invoice(
                           invoiceNumber: invoicenumbercontroller.text,
                           receiverName: recievrcontroller.text,
                           senderName: sendercontroller.text), uid);
                       Navigator.pop(context);

                    }, child: const Text('Add Invoice'),)

                ],

              ));
        },


      ),
      body: BlocListener<InvoiceCubit, InvoiceState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is InvoiceCreatingError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry, some error occur')));
          }
          if (state is InvoiceCreated) {
            invoicenumbercontroller.clear();
            sendercontroller.clear();
            recievrcontroller.clear();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('created')));
          }
          if (state is InvoiceUpdated) {
            String text=' ';
            text = invoicenumbercontroller.text;
            invoicenumbercontroller.clear();
            sendercontroller.clear();
            recievrcontroller.clear();
            ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Updated Invoice number:$text')));
          }
          if (state is InvoiceUpdateerror) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry, some update error occur')));
          }
          if (state is InvoiceDeeltingerror) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry, some deleting error occur')));
          }
          if (state is InvoiceDeleted) {

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Deleted')));
          }

          },
          child:

    BlocBuilder<FetchcontrollerCubit, FetchcontrollerState>(
        builder: (context, state) {

          if (state is FetchInvoiceInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is InvoiceFetched) {
            return state.invoice.isEmpty
                ?  Column(
                  children: [
                    Expanded(child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_qlwqp9xi.json')),
                  
                     Expanded(child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_fFVfCt.json'))
                  ],
                )
                : Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListView.builder(
                  itemCount: state.invoice.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 400,

                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // Add one stop for each color. Stops should increase from 0 to 1
                            stops: const [0.2, 0.4, 0.7, 0.9],
                            colors: [

                              Colors.indigo[800]!,
                              Colors.pink[700]!,
                              Colors.indigo[600]!,
                              Colors.yellow[400]!,
                            ],
                          ),
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Invoice Number',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                state.invoice[index].invoiceNumber
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sender Name',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                state.invoice[index].senderName
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Receiver Name',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                state.invoice[index].receiverName
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  invoicenumbercontroller.text=   state.invoice[index].invoiceNumber;
                                  sendercontroller.text=   state.invoice[index].senderName;
                                  recievrcontroller.text=   state.invoice[index].receiverName;
                                  showDialog(context: context, builder: (context) =>
                                      AlertDialog(
                                        backgroundColor: Colors.cyan,
                                        title: const Text('Update Invoice'),
                                        content: Container(
                                          height: 300,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,

                                                colors: [
                                                  Colors.blue,
                                                  Colors.red,

                                                ],
                                              ),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
    const   Expanded(child: Align(alignment: Alignment.bottomLeft, child: Text('Invoice Number', style:  TextStyle(fontSize: 12,color: Colors.greenAccent)))),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: invoicenumbercontroller,
                                                  decoration: const InputDecoration(
                                                    hintText: 'Invoice number',

                                                  ),),
                                              ),
                                             const Expanded(child: Align( alignment: Alignment.bottomLeft,child: Text('Sender Name' ,style: TextStyle(fontSize: 12,color: Colors.greenAccent)))),
                                               Expanded(
                                                 child: TextFormField(
                                                  controller: sendercontroller,
                                                  decoration: const InputDecoration(
                                                    hintText: 'Sender name',

                                                  ),),
                                               ),
                                           const   Expanded(child: Align(alignment: Alignment.bottomLeft, child: Text('Reciever name' , style: TextStyle(fontSize: 12,color: Colors.greenAccent),))),
                                               Expanded(
                                                 child: TextFormField(
                                                  controller: recievrcontroller,
                                                  decoration: const InputDecoration(
                                                    hintText: 'Reciever name',

                                                  ),),
                                               )

                                            ],
                                          ),

                                        ),
                                        actions: [
                                          MaterialButton(
                                            color: Colors.greenAccent,
                                            onPressed: () {
                                              print(state.invoice[index].invoiceId);
                                              context.read<InvoiceCubit>().updateInvoice(Invoice(
                                                  invoiceNumber: invoicenumbercontroller.text,
                                                  receiverName: recievrcontroller.text,
                                                  senderName: sendercontroller.text),uid, state.invoice[index].invoiceId);
                                              Navigator.pop(context);
                                            }, child: const Text('Update Invoice'),)

                                        ],

                                      ));
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              InkWell(
                                onTap: () async {

                                 showDialog(context: context, builder: (context)=> AlertDialog(

                                   content: const Text('Do you want To Delete This Invoice?'),
                                   actions: [
                                     MaterialButton(onPressed: (){
                                       context.read<InvoiceCubit>().delete(state.invoice[index].invoiceId!, uid);
                               Navigator.pop(context);
                                     } ,child: const Text('Yes'),),
                                     MaterialButton(onPressed: (){

                                       Navigator.pop(context);
                                     },child: const Text('No/Cancel'),)

                                   ],

                                 ));

                                   //context.read<InvoiceCubit>().delete(state.invoice[index].invoiceId!, uid);


                                    }

                                ,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          }
          if(state is InvoicefetchingError){
            showDialog(context: context, builder: (context)=>AlertDialog(

           content: Text(state.msg),

            ));

          }
          return Container();



        },
    ))
    );
  }
}
