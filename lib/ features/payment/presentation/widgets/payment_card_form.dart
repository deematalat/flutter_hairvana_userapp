import 'package:flutter/material.dart';

class PaymentCardForm extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final bool saveCard;
  final ValueChanged<bool?> onSaveCardChanged;
  final GlobalKey<FormState> formKey;
  const PaymentCardForm({
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
    required this.saveCard,
    required this.onSaveCardChanged,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Card Details', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextFormField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  hintText: '•••• •••• •••• 1234',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  final cleanValue = value.replaceAll(' ', '');
                  if (cleanValue.length < 16) {
                    return 'Card number must be 16 digits';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(cleanValue)) {
                    return 'Card number must contain only numbers';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Auto-format card number with spaces
                  final cleanValue = value.replaceAll(' ', '');
                  if (cleanValue.length <= 16) {
                    final formatted = cleanValue.replaceAllMapped(
                      RegExp(r'.{4}'),
                      (match) => '${match.group(0)} ',
                    ).trim();
                    if (formatted != value) {
                      cardNumberController.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(offset: formatted.length),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: expiryController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YY',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry date';
                        }
                        final cleanValue = value.replaceAll('/', '');
                        if (!RegExp(r'^\d{4}$').hasMatch(cleanValue)) {
                          return 'Use MM/YY format';
                        }
                        final month = int.tryParse(cleanValue.substring(0, 2));
                        final year = int.tryParse(cleanValue.substring(2, 4));
                        if (month == null || month < 1 || month > 12) {
                          return 'Invalid month';
                        }
                        if (year == null || year < 0 || year > 99) {
                          return 'Invalid year';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Auto-format expiry date
                        final cleanValue = value.replaceAll('/', '');
                        if (cleanValue.length <= 4) {
                          String formatted = cleanValue;
                          if (cleanValue.length >= 2) {
                            formatted = '${cleanValue.substring(0, 2)}/${cleanValue.substring(2)}';
                          }
                          if (formatted != value) {
                            expiryController.value = TextEditingValue(
                              text: formatted,
                              selection: TextSelection.collapsed(offset: formatted.length),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        hintText: '•••',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.security),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVV';
                        }
                        if (value.length < 3) {
                          return 'CVV must be 3-4 digits';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'CVV must contain only numbers';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: saveCard,
                    onChanged: onSaveCardChanged,
                  ),
                  const Text('Save card for future payments'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 