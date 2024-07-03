import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novi_indus/core/constants/constants.dart';
import 'package:novi_indus/core/widgets/custom_appbar.dart';
import 'package:novi_indus/core/widgets/custom_text.dart';
import 'package:novi_indus/core/widgets/text_form_field.dart';
import 'package:novi_indus/core/widgets/elevated_button.dart';
import 'package:novi_indus/feautures/register/data/model/branch_model.dart';
import 'package:novi_indus/feautures/register/presentation/date_provider.dart';
import 'package:novi_indus/feautures/register/presentation/payment_provider.dart';
import 'package:novi_indus/feautures/register/presentation/time_provider.dart';
import 'package:provider/provider.dart';
import 'package:novi_indus/feautures/register/presentation/location_provider.dart';
import 'package:novi_indus/feautures/register/presentation/branch_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController whatsappNoController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController totalAmountController = TextEditingController();
    final TextEditingController discountAmountController =
        TextEditingController();
    final TextEditingController advanceAmountController =
        TextEditingController();
    final TextEditingController balanceAmountController =
        TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BranchProvider>(context, listen: false).fetchBranches();
    });
    return Scaffold(
      backgroundColor: kwhiteColour,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kSizedBoxH30,
          const CustomAppBar(),
          kSizedBoxH20,
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: CustomText(
              text: "Register",
              color: kDarkGreyColour,
              size: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          kSizedBoxH10,
          const Divider(
            color: kGreyColour,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomText(text: "Name", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: nameController,
                    hintText: "Enter your full name",
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Whatsapp Number", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    keyboardType: TextInputType.number,
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: whatsappNoController,
                    hintText: "Enter your Whatsapp number",
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Address", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: addressController,
                    hintText: "Enter your full address",
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Location", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  Consumer<LocationProvider>(
                    builder: (context, locationProvider, child) {
                      return Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: kwhiteColour,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: kGreyColour),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 237, 237, 237)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: locationProvider.getSelectedDistrict(),
                          items: locationProvider
                              .getDistricts()
                              .map((district) => DropdownMenuItem<String>(
                                    value: district,
                                    child: Text(district),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            locationProvider.selectDistrict(value);
                          },
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kGreyColour,
                            ),
                            filled: true,
                            fillColor: kwhiteColour,
                            hintText: "Choose your location",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Branch", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  Consumer<BranchProvider>(
                    builder: (context, branchProvider, child) {
                      if (branchProvider.getIsLoading()) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (branchProvider.getErrorMessage() != null) {
                        return Center(
                            child: Text(branchProvider.getErrorMessage()!));
                      } else {
                        return Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: kwhiteColour,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: kGreyColour),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 237, 237, 237)
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<Branch>(
                            icon: Icon(Icons.arrow_downward),
                            value: branchProvider.getSelectedBranch(),
                            items: branchProvider
                                .getBranches()
                                .map((branch) => DropdownMenuItem<Branch>(
                                      value: branch,
                                      child: Text(
                                        branch.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: kDarkGreyColour,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              branchProvider.selectBranch(value);
                            },
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kGreyColour,
                              ),
                              filled: true,
                              fillColor: kwhiteColour,
                              hintText: "Choose your branch",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Treatments", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kLightGreyColour,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButtonWidget(
                        fontWeight: FontWeight.w500,
                        buttonColor: kGreenLightColour,
                        onPressed: () {},
                        buttonText: "+ Add Treatments",
                        width: 380,
                        textSize: 16,
                        textColor: kblackColour),
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Total Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: totalAmountController,
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Discount Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: discountAmountController,
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Payment Option", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  Consumer<PaymentProvider>(
                    builder: (context, paymentProvider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            paymentProvider.getPaymentOptions().map((option) {
                          return Expanded(
                            child: RadioListTile<PaymentOption>(
                              value: option['value'] as PaymentOption,
                              groupValue: paymentProvider.getSelectedOption(),
                              title: CustomText(
                                text: option['label'] as String,
                                color: kblackColour,
                                size: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              onChanged: (value) {
                                paymentProvider.selectOption(value!);
                              },
                              activeColor: Colors.green, // Selected color
                              contentPadding: EdgeInsets.zero,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Advance Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: addressController,
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Balance Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: balanceAmountController,
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Treatment Date", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  Consumer<DateProvider>(
                    builder: (context, dateProvider, child) {
                      return GestureDetector(
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: dateProvider.getSelectedDate() ??
                                DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (selectedDate != null &&
                              selectedDate != dateProvider.getSelectedDate()) {
                            dateProvider.selectDate(selectedDate);
                          }
                        },
                        child: Container(
                          height: 65,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          decoration: BoxDecoration(
                            color: kwhiteColour,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: kGreyColour),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 237, 237, 237)
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  dateProvider.getSelectedDate() != null
                                      ? dateProvider
                                          .getSelectedDate()!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0] // Format Date
                                      : '', // Placeholder Text
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkGreyColour,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: kGreenColour,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Treatment Time", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  Consumer<TimeProvider>(
                    builder: (context, timeProvider, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: timeProvider.getSelectedHour(),
                              items: List.generate(24, (index) => index)
                                  .map((hour) {
                                return DropdownMenuItem<int>(
                                  value: hour,
                                  child: Text(hour.toString()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  timeProvider.selectHour(value);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Hours",
                                hintStyle: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kGreyColour,
                                ),
                                filled: true,
                                fillColor: kwhiteColour,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          kSizedBoxW10,
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: timeProvider.getSelectedMinute(),
                              items: List.generate(60, (index) => index)
                                  .map((minute) {
                                return DropdownMenuItem<int>(
                                  value: minute,
                                  child:
                                      Text(minute.toString().padLeft(2, '0')),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  timeProvider.selectMinute(value);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Minutes",
                                hintStyle: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kGreyColour,
                                ),
                                filled: true,
                                fillColor: kwhiteColour,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  kSizedBoxH20,
                  kSizedBoxH30,
                  Center(
                    child: ElevatedButtonWidget(
                      textColor: kwhiteColour,
                      textSize: 18,
                      fontWeight: FontWeight.w500,
                      width: double.infinity,
                      onPressed: () {
                        // Handle the form submission
                      },
                      buttonText: "Save",
                    ),
                  ),
                  kSizedBoxH30,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
