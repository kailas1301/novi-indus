import 'package:flutter/material.dart';
import 'package:novi_indus/core/constants/constants.dart';
import 'package:novi_indus/core/widgets/custom_appbar.dart';
import 'package:novi_indus/core/widgets/custom_text.dart';
import 'package:novi_indus/core/widgets/elevated_button.dart';
import 'package:novi_indus/core/widgets/text_form_field.dart';
import 'package:novi_indus/feautures/patient/presentation/home_screen/patient_vie_model.dart';
import 'package:novi_indus/feautures/register/presentation/register_screen.dart';
import 'package:novi_indus/main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).fetchPatients();
    });
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              kSizedBoxH30,
              const CustomAppBar(),
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          textfieldColor: kwhiteColour,
                          hintColor: kGreyColour,
                          prefixIcon: Icons.search,
                          controller: searchController,
                          hintText: "Search for treatments",
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButtonWidget(
                        fontWeight: FontWeight.w500,
                        buttonText: "Search",
                        width: 90,
                        textSize: 12,
                        textColor: kwhiteColour,
                        onPressed: () {
                          // Search button logic
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: "Sort by :",
                      color: kDarkGreyColour,
                      size: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      height: screenHeight * .05,
                      width: screenWidth * .42,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: kGreyColour),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Date",
                            color: kDarkGreyColour,
                            size: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kGreyColour,
              ),
              Expanded(
                child: Consumer<PatientProvider>(
                  builder: (context, patientProvider, child) {
                    if (patientProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (patientProvider.errorMessage != null) {
                      return Center(child: Text(patientProvider.errorMessage!));
                    } else {
                      return ListView.separated(
                        itemCount: patientProvider.patients.length,
                        separatorBuilder: (context, index) => kSizedBoxH20,
                        itemBuilder: (context, index) {
                          final patient = patientProvider.patients[index];
                          String formattedDate = '';
                          if (patient.dateTime != null) {
                            try {
                              DateTime date = DateTime.parse(patient.dateTime!);
                              formattedDate =
                                  DateFormat('dd/MM/yyyy').format(date);
                            } catch (e) {
                              formattedDate = 'Invalid Date';
                            }
                          } else {
                            formattedDate = 'No Date Available';
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: kLightGreyColour,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16, top: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 25,
                                          child: CustomText(
                                            text: '${index + 1}.',
                                            color: kblackColour,
                                            size: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: patient.name,
                                              color: kblackColour,
                                              size: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            kSizedBoxH10,
                                            CustomText(
                                              text:
                                                  'Treatment: ${patient.treatmentName ?? 'No Treatment Name'}',
                                              color: kGreenColour,
                                              size: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            kSizedBoxH10,
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.calendar_today,
                                                      size: 15,
                                                      color: kRedColour,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    CustomText(
                                                      text: formattedDate
                                                              .isNotEmpty
                                                          ? formattedDate
                                                          : 'No Date Available',
                                                      color: kDarkGreyColour,
                                                      size: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ],
                                                ),
                                                kSizedBoxW10,
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.person_2_outlined,
                                                      size: 15,
                                                      color: kRedColour,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    CustomText(
                                                      text: patient.name,
                                                      color: kDarkGreyColour,
                                                      size: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kSizedBoxH10,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: kGreyColour,
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: 'View Booking Details',
                                                  color: kblackColour,
                                                  size: 16,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 16,
                                                  color: kGreenColour,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  kSizedBoxH10,
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 16, bottom: 35),
              child: ElevatedButtonWidget(
                textColor: kwhiteColour,
                textSize: 17,
                width: 380,
                buttonText: "Register Now",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
