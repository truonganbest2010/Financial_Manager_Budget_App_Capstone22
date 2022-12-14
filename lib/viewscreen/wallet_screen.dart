// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cap_project/model/user.dart' as usr;
import 'package:cap_project/viewscreen/transactionHistory_screen.dart';
import 'package:cap_project/viewscreen/transferMoney_screen.dart';
import 'package:cap_project/viewscreen/view/view_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/firestore_controller.dart';
import '../model/constant.dart';
import '../model/userTransaction.dart';
import '../model/wallet.dart';
import 'addBalance_screen.dart';
import 'moneyRequests_screen.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = '/walletScreen';
  final User user;
  final Wallet wallet;

  WalletScreen({
    required this.user,
    required this.wallet,
  });

  @override
  State<StatefulWidget> createState() {
    return _WalletState();
  }
}

class _WalletState extends State<WalletScreen> {
  late _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        title: const Text('Wallet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black,
                    Colors.blueAccent,
                  ])),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user.email!,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 110.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.green[50],
                        elevation: 7.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Current Balance",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 19.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      widget.wallet.card_saved == 0
                                          ? '\$0'
                                          : '\$' +
                                              widget.wallet.balance.toString(),
                                      style: const TextStyle(
                                        fontSize: 27.0,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 184, 145, 158),
                            Color.fromARGB(255, 104, 87, 176)
                          ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: ElevatedButton(
                          onPressed: con.addMoney,
                          child: const Text('Add Money',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.blueAccent,
                    Colors.grey,
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Colors.yellow,
                      height: 30.0, // space betwen top or bottom item
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 157,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            gradient: const LinearGradient(colors: [
                              Colors.green,
                              Color.fromARGB(255, 3, 65, 5),
                            ]),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: ElevatedButton(
                            onPressed: con.transferMoney,
                            child: const Text('Send/Request',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                // backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 157,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            gradient: const LinearGradient(colors: [
                              Colors.blue,
                              Color.fromARGB(255, 12, 22, 131)
                            ]),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: ElevatedButton(
                            onPressed: con.seeHistory,
                            child: const Text('Transaction History',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                // backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.yellow,
                      height: 30.0, // space betwen top or bottom item
                    ),
                    Center(
                      child: OutlinedButton.icon(
                        onPressed: con.seeRequests,
                        label: const Text('Friend Requests',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 175, 229, 124))),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        icon: const Icon(
                          Icons.info_rounded,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  late _WalletState state;
  late Wallet wallet;

  _Controller(this.state) {
    wallet = state.widget.wallet;
  }

  void addMoney() async {
    try {
      Wallet wallet =
          await FirestoreController.getWallet(state.widget.user.uid);

      await Navigator.pushNamed(state.context, AddBalanceScreen.routeName,
          arguments: {
            ArgKey.user: state.widget.user,
            ArgKey.wallet: wallet,
          });

      Wallet newWallet =
          await FirestoreController.getWallet(state.widget.user.uid);

      state.render(() {
        state.widget.wallet.balance = newWallet.balance;
      });
    } catch (e) {
      // ignore: avoid_print
      if (Constant.devMode) print('====== AddBalanceScreen error: $e');
      showSnackBar(
        context: state.context,
        message: 'Failed to get AddBalanceScreen: $e',
      );
    }
  }

  void transferMoney() async {
    try {
      List<usr.UserInfo> friendList = await FirestoreController.getFriendList(
          currentUID: state.widget.user.uid);
      Wallet wallet =
          await FirestoreController.getWallet(state.widget.user.uid);
      await Navigator.pushNamed(state.context, TransferMoneyScreen.routeName,
          arguments: {
            ArgKey.userList: friendList,
            ArgKey.wallet: wallet,
            ArgKey.user: state.widget.user,
          });
      Wallet newWallet =
          await FirestoreController.getWallet(state.widget.user.uid);

      state.render(() {
        state.widget.wallet.balance = newWallet.balance;
      });
    } catch (e) {
      // ignore: avoid_print
      if (Constant.devMode) print('====== TransferMoneyScreen error: $e');
      showSnackBar(
        context: state.context,
        message: 'Failed to get TransferMoneyScreen: $e',
      );
    }
  }

  void seeHistory() async {
    try {
      List<UserTransaction> transList =
          await FirestoreController.getTransactionHistory(
              currentUID: state.widget.user.uid);

      await Navigator.pushNamed(
          state.context, TransactionHistoryScreen.routeName,
          arguments: {
            ArgKey.transactionList: transList,
            ArgKey.user: state.widget.user,
          });
    } catch (e) {
      // ignore: avoid_print
      if (Constant.devMode) print('====== TransactionHistoryScreen error: $e');
      showSnackBar(
        context: state.context,
        message: 'Failed to get TransactionHistoryScreen: $e',
      );
    }
  }

  void seeRequests() async {
    try {
      List<UserTransaction> requestList =
          await FirestoreController.getMoneyRequest(
              currentUID: state.widget.user.uid);

      await Navigator.pushNamed(state.context, MoneyRequestsScreen.routeName,
          arguments: {
            ArgKey.requestList: requestList,
            ArgKey.user: state.widget.user,
            ArgKey.wallet: wallet,
          });

      Wallet newWallet =
          await FirestoreController.getWallet(state.widget.user.uid);

      state.render(() {
        state.widget.wallet.balance = newWallet.balance;
      });
    } catch (e) {
      // ignore: avoid_print
      if (Constant.devMode) print('====== MoneyRequestsScreen error: $e');
      showSnackBar(
        context: state.context,
        message: 'Failed to get MoneyRequestsScreen: $e',
      );
    }
  }
}
