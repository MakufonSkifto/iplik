import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iplik/pages/main/main_page.dart';
import 'package:iplik/util/models/account.dart';
import 'package:iplik/util/utilities.dart';
import 'package:iplik/widgets/custom_button.dart';
import 'package:iplik/widgets/custom_dropdown.dart';
import 'package:iplik/widgets/custom_textfield.dart';
import 'package:iplik/globals.dart' as globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisteringPage extends StatefulWidget {
  const RegisteringPage({super.key});

  @override
  State<RegisteringPage> createState() => _RegisteringPageState();
}

class _RegisteringPageState extends State<RegisteringPage> with RestorationMixin {
  final RestorableDateTime selectedDate = RestorableDateTime(
    DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day)
  );
  final TextEditingController usernameController = TextEditingController();
  late final RestorableRouteFuture _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @override
  String? get restorationId => "register";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(selectedDate, "selected_date");
    registerForRestoration(
      _restorableDatePickerRouteFuture,
      "date_picker_route_future"
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        selectedDate.value = newSelectedDate;
      });
    }
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    DateTime now = DateTime.now();
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: "date_picker_dialog",
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(now.year - 100),
          lastDate: DateTime(now.year - 18, now.month, now.day),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("kayıt ol", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const Text("ipliğe birkaç tık ile katıl", style: TextStyle(fontSize: 15)),
              Divider(height: 20, color: Colors.grey.withOpacity(.5)),
              const SizedBox(height: 5),
              CustomTextField(
                controller: usernameController,
                labelText: "iplikteki hesabının ismi",
                hintText: "örn. emir"
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                onPressed: () => _restorableDatePickerRouteFuture.present(),
                child: Text(
                  "doğum tarihin: ${DateFormat("dd/MM/yyyy").format(selectedDate.value)}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              CustomButton(
                color: Colors.white,
                textColor: Colors.black,
                onTap: () {
                  HapticFeedback.selectionClick();

                  if (usernameController.text.isEmpty) {
                    Utilites.showSnackbar(
                      isSuccess: false,
                      title: "dur bekle",
                      description: "ismini yazmayı unutma"
                    );
                    return;
                  }

                  Utilites.showLoadingDialog(context);

                  Utilites.createAccount(Account(
                    id: FirebaseAuth.instance.currentUser!.uid,
                    username: usernameController.text,
                    dateJoined: DateTime.now(),
                    birthDate: selectedDate.value,
                    lifs: []
                  )).then((_) async {
                    globals.currentAccount = FirebaseAuth.instance.currentUser!;
                    await FirebaseAuth.instance.currentUser!.updateDisplayName(usernameController.text);
                    if (mounted) {
                      Navigator.pop(context);
                      Get.to(() => const MainPage());
                    }
                  });
                },
                text: "devam",
              )
            ],
          ),
        ),
      ),
    );
  }
}