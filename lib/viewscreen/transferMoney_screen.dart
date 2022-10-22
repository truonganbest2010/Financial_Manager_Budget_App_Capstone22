import 'package:cap_project/controller/auth_controller.dart';
import 'package:cap_project/viewscreen/view/view_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cap_project/model/user.dart' as usr;

import '../controller/firestore_controller.dart';
import '../model/constant.dart';
import '../model/wallet.dart';

class TransferMoneyScreen extends StatefulWidget {
  static const routeName = '/transferMoneyScreen';
  final User user;
  final Wallet wallet;
  final List<usr.UserInfo> friendList;
  TransferMoneyScreen({
    required this.user,
    required this.wallet,
    required this.friendList,
  });

  @override
  State<StatefulWidget> createState() {
    return _TransferMoneyState();
  }
}

class _TransferMoneyState extends State<TransferMoneyScreen> {
  late _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool editMode = false;
  usr.UserInfo? eachUser = null;
  Transfer transfer = Transfer.Send;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send/Request'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'From',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              TextFormField(
                initialValue: widget.user.email,
                decoration: InputDecoration(hintText: '${widget.user.email}'),
                enabled: false,
              ),
              SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'To',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 83, 101, 116),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<usr.UserInfo>(
                    value: eachUser,
                    onChanged: con.selectFriend,
                    isExpanded: true,
                    items: [
                      for (var c in widget.friendList)
                        DropdownMenuItem<usr.UserInfo>(
                          child: Text(
                            c.email,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          value: c,
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Send/Request',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 83, 101, 116),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Transfer>(
                    value: transfer,
                    onChanged: con.chooseTranferType,
                    isExpanded: true,
                    items: [
                      for (var c in Transfer.values)
                        DropdownMenuItem<Transfer>(
                          child: Text(
                            c.toString().split('.')[1].replaceFirst('_', ' '),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          value: c,
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  maxLength: 6,
                  validator: con.validateAmount,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onSaved: con.saveAmount,
                  decoration: const InputDecoration(
                    hintText: "\$",
                    labelText: "Enter the amount",
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 74, 125, 193),
                ),
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: const Text('Submit'),
                ),
                onPressed: con.submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  late _TransferMoneyState state;
  late int? amount;

  _Controller(this.state);

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty || int.parse(value) <= 0) {
      return 'Please enter value greater than 0';
    }
    return null;
  }

  void saveAmount(String? value) {
    if (value != null) amount = int.parse(value);
  }

  Future<void> selectFriend(usr.UserInfo? value) async {
    state.render(() {
      state.eachUser = value!;
    });
  }

  Future<void> chooseTranferType(Transfer? value) async {
    state.render(() {
      state.transfer = value!;
    });
  }

  void submit() {}
}
