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
import 'package:novi_indus/feautures/register/presentation/treatment_dialougue.dart';
import 'package:provider/provider.dart';
import 'package:novi_indus/feautures/register/presentation/location_provider.dart';
import 'package:novi_indus/feautures/register/presentation/branch_provider.dart';
import 'package:novi_indus/feautures/register/presentation/treatments_provider.dart';
import 'package:intl/intl.dart';

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
      Provider.of<TreatmentProvider>(context, listen: false).fetchTreatments();
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
                          child: Text(branchProvider.getErrorMessage()!),
                        );
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
                            icon: const Icon(Icons.arrow_drop_down),
                            value: branchProvider.getSelectedBranch(),
                            items: [
                              DropdownMenuItem<Branch>(
                                value: null,
                                child: Text(
                                  "Select a branch",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kGreyColour,
                                  ),
                                ),
                              ),
                              ...branchProvider.getBranches().map(
                                    (branch) => DropdownMenuItem<Branch>(
                                      value: branch,
                                      child: Text(
                                        branch.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: kDarkGreyColour,
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
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
                            hint: Text(
                              "Select a branch",
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kGreyColour,
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
                  Consumer<TreatmentProvider>(
                    builder: (context, treatmentProvider, child) {
                      final selectedTreatments =
                          treatmentProvider.getSelectedTreatments();
                      final maleCount = treatmentProvider.getMaleCount();
                      final femaleCount = treatmentProvider.getFemaleCount();

                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedTreatments.length,
                            itemBuilder: (context, index) {
                              final treatment = selectedTreatments[index];
                              return ListTile(
                                title: Text(treatment['name']),
                                subtitle: Text(
                                    'ID: ${treatment['id']} - Price: \$${treatment['price']}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () {
                                    treatmentProvider
                                        .removeTreatment(treatment['id']);
                                  },
                                ),
                              );
                            },
                          ),
                          kSizedBoxH10,
                          // Show Male and Female Count
                          Row(
                            children: [
                              Row(
                                children: [
                                  kSizedBoxW30,
                                  CustomText(
                                    fontWeight: FontWeight.w500,
                                    text: 'Male',
                                    color: kGreenColour,
                                    size: 16,
                                  ),
                                  kSizedBoxW10,
                                  Container(
                                    width: 45,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        maleCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 16, color: kGreenColour),
                                      ),
                                    ),
                                  ),
                                  kSizedBoxW30,
                                ],
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    fontWeight: FontWeight.w500,
                                    text: 'Female',
                                    color: kGreenColour,
                                    size: 16,
                                  ),
                                  kSizedBoxW10,
                                  Container(
                                    width: 45,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        femaleCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 16, color: kGreenColour),
                                      ),
                                    ),
                                  ),
                                  kSizedBoxW30,
                                  kSizedBoxW20,
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        size: 25,
                                        color: kGreenColour,
                                      ))
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  kSizedBoxH20,
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
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
                      onPressed: () {
                        showTreatmentDialog(context);
                      },
                      buttonText: "+ Add Treatments",
                      width: 380,
                      textSize: 16,
                      textColor: kblackColour,
                    ),
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Total Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    keyboardType: TextInputType.number,
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: totalAmountController,
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Discount Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
                    textfieldColor: kwhiteColour,
                    hintColor: kGreyColour,
                    controller: advanceAmountController,
                  ),
                  kSizedBoxH20,
                  const CustomText(
                      text: "Balance Amount", color: kblackColour, size: 14),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    keyboardType: TextInputType.number,
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
                                      ? DateFormat('dd/MM/yyyy').format(
                                          dateProvider
                                              .getSelectedDate()!) // Format Date
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
                    text: "Treatment Time",
                    color: kblackColour,
                    size: 14,
                  ),
                  kSizedBoxH10,
                  Consumer<TimeProvider>(
                    builder: (context, timeProvider, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 65,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: kGreyColour,
                                    width: 1), // Set the border color and width
                                borderRadius: BorderRadius.circular(
                                    10), // Optional: Rounded corners
                              ),
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
                          ),
                          kSizedBoxW10,
                          Expanded(
                            child: Container(
                              height: 65,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: kGreyColour,
                                    width: 1), // Set the border color and width
                                borderRadius: BorderRadius.circular(
                                    10), // Optional: Rounded corners
                              ),
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

void showTreatmentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const TreatmentDialog();
    },
  );
}
