import 'dart:ui';

import 'package:blocks/appstate.dart';
import 'package:blocks/model/block.dart';
import 'package:blocks/model/user.dart';
import 'package:blocks/service/block_service.dart';
import 'package:blocks/service/user_service.dart';
import 'package:blocks/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'dart:math';

class EditBlocks extends StatefulWidget {
  AppState appState;
  BlockService blockService;
  UserService userService = UserService();
  //TwilioFlutter _twilioFlutter = TwilioFlutter(accountSid: accountSid, authToken: authToken, twilioNumber: twilioNumber);

  EditBlocks({this.appState, this.blockService});

  @override
  _EditBlocksState createState() => _EditBlocksState();
}

class _EditBlocksState extends State<EditBlocks> {
  int range = 0;

  @override
  Widget build(BuildContext context) {
    print('Here in edit page: ${widget.appState}');
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: kFooter,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 2,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: kBrand,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 23.0, left: 10),
          child: Text(widget.appState.name ?? ''),
        ),
        automaticallyImplyLeading: true,
        actions: [
          Container(
            margin: EdgeInsets.only(top: 25, right: 20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text("Home"),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: widget.appState.isLoggedIn && widget.appState.isApproved
          ? SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    if (widget.appState.isAdmin) ...[
                      Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 30,
                              child: SizedBox(
                                width: window.physicalSize.width,
                                child: Center(
                                    child: Text(
                                  'Pending Administrators',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                              ),
                            ),
                            StreamBuilder(
                              stream: widget.userService.allUsers(widget.appState.passcode),
                              builder: (context, AsyncSnapshot<List<User>> snapshot) {
                                print(snapshot);
                                if (snapshot?.data?.isNotEmpty ?? false) {
                                  List<User> unapprovedUsers = snapshot.data.where((user) => !user.isApproved).toList();
                                  if (unapprovedUsers.isNotEmpty)
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: unapprovedUsers.length,
                                      itemBuilder: (context, index) => Container(
                                        width: 60,
                                        child: Card(
                                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(unapprovedUsers[index].userName ?? 'kkjjj'),
                                              Column(
                                                children: [
                                                  Text("Change status to admin"),
                                                  Switch(
                                                      value: unapprovedUsers[index].isApproved ?? false,
                                                      onChanged: (bool) {
                                                        setState(() {
                                                          unapprovedUsers[index].isApproved = bool;
                                                          widget.userService.updateUser(unapprovedUsers[index]);
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  return EmptyWidget(message: 'No admins yet...');
                                }
                                return EmptyWidget(message: 'No admins yet...');
                              },
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],

                    //second area
                    Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 1,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 30,
                                  child: SizedBox(
                                    width: window.physicalSize.width,
                                    child: Center(
                                        child: Text(
                                      'All Confirmed Buyers',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )),
                                  ),
                                ),
                                StreamBuilder(
                                  stream: widget.blockService.allBlocks,
                                  builder: (context, AsyncSnapshot<List<Block>> snapshot) {
                                    if (snapshot.hasData) {
                                      List<Block> unapprovedBlockBuyers = snapshot.data.where((block) => block.isPaidFor == true).toList();
                                      range = unapprovedBlockBuyers.length;
                                      if (unapprovedBlockBuyers.isNotEmpty)
                                        return Column(
                                          children: [
                                            ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: unapprovedBlockBuyers.length,
                                              itemBuilder: (context, index) => Container(
                                                width: MediaQuery.of(context).size.width / 4,
                                                child: Card(
                                                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(unapprovedBlockBuyers[index]?.owner ?? 'Unknown'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            '| Amount paid: ${unapprovedBlockBuyers[index]?.cashappId[0] != '\$' ? '\$' : ''}' +
                                                                    unapprovedBlockBuyers[index]?.cashappId ??
                                                                'Unknown '),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('| Phone Number: ' + unapprovedBlockBuyers[index]?.phoneNumber ?? 'Unknown'),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              widget.blockService.deleteBlock(unapprovedBlockBuyers[index]);
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                OutlineButton(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    padding: EdgeInsets.all(10),
                                                    onPressed: () => selectWinners(true, unapprovedBlockBuyers),
                                                    child: Row(
                                                      children: [
                                                        Text('Display Row and Column numbers'),
                                                        Icon(
                                                          Icons.wine_bar,
                                                          color: Colors.amber,
                                                        )
                                                      ],
                                                    )),
                                                // SizedBox(
                                                //   width: 10,
                                                // ),
                                                // OutlineButton(
                                                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                //     padding: EdgeInsets.all(10),
                                                //     onPressed: () => selectWinners(true, unapprovedBlockBuyers),
                                                //     child: Row(
                                                //       children: [
                                                //         Text('Enter winning row and column'),
                                                //         Icon(
                                                //           Icons.wine_bar,
                                                //           color: Colors.amber,
                                                //         )
                                                //       ],
                                                //     )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        );
                                      return EmptyWidget(message: 'No blocks paid for yet...');
                                    }

                                    return EmptyWidget(message: 'No blocks paid for yet...');
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (widget.appState.isApproved) ...[
                            Card(
                              elevation: 1,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 30,
                                    child: SizedBox(
                                      width: window.physicalSize.width,
                                      child: Center(
                                          child: Text(
                                        'List of Administrators',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      )),
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: widget.userService.allUsers(widget.appState.passcode),
                                    builder: (context, AsyncSnapshot<List<User>> snapshot) {
                                      if (snapshot.data != null) {
                                        List<User> unapprovedUsers = snapshot.data.where((user) => user.isApproved).toList();
                                        if (unapprovedUsers.isNotEmpty)
                                          return ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: unapprovedUsers.length,
                                            itemBuilder: (context, index) => Container(
                                              width: MediaQuery.of(context).size.width / 4,
                                              child: Card(
                                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(unapprovedUsers[index].userName ?? 'Unknown'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );

                                        return EmptyWidget(message: 'No admins');
                                      }

                                      return EmptyWidget(message: 'No admins');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.black12,
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.tag_faces),
                      Text(
                        'Not Logged In,\n Waiting for Admins Approval',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  bool checkreservationValidity(List<Block> unapprovedBlockBuyers, int index) =>
      unapprovedBlockBuyers[index].reserveDate.difference(DateTime.now()).inHours > 3;

  FittedBox EmptyWidget({String message}) {
    return FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.fitWidth,
      child: Text(message ?? 'No Admins to approve yet'),
    );
  }

  void selectWinners(bool random, List<Block> blocks) {
    int randomWinner = Random().nextInt(range);
    Block winningBlock = blocks[randomWinner];
    winningBlock.winner = true;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Are you sure you want to display the random column and row numbers?\n This Action cannot be reversed',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('No'),
                ),
                TextButton(
                    onPressed: () {
                      widget.blockService.toggleRandomDisplay().then((value) {
                        widget.appState.showRandomRows();
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Yes'))
              ],
            )
          ]),
    );
  }
}
