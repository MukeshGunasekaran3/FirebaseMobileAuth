import 'package:batechtask/Features/Authentication/provider/Authprovider.dart';
import 'package:batechtask/Features/adresslist.dart/screen/dashboard.dart';
import 'package:batechtask/core/theme/color_palete.dart';
import 'package:batechtask/core/widgets/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    fetchmobilenumber();
  }

  fetchmobilenumber() async {
    try {
      await Provider.of<AuthProivder>(context, listen: false)
          .initSimInfoState();
      phoneController.text =
          context.read<AuthProivder>().simInfo![0].number.substring(3);
    } on Exception catch (e) {
      showSnackBar(message: e.toString(), context: context, color: Colors.red);
    }
  }

  GlobalKey<FormState> key1 = GlobalKey();
  GlobalKey<FormState> key2 = GlobalKey();
  PageController controller = PageController(initialPage: 0);
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProivder>(builder: (context, data, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (data.otpSent || data.verificationId.isNotEmpty) {
            controller.nextPage(
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          }
        });
        return Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome !",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: ColorPallete.dark_secondaryColor),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      Form(
                        key: key1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Mobile Number:",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: InputDecoration(
                                prefix: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text("+91"),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "field is required";
                                } else if (!RegExp(r"^[6-9]\d{9}$")
                                    .hasMatch(value)) {
                                  return "Enter a valid 10-digit mobile number";
                                }
                                return null;
                              },
                            ),
                            Expanded(child: Text("")),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      if (key1.currentState!.validate()) {
                                        try {
                                          await data.sendOtp(
                                              phonenumber:
                                                  phoneController.text);
                                          if (data.otpSent ||
                                              data.verificationId.isNotEmpty) {
                                            data.cutloader();
                                            controller.nextPage(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.linear);
                                          }
                                        } catch (e) {
                                          data.cutloader();

                                          showSnackBar(
                                              message: e.toString(),
                                              context: context,
                                              color: Colors.red);
                                        }
                                      }
                                    },
                                    child: data.isLoading
                                        ? const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          )
                                        : Text(
                                            'send Otp',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: ColorPallete
                                                        .dark_BgColor),
                                          )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: key2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter OTP:",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: otpController,
                              decoration: InputDecoration(
                                  prefix: SizedBox(
                                width: 5,
                              )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "field is required";
                                }
                              },
                            ),
                            Expanded(child: Text("")),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      controller.previousPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.linear);
                                    },
                                    child: Text(
                                      'Re-enter',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: ColorPallete.dark_BgColor),
                                    )),
                                ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (key2.currentState!.validate()) {
                                          await data.verifyOtp(
                                              otp: otpController.text);
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashBoard(),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false);
                                          data.cutloader();
                                        }
                                      } catch (e) {
                                        data.cutloader();

                                        showSnackBar(
                                            message: e.toString(),
                                            context: context,
                                            color: Colors.red);
                                      }
                                    },
                                    child: data.isLoading
                                        ? const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          )
                                        : Text(
                                            'Validate',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: ColorPallete
                                                        .dark_BgColor),
                                          )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
