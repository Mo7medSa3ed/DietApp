import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileScrean extends StatefulWidget {
  @override
  _EditProfileScreanState createState() => _EditProfileScreanState();
}

class _EditProfileScreanState extends State<EditProfileScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  //bool isVisible = true;
  var nameController = TextEditingController(text: '');
  //var emailController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  var locationController = TextEditingController(text: '');
  var weightController = TextEditingController(text: '');
  var heightController = TextEditingController(text: '');
  var passController = TextEditingController(text: '');
  var confirController = TextEditingController(text: '');
  var image;
  var gender;
  bool isLoading = false;
  var _selectedDate;
  var user;

  Future getImage(source) async {
    await ImagePicker.pickImage(source: source).then((value) async {
      if (value != null) {
        setState(() {
          image = value;
        });
        return;
      }
    }).catchError((e) => print(e));
  }

  @override
  void initState() {
    user = Provider.of<AppProvider>(context, listen: false).user;

    reset();
    super.initState();
  }

  reset() {
    nameController.text = user['name'] ?? '';
    heightController.text = (user['height'] ?? '').toString();
    weightController.text = (user['weight'] ?? '').toString();
    phoneController.text =
        user['mobile'] != null ? user['mobile'].replaceAll("+2", '') : '';
    locationController.text = user['location'] ?? '';
    if (user['birth_date'] != null) {
      _selectedDate = DateTime.parse(user['birth_date']);
    }
    gender =
        user['gender'] != null ? tr(user['gender'].toLowerCase()) : tr('male');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldkey,
          drawer: buildDrawer(context),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // radius: 0.1,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xffe4e6f3),
                  Color(0xfffefefe),
                  Color(0xffe4e6f3),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildAppBarForPages(context, tr('edit') + ' ' + tr('profile'),
                      () => scaffoldkey.currentState.openDrawer(),
                      showProfile: false),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      children: [
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
                                  backgroundImage: image != null
                                      ? FileImage(image)
                                      : NetworkImage(user['photo']),
                                )),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: kwhite,
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: () {
                                      return showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(25),
                                              topLeft: Radius.circular(25),
                                            ),
                                          ),
                                          builder: (ctx) {
                                            return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25),
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(16),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                            iconSize: 40,
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                              await getImage(
                                                                  ImageSource
                                                                      .camera);
                                                            },
                                                            icon: Icon(
                                                              Icons.camera_alt,
                                                              color: kprimary2,
                                                            )),
                                                        buildText2(tr('camera'),
                                                            color: kprimary2)
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                            iconSize: 40,
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                              await getImage(
                                                                  ImageSource
                                                                      .gallery);
                                                            },
                                                            icon: Icon(
                                                              Icons.camera,
                                                              color: kprimary2,
                                                            )),
                                                        buildText2(
                                                            tr('gallery'),
                                                            color: kprimary2)
                                                      ],
                                                    )
                                                  ],
                                                ));
                                          });
                                    },
                                    color: kprimary,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buldinputContainer(
                            onChange: (v) {
                              if (v.length == 0 || v.length == 1)
                                setState(() {});
                            },
                            text: tr('name'),
                            hint: tr('hint_msg',
                                namedArgs: {'attribute': tr('name')}),
                            controller: nameController),
                        // buldinputContainer(
                        //     onChange: (v) {
                        //       if (v.length == 0 || v.length == 1) setState(() {});
                        //     },
                        //     text: "Email",
                        //     hint: 'enter your email ...',
                        //     controller: emailController),
                        buldinputContainer(
                            onChange: (v) {
                              if (v.length == 0 || v.length == 1)
                                setState(() {});
                            },
                            text: tr('phone'),
                            hint: tr('hint_msg',
                                namedArgs: {'attribute': tr('phone')}),
                            controller: phoneController),
                        buldinputContainer(
                            onChange: (v) {
                              if (v.length == 0 || v.length == 1)
                                setState(() {});
                            },
                            text: tr('location'),
                            hint: tr('hint_msg',
                                namedArgs: {'attribute': tr('location')}),
                            isLoading: isLoading,
                            onpressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              final add = await getCurrantaddress();
                              locationController.text = add.addressLine;

                              setState(() {
                                isLoading = false;
                              });
                            },
                            controller: locationController),
                        buldinputContainer(
                            text: tr('birthdate'),
                            widget: InkWell(
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  _selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1970),
                                      lastDate: DateTime.now());
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 16),
                                  child: Text(
                                      _selectedDate != null
                                          ? DateFormat('dd/MM/yyyy')
                                              .format(_selectedDate)
                                              .toString()
                                          : tr('hint_msg', namedArgs: {
                                              'attribute': tr('birthdate')
                                            }),
                                      style: TextStyle(
                                          color: _selectedDate != null
                                              ? kprimary
                                              : ksecondary,
                                          fontWeight: _selectedDate != null
                                              ? FontWeight.w900
                                              : FontWeight.w600,
                                          fontSize:
                                              _selectedDate != null ? 18 : 16)),
                                )),
                            controller: TextEditingController(
                                text: _selectedDate.toString())),
                        buldinputContainer(
                          text: tr('gender'),
                          controller: TextEditingController(
                              text: user['gender'][0].toUpperCase() +
                                  user['gender'].substring(1)),
                          widget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownSearch<String>(
                                searchBoxDecoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                mode: Mode.MENU,
                                dropdownBuilder:
                                    (context, selectedItem, itemAsString) =>
                                        Text(
                                          selectedItem,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18),
                                        ),
                                items: [tr('male'), tr('female')],
                                popupBackgroundColor: kcolor1,
                                maxHeight: 100,
                                hint: tr('hint_msg',
                                    namedArgs: {'attribute': tr('gender')}),
                                onChanged: (g) {
                                  setState(() {
                                    gender = g;
                                  });
                                },
                                selectedItem: gender),
                          ),
                        ),
                        buldinputContainer(
                            onChange: (v) {
                              if (v.length == 0 || v.length == 1)
                                setState(() {});
                            },
                            text: tr('weight'),
                            hint: tr('hint_msg',
                                namedArgs: {'attribute': tr('weight')}),
                            controller: weightController),
                        buldinputContainer(
                            onChange: (v) {
                              if (v.length == 0 || v.length == 1)
                                setState(() {});
                            },
                            text: tr('height'),
                            hint: tr('hint_msg',
                                namedArgs: {'attribute': tr('height')}),
                            controller: heightController),
                        // buldinputContainer(
                        //   text: "Password",
                        //   controller: passController,
                        //   widget: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //     child: TextField(
                        //       controller: passController,
                        //       onChanged: (v) {
                        //         setState(() {});
                        //       },
                        //       obscureText: isVisible,
                        //       cursorColor: kprimary,
                        //       style: TextStyle(
                        //           color: kprimary,
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w900),
                        //       decoration: InputDecoration(
                        //           suffixIcon: IconButton(
                        //               icon: Icon(
                        //                 isVisible
                        //                     ? Icons.visibility
                        //                     : Icons.visibility_off,
                        //                 color: ksecondary,
                        //               ),
                        //               onPressed: () {
                        //                 setState(() {
                        //                   isVisible = !isVisible;
                        //                 });
                        //               }),
                        //           hintStyle: TextStyle(
                        //               color: ksecondary,
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.w700),
                        //           border: InputBorder.none,
                        //           hintText: "enter your password ..."),
                        //     ),
                        //   ),
                        // ),
                        // buldinputContainer(
                        //   text: "Confirm Password",
                        //   controller: confirController,
                        //   widget: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //     child: TextFormField(
                        //       autovalidateMode: AutovalidateMode.onUserInteraction,
                        //       onChanged: (v) {
                        //         if (v.length == 0 || v.length == 1) setState(() {});
                        //       },
                        //       validator: (String v) {
                        //         if (v.trim().isEmpty || v == null) {
                        //           return 'please enter your Confirm password...';
                        //         }
                        //         if (v.trim() != passController.text) {
                        //           return 'confirm password not a same !!';
                        //         }
                        //         return null;
                        //       },
                        //       controller: confirController,
                        //       obscureText: isConfirmVisible,
                        //       cursorColor: kprimary,
                        //       style: TextStyle(
                        //           color: kprimary,
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w900),
                        //       decoration: InputDecoration(
                        //           suffixIcon: IconButton(
                        //               icon: Icon(
                        //                 isConfirmVisible
                        //                     ? Icons.visibility
                        //                     : Icons.visibility_off,
                        //                 color: ksecondary,
                        //               ),
                        //               onPressed: () {
                        //                 setState(() {
                        //                   isConfirmVisible = !isConfirmVisible;
                        //                 });
                        //               }),
                        //           hintStyle: TextStyle(
                        //               color: ksecondary,
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.w700),
                        //           border: InputBorder.none,
                        //           hintText: "enter confirm password ...."),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: buildFillElevatedButton(
                                    text: tr("discard_edits"),
                                    bgcolor: kwhite.withOpacity(0.9),
                                    txtcolor: kprimary,
                                    onpressed: () {
                                      reset();
                                    },
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: buildFillElevatedButton(
                                    text: tr("save"),
                                    onpressed: () async {
                                      await updateProfile();
                                    },
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
                ],
              ),
            ),
          )),
    );
  }

  updateProfile() async {
    Alert.loadingAlert(ctx: context);
    final body = {
      "name": nameController.text.trim(),
      "mobile": "+2" + phoneController.text.trim(),
      "id": user['id'],
      "gender": gender.toLowerCase(),
      "birth_date": _selectedDate.toString(),
      "location": locationController.text.trim(),
      "weight": weightController.text.trim(),
      "height": heightController.text.trim(),
    };
    if (image != null) {
      body.addAll({
        "photo": await dio.MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last)
      });
    }

    final res = await API.updateProfile(body);
    Navigator.of(context).pop();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    final resBody = res.data;
    if ((res.statusCode == 200 || res.statusCode == 201) &&
        resBody['success']) {
      await setValue(key: 'user', value: json.encode(resBody['data']));
      Provider.of<AppProvider>(context, listen: false)
          .initUser(resBody['data']);
      return Alert.sucessAlert(
          ctx: context,
          text: "Profile Updated Successfully",
          title: "Update Profile",
          ontap: () => goToWithRemoveUntill(context, HomeScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "tr('error404')");
    }
  }
}
