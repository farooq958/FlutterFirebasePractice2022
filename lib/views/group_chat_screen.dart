import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/firebasegroupmessaging_cubit.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController messageEditingController =
      TextEditingController();

  String? username = FirebaseAuth.instance.currentUser!.phoneNumber;

  @override
  void initState() {
    context.read<FirebasegroupmessagingCubit>().getChatMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation Screen "),
      ),
      body: Column(
        children: [
          Expanded(flex: 4, child: chatMessages(context)),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Colors.grey,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      decoration: const InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Colors.black, Colors.blue],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            "assest/images/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// chat messages
  chatMessages(BuildContext context) {
    return BlocBuilder<FirebasegroupmessagingCubit,
        FirebasegroupmessagingState>(
      builder: (context, state) {
        if (state is FirebasegroupmessagingLoaded) {
          return ListView.builder(
            reverse: true,
            itemBuilder: (context, index) {
              return MessageTile(
                message: state.chats[index].msg.message,
                sendByMe: username == state.chats[index].msg.sendBy,
                iD: state.chats[index].id,
              );
            },
            itemCount: state.chats.length,
          );
        }
        if (state is FirebasegroupmessagingInitial) {
          return const CircularProgressIndicator();
        }
        if (state is FirebasegroupmessagingDelte) {
          if (state.check == true) {
            context.read<FirebasegroupmessagingCubit>().getChatMessages();
          }
        }
        return const SizedBox(
          height: 0,
          width: 0,
        );
      },
    );
  }

  void addMessage() {
    Map<String, dynamic> chatMessageMap = {
      "sendBy": username,
      "message": messageEditingController.text,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    context.read<FirebasegroupmessagingCubit>().addMessage(chatMessageMap);
  }
}

//message show widget
class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String iD;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.sendByMe,
      required this.iD})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var updatedController = TextEditingController(text: message);
    Map<String, dynamic> chatMessageMap = {
      "sendBy": FirebaseAuth.instance.currentUser!.phoneNumber,
      "message": updatedController.text,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: sendByMe
              ? const EdgeInsets.only(left: 30)
              : const EdgeInsets.only(right: 30),
          padding:
              const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [Colors.black, Colors.grey],
              )),
          child: GestureDetector(
            onDoubleTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: SizedBox(
                          height: 200,
                          child: TextFormField(
                            controller: updatedController,
                          ),
                        ),
                        actions: [
                          GestureDetector(
                              onTap: () {
                                if (sendByMe) {
                                  context
                                      .read<FirebasegroupmessagingCubit>()
                                      .updateIt(chatMessageMap, iD);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Icon(Icons.add))
                        ],
                      ));
            },
            onLongPress: () {
              if (sendByMe) {
                var snack = SnackBar(
                  content: const Text('Do You want to delete this message '),
                  action: SnackBarAction(
                    label: 'Yes',
                    onPressed: () {
                      context.read<FirebasegroupmessagingCubit>().deleteIt(iD);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
              }
            },
            child: Text(message,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300)),
          ),
        ),
      ),
    );
  }
}
