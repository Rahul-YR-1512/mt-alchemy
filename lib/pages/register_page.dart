import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class RegisterPage extends StatefulWidget {
  final bool startAsEmployer;

  const RegisterPage({super.key, this.startAsEmployer = false});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEmployer = false;
  bool _agree = false;
  bool _obscure = true;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _orgName = TextEditingController();
  final _regNo = TextEditingController();
  final _contactPerson = TextEditingController();
  final _corpEmail = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  String? _country;
  String? _industry;
  String? _teamSize;
  final Set<String> _areas = {};

  @override
  void initState() {
    super.initState();
    _isEmployer = widget.startAsEmployer;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _orgName.dispose();
    _regNo.dispose();
    _contactPerson.dispose();
    _corpEmail.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _required(String? v, {String label = 'This field'}) {
    if (v == null || v.trim().isEmpty) return '$label is required';
    return null;
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final re = RegExp(r'^[\w.\-]+@[\w\-]+\.[\w.\-]+$');
    if (!re.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  void _submit() {
    final valid = _formKey.currentState!.validate();
    if (_isEmployer) {
      // employer has no separate agree gate
    }
    if (!valid) return;
    if (!_isEmployer && !_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms to continue.'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration success'),
        backgroundColor: AppColors.deepBlue,
      ),
    );
    Navigator.pushNamed(
      context,
      _isEmployer ? Routes.employerDashboard : Routes.upskilling,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Register',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 560,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _toggle(),
              const SizedBox(height: 16),
              CalmCard(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isEmployer
                            ? 'Create your employer account'
                            : 'Create your individual account',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_isEmployer)
                        ..._employerFields()
                      else
                        ..._individualFields(),
                      const SizedBox(height: 18),
                      YellowButton(
                        label: 'Create Account',
                        expand: true,
                        onPressed: _submit,
                      ),
                      if (!_isEmployer) ...[
                        const SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggle() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.lavender,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _toggleOption('Individual', !_isEmployer,
              () => setState(() => _isEmployer = false)),
          _toggleOption('Employer', _isEmployer,
              () => setState(() => _isEmployer = true)),
        ],
      ),
    );
  }

  Widget _toggleOption(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.deepBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: selected ? Colors.white : AppColors.deepBlue,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _individualFields() {
    return [
      _field(_name, 'Full Name', Icons.person_outline),
      _field(_email, 'Email', Icons.mail_outline,
          validator: _emailValidator,
          keyboard: TextInputType.emailAddress),
      _field(_phone, 'Phone', Icons.phone_outlined,
          keyboard: TextInputType.phone),
      _dropdown(
        label: 'Country',
        value: _country,
        items: SampleData.countries,
        onChanged: (v) => setState(() => _country = v),
      ),
      const SizedBox(height: 6),
      Text(
        'Learning areas',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: AppColors.textMuted,
        ),
      ),
      const SizedBox(height: 8),
      FormField<Set<String>>(
        validator: (_) =>
            _areas.isEmpty ? 'Select at least one learning area' : null,
        builder: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SampleData.learningAreas.map((a) {
                final selected = _areas.contains(a);
                return FilterChip(
                  label: Text(a),
                  selected: selected,
                  showCheckmark: false,
                  labelStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.deepBlue,
                  ),
                  backgroundColor: AppColors.lavender,
                  selectedColor: AppColors.deepBlue,
                  shape: const StadiumBorder(),
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        _areas.add(a);
                      } else {
                        _areas.remove(a);
                      }
                    });
                    state.didChange(_areas);
                  },
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.errorText!,
                  style: GoogleFonts.inter(
                    color: AppColors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _passwordField(_password, 'Password'),
      _passwordField(_confirm, 'Confirm Password', isConfirm: true),
      const SizedBox(height: 4),
      CheckboxListTile(
        value: _agree,
        onChanged: (v) => setState(() => _agree = v ?? false),
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          'I agree to the Terms',
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textDark),
        ),
      ),
    ];
  }

  List<Widget> _employerFields() {
    return [
      _field(_orgName, 'Organization Name', Icons.business_outlined),
      _field(_regNo, 'Registration No.', Icons.badge_outlined),
      _field(_contactPerson, 'Contact Person', Icons.person_outline),
      _field(_corpEmail, 'Corporate Email', Icons.mail_outline,
          validator: _emailValidator,
          keyboard: TextInputType.emailAddress),
      _field(_phone, 'Phone', Icons.phone_outlined,
          keyboard: TextInputType.phone),
      _dropdown(
        label: 'Industry',
        value: _industry,
        items: SampleData.industries,
        onChanged: (v) => setState(() => _industry = v),
      ),
      _dropdown(
        label: 'Number of Employees',
        value: _teamSize,
        items: SampleData.teamSizes,
        onChanged: (v) => setState(() => _teamSize = v),
      ),
      _passwordField(_password, 'Password'),
    ];
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    String? Function(String?)? validator,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator ?? (v) => _required(v, label: label),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
        ),
      ),
    );
  }

  Widget _passwordField(
    TextEditingController controller,
    String label, {
    bool isConfirm = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: _obscure,
        validator: (v) {
          if (v == null || v.isEmpty) return '$label is required';
          if (v.length < 6) return 'Minimum 6 characters';
          if (isConfirm && v != _password.text) return 'Passwords do not match';
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock_outline, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 20,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        validator: (v) => v == null ? '$label is required' : null,
        decoration: InputDecoration(labelText: label),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}