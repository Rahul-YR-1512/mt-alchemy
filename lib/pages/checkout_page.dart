import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _postcode = TextEditingController();
  String? _stateName;
  String _payment = 'FPX Online Banking';

  static const _states = [
    'Kuala Lumpur',
    'Selangor',
    'Penang',
    'Johor',
    'Perak',
    'Sabah',
    'Sarawak',
  ];
  static const _payments = [
    ('FPX Online Banking', Icons.account_balance_outlined),
    ('Credit/Debit Card', Icons.credit_card),
    ('E-wallet', Icons.account_balance_wallet_outlined),
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _address.dispose();
    _city.dispose();
    _postcode.dispose();
    super.dispose();
  }

  double get _total {
    final t = AppState.instance.cartTotal;
    return t == 0 ? 118 : t;
  }

  void _pay() {
    if (!_formKey.currentState!.validate()) return;
    AppState.instance.completeOrder();
    Navigator.pushNamed(context, Routes.orderConfirmation);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Checkout',
      showCart: false,
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 600,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _section(
                  title: 'Customer Information',
                  icon: Icons.person_outline,
                  children: [
                    _field(_name, 'Full Name', Icons.person_outline),
                    _field(_email, 'Email', Icons.mail_outline,
                        keyboard: TextInputType.emailAddress,
                        validator: _emailValidator),
                    _field(_phone, 'Phone', Icons.phone_outlined,
                        keyboard: TextInputType.phone),
                  ],
                ),
                const SizedBox(height: 16),
                _section(
                  title: 'Shipping Address',
                  icon: Icons.location_on_outlined,
                  children: [
                    _field(_address, 'Address', Icons.home_outlined,
                        lines: 2),
                    _field(_city, 'City', Icons.location_city_outlined),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DropdownButtonFormField<String>(
                        initialValue: _stateName,
                        isExpanded: true,
                        validator: (v) =>
                            v == null ? 'State is required' : null,
                        decoration: const InputDecoration(labelText: 'State'),
                        items: _states
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _stateName = v),
                      ),
                    ),
                    _field(_postcode, 'Postcode', Icons.pin_outlined,
                        keyboard: TextInputType.number,
                        validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Postcode is required';
                      }
                      if (!RegExp(r'^\d{5}$').hasMatch(v.trim())) {
                        return 'Enter a 5-digit postcode';
                      }
                      return null;
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                _section(
                  title: 'Payment',
                  icon: Icons.payments_outlined,
                  children: [
                    RadioGroup<String>(
                      groupValue: _payment,
                      onChanged: (v) =>
                          setState(() => _payment = v ?? _payment),
                      child: Column(
                        children: _payments
                            .map(
                              (p) => RadioListTile<String>(
                                value: p.$1,
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppColors.deepBlue,
                                title: Row(
                                  children: [
                                    Icon(p.$2,
                                        size: 20,
                                        color: AppColors.deepBlue),
                                    const SizedBox(width: 10),
                                    Text(
                                      p.$1,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                YellowButton(
                  label: 'Pay RM${_total.toStringAsFixed(0)}',
                  icon: Icons.lock_outline,
                  expand: true,
                  onPressed: _pay,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final re = RegExp(r'^[\w.\-]+@[\w\-]+\.[\w.\-]+$');
    if (!re.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return CalmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lavender,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: AppColors.deepBlue),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboard,
    String? Function(String?)? validator,
    int lines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: lines,
        validator: validator ??
            (v) => (v == null || v.trim().isEmpty)
                ? '$label is required'
                : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
        ),
      ),
    );
  }
}