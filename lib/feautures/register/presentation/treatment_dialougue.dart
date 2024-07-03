import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:novi_indus/core/constants/constants.dart';
import 'package:novi_indus/core/widgets/custom_text.dart';
import 'package:novi_indus/core/widgets/elevated_button.dart';
import 'package:novi_indus/feautures/register/data/model/treatment_model.dart';
import 'package:novi_indus/feautures/register/presentation/treatments_provider.dart';

class TreatmentDialog extends StatelessWidget {
  const TreatmentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final treatmentProvider =
        Provider.of<TreatmentProvider>(context, listen: false);

    // Fetch treatments
    treatmentProvider.fetchTreatments();

    return AlertDialog(
      backgroundColor: kwhiteColour,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const CustomText(
        text: 'Choose Treatment',
        color: kblackColour,
        size: 18,
        fontWeight: FontWeight.w500,
      ),
      content: Consumer<TreatmentProvider>(
        builder: (context, treatmentProvider, child) {
          // Temporary variables
          final selectedTreatment = treatmentProvider.getSelectedTreatment();
          final maleCount = treatmentProvider.getMaleCount();
          final femaleCount = treatmentProvider.getFemaleCount();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<Treatment>(
                  value: selectedTreatment,
                  items: treatmentProvider.getTreatments().map((treatment) {
                    return DropdownMenuItem<Treatment>(
                      value: treatment,
                      child: Text(treatment.name),
                    );
                  }).toList(),
                  onChanged: (treatment) {
                    if (treatment != null) {
                      treatmentProvider.selectTreatment(treatment);
                    }
                  },
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kGreyColour,
                    ),
                    hintText: 'Choose preferred treatment',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: kGreyColour),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                ),
                kSizedBoxH20,
                const CustomText(
                  text: 'Add Patients',
                  color: kblackColour,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                kSizedBoxH10,
                Column(
                  children: [
                    _buildCountControl(
                      label: 'Male',
                      count: maleCount,
                      onIncrease: () => treatmentProvider.increaseMaleCount(),
                      onDecrease: () => treatmentProvider.decreaseMaleCount(),
                    ),
                    kSizedBoxH10,
                    _buildCountControl(
                      label: 'Female',
                      count: femaleCount,
                      onIncrease: () => treatmentProvider.increaseFemaleCount(),
                      onDecrease: () => treatmentProvider.decreaseFemaleCount(),
                    ),
                  ],
                ),
                kSizedBoxH20,
              ],
            ),
          );
        },
      ),
      actions: [
        ElevatedButtonWidget(
          onPressed: () {
            // Handle save logic here
            Navigator.of(context).pop();
          },
          buttonText: 'Save',
          width: double.infinity,
          textSize: 16,
          textColor: kwhiteColour,
        ),
      ],
    );
  }

  Widget _buildCountControl({
    required String label,
    required int count,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: label,
                  color: kblackColour,
                  size: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        kSizedBoxW20,
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kGreenColour,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 40,
              width: 40,
              child: IconButton(
                icon: const Icon(Icons.remove, color: kwhiteColour),
                onPressed: onDecrease,
              ),
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
                  count > 0 ? count.toString() : '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            kSizedBoxW10,
            Container(
              decoration: BoxDecoration(
                color: kGreenColour,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 40,
              width: 40,
              child: IconButton(
                icon: const Icon(Icons.add, color: kwhiteColour),
                onPressed: onIncrease,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
