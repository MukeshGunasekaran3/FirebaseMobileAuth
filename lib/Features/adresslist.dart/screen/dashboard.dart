import 'dart:ffi';

import 'package:batechtask/Features/adresslist.dart/Widgets/customalert.dart';
import 'package:batechtask/Features/adresslist.dart/provider/addressProivder.dart';
import 'package:batechtask/core/theme/color_palete.dart';
import 'package:batechtask/core/widgets/customSnackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    getdata();
    // TODO: implement initState
  }

  getdata() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<Addressproivder>(context, listen: false).getdata();
      } catch (e) {
        showSnackBar(
            message: e.toString(), context: context, color: Colors.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showalert(context: context, name: "", address: "", isedit: false);
          },
          child: Icon(
            Icons.add,
            color: ColorPallete.dark_Secondary_bgColor,
          ),
          backgroundColor: ColorPallete.dark_secondaryColor,
        ),
        body: Consumer<Addressproivder>(builder: (context, data, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Available Address",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: data.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: data.addresses.length ?? 0,
                          itemBuilder: (context, index) => Slidable(
                              key: ValueKey(data.addresses[index]),
                              endActionPane: ActionPane(
                                  motion: DrawerMotion(),
                                  extentRatio: 0.3,
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        showalert(
                                            index: data.addresses[index]["id"],
                                            context: context,
                                            name: data.addresses[index]
                                                    ["name"] ??
                                                "",
                                            address: data.addresses[index]
                                                    ["address"] ??
                                                "",
                                            isedit: true);
                                      },
                                      backgroundColor:
                                          ColorPallete.dark_secondaryColor,
                                      foregroundColor:
                                          ColorPallete.dark_Secondary_bgColor,
                                      padding: EdgeInsets.only(top: 5),
                                      icon: Icons.edit,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) async {
                                        try {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                            (_) async {
                                              await Provider.of<
                                                          Addressproivder>(
                                                      context,
                                                      listen: false)
                                                  .deletedata(
                                                      index:
                                                          data.addresses[index]
                                                              ["id"]);
                                            },
                                          );
                                        } catch (e) {
                                          // TODO
                                          showSnackBar(
                                              message: e.toString(),
                                              context: context,
                                              color: Colors.red);
                                        }
                                      },
                                      backgroundColor:
                                          ColorPallete.dark_secondaryColor,
                                      foregroundColor:
                                          ColorPallete.dark_Secondary_bgColor,
                                      icon: Icons.delete,
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                  ]),
                              child: ListTile(
                                tileColor: ColorPallete.dark_Secondary_bgColor,
                                title:
                                    Text(data.addresses[index]["name"] ?? ""),
                                subtitle: Text(
                                    data.addresses[index]["address"] ?? ""),
                                leading: CircleAvatar(
                                  child: Text(
                                      data.addresses[index]["name"][0] ?? ""),
                                  backgroundColor:
                                      ColorPallete.dark_secondaryColor,
                                ),
                              )),
                        ))
            ],
          );
        }),
      ),
    );
  }
}
