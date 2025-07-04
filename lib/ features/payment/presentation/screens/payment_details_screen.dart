import 'package:flutter/material.dart';
import '../../../booking/domain/entities/booking.dart';
import '../../../booking/domain/repositories/booking_repository.dart';
import '../widgets/payment_failure.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final double total;
  final DateTime date;
  final TimeOfDay time;
  final String stylist;
  final String salon;
  final String style;
  const PaymentDetailsScreen({Key? key, required this.total, required this.date, required this.time, required this.stylist, required this.salon, required this.style}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  int? selectedType; // 0: Card, 1: Crypto
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);
    try {
      // Simulate payment processing delay
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isProcessing = false);
      _showBookingConfirmation();
    } catch (e) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }

  void _showBookingConfirmation() {
    BookingRepository.bookings.add(Booking(
      salon: widget.salon,
      stylist: widget.stylist,
      style: widget.style,
      date: widget.date,
      time: widget.time,
    ));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(16),
                child: const Icon(Icons.check, color: Colors.green, size: 48),
              ),
              const SizedBox(height: 18),
              const Text('Booking Confirmed!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(height: 12),
              Text(
                'Your appointment with ${widget.stylist} at ${widget.salon} for ${widget.style} has been scheduled.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFf3e8ff),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "You'll receive a confirmation email shortly with all the details.",
                  style: TextStyle(color: Color(0xFFa78bfa)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFa78bfa),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Payment Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('Payment Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 24),
            Text('Date: 	${widget.date.month}/${widget.date.day}/${widget.date.year}'),
            Text('Time: 	${widget.time.format(context)}'),
            const SizedBox(height: 24),
            const Text('Choose Payment Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedType = 0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: selectedType == 0 ? const Color(0xFFede9fe) : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: const [
                            Icon(Icons.credit_card, color: Color(0xFF60a5fa), size: 36),
                            SizedBox(height: 8),
                            Text('Card', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedType = 1),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: selectedType == 1 ? const Color(0xFFede9fe) : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: const [
                            Icon(Icons.language, color: Color(0xFF60a5fa), size: 36),
                            SizedBox(height: 8),
                            Text('Crypto', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (selectedType == 0) ...[
              Form(
                key: _formKey,
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
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Card Number',
                            hintText: '•••• •••• •••• 1234',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Enter card number';
                            if (value.replaceAll(' ', '').length < 16) return 'Card number too short';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _expiryController,
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
                                  labelText: 'Expiry Date',
                                  hintText: 'MM / YY',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Enter expiry date';
                                  final exp = RegExp(r'^(0[1-9]|1[0-2])\s*/\s*[0-9]{2}?$');
                                  if (!exp.hasMatch(value)) return 'Invalid format';
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _cvvController,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'CVV',
                                  hintText: '•••',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Enter CVV';
                                  if (value.length < 3) return 'CVV too short';
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
                              onChanged: (val) => setState(() => saveCard = val ?? false),
                            ),
                            const Text('Save card for future payments'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else if (selectedType == 1) ...[
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Connect Crypto Wallet', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      _CryptoWalletButton(label: 'MetaMask'),
                      const SizedBox(height: 8),
                      _CryptoWalletButton(label: 'Coinbase Wallet'),
                      const SizedBox(height: 8),
                      _CryptoWalletButton(label: 'WalletConnect'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFf3e8ff),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Supported: Bitcoin, Ethereum, USDC, USDT',
                          style: TextStyle(color: Color(0xFFa78bfa)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedType != null && !_isProcessing
                    ? () async {
                  if (selectedType == 0) {
                    if (_formKey.currentState?.validate() ?? false) {
                      await _processPayment();
                    }
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => PaymentFailureScreen()),
                    );
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  backgroundColor: selectedType != null ? const Color(0xFFa78bfa) : Colors.grey[400],
                  foregroundColor: Colors.white,
                ),
                child: _isProcessing
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Confirm Payment (24${widget.total.toStringAsFixed(2)})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CryptoWalletButton extends StatelessWidget {
  final String label;
  const _CryptoWalletButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.link, color: Color(0xFFa78bfa)),
      label: Text(label, style: const TextStyle(color: Color(0xFFa78bfa))),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFa78bfa)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
















