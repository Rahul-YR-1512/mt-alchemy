import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  String? _department;

  final List<EmployeeProgress> _employees = List.of(SampleData.employees);

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _employees.insert(
        0,
        EmployeeProgress(
          name: _name.text.trim(),
          department: _department!,
          course: 'Not assigned',
          progress: 0,
          status: 'Invited',
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invitation sent'),
        backgroundColor: AppColors.deepBlue,
      ),
    );
    _name.clear();
    _email.clear();
    setState(() => _department = null);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Add Employee',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 640,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalmCard(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Invite a colleague',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _name,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Employee Name is required'
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Employee Name',
                          prefixIcon: Icon(Icons.person_outline, size: 20),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Work Email is required';
                          }
                          final re =
                              RegExp(r'^[\w.\-]+@[\w\-]+\.[\w.\-]+$');
                          if (!re.hasMatch(v.trim())) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Work Email',
                          prefixIcon: Icon(Icons.mail_outline, size: 20),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _department,
                        isExpanded: true,
                        validator: (v) =>
                            v == null ? 'Department is required' : null,
                        decoration: const InputDecoration(
                          labelText: 'Department',
                        ),
                        items: SampleData.departments
                            .map((d) => DropdownMenuItem(
                                  value: d,
                                  child: Text(d),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => _department = v),
                      ),
                      const SizedBox(height: 18),
                      YellowButton(
                        label: 'Add Employee',
                        icon: Icons.send_outlined,
                        expand: true,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(
                title: 'Employees',
                subtitle: 'People connected to your organization.',
              ),
              const SizedBox(height: 12),
              CalmCard(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: _employees.map((e) {
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.lavender,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _initials(e.name),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ),
                      title: Text(
                        e.name,
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      subtitle: Text(
                        '${e.department} · ${e.course}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                      trailing: AppTag(label: e.status),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return name.substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}