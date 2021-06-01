import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:intl/intl.dart';

class EditProfileScrean extends StatefulWidget {
  @override
  _EditProfileScreanState createState() => _EditProfileScreanState();
}

class _EditProfileScreanState extends State<EditProfileScrean> {
  bool isVisible = true;
  bool isConfirmVisible = true;
  List gengerList = ["Male", "Female"];
  var _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildAppBarForPages(context, "Edit Profile", showProfile: false),
              Stack(
                children: [
                  Container(
                      width: 160,
                      height: 160,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ksecondary,
                              blurRadius: 15,
                              spreadRadius: 2)
                        ],
                        color: kwhite,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: ksecondary,
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg"),
                      )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: kwhite,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {},
                          color: kprimary,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              buldinputContainer(
                  text: "Name",
                  hint: 'Enter client name ...',
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                  text: "Email",
                  hint: 'Enter your email ...',
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                  text: "Phone Number",
                  widget: "phone",
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                  text: "Confirmation Code",
                  hint: 'Enter confirmation code ...',
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                  hint: "Enter your location ...",
                  text: "Location",
                  onpressed: () async {
                    await getCurrantLocation(context);
                  },
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                  text: "Birth date",
                  widget: InkWell(
                      onTap: () async {
                        _selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now());
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16),
                        child: Text(
                            _selectedDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate)
                                    .toString()
                                : 'select your birthdate',
                            style: TextStyle(
                                color: _selectedDate != null
                                    ? kprimary
                                    : ksecondary,
                                fontWeight: _selectedDate != null
                                    ? FontWeight.w900
                                    : FontWeight.w600,
                                fontSize: _selectedDate != null ? 20 : 18)),
                      )),
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                text: "Gender",
                controller: TextEditingController(text: ''),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownSearch<String>(
                      searchBoxDecoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      mode: Mode.MENU,
                      dropdownBuilder: (context, selectedItem, itemAsString) =>
                          Text(
                            selectedItem,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20),
                          ),
                      items: ['Male', 'Female'],
                      popupBackgroundColor: kcolor1,
                      maxHeight: 110,
                      hint: "Choose your gender ...",
                      onChanged: print,
                      selectedItem: "Male"),
                ),
              ),
              buldinputContainer(
                  text: "Weight",
                  hint: 'Enter your weight ...',
                  controller: TextEditingController(text: '')),
              buldinputContainer(
                text: "Password",
                controller: TextEditingController(text: ''),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    obscureText: isVisible,
                    cursorColor: kprimary,
                    style: TextStyle(
                        color: kprimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ksecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            }),
                        hintStyle: TextStyle(
                            color: ksecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        border: InputBorder.none,
                        hintText: "enter your password ..."),
                  ),
                ),
              ),
              buldinputContainer(
                text: "Confirm Password",
                controller: TextEditingController(text: ''),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    obscureText: isConfirmVisible,
                    cursorColor: kprimary,
                    style: TextStyle(
                        color: kprimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              isConfirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ksecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmVisible = !isConfirmVisible;
                              });
                            }),
                        hintStyle: TextStyle(
                            color: ksecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        border: InputBorder.none,
                        hintText: "enter confirm password ...."),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: buildFillElevatedButton(
                          text: "Discard Edits",
                          bgcolor: kwhite.withOpacity(0.9),
                          txtcolor: kprimary,
                          onpressed: () {},
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: buildFillElevatedButton(
                          text: "Save",
                          onpressed: () {},
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
