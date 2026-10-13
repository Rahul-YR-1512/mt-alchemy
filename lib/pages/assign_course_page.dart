import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class AssignCoursePage extends StatefulWidget {
  const AssignCoursePage({super.key});

  @override
  State<AssignCoursePage> createState() => _AssignCoursePageState();
}

class _AssignCoursePageState extends State<AssignCoursePage> {
  final _formKey = GlobalKey<FormState>();
  String? _course;
  final Set<String> _depts = {};
  DateTime? _deadline;
  bool _picked = false;

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.deepBlue,
            primary: AppColors.deepBlue,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _deadline = picked;
        _picked = true;
      });
    }
  }

  String _fmt(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          'Course assigned',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          '$_course assigned to ${_depts.join(', ')}. Deadline: ${_deadline != null ? _fmt(_deadline!) : '—'}',
          style: GoogleFonts.inter(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pushNamed(context, Routes.reports);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellow,
              foregroundColor: AppColors.deepBlue,
            ),
            child: const Text('View Reports'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Assign Course',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 640,
          child: CalmCard(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Set your team up for growth',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _course,
                    isExpanded: true,
                    validator: (v) =>
                        v == null ? 'Please choose a course' : null,
                    decoration: const InputDecoration(
                      labelText: 'Course',
                      prefixIcon: Icon(Icons.menu_book_outlined, size: 20),
                    ),
                    items: SampleData.courses
                        .map((c) => DropdownMenuItem(
                              value: c.title,
                              child: Text(
                                c.title,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _course = v),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Departments',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormField<Set<String>>(
                    validator: (_) => _depts.isEmpty
                        ? 'Select at least one department'
                        : null,
                    builder: (state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.lavender,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: SampleData.departments.map((d) {
                              final selected = _depts.contains(d);
                              return CheckboxListTile(
                                value: selected,
                                onChanged: (v) {
                                  setState(() {
                                    if (v ?? false) {
                                      _depts.add(d);
                                    } else {
                                      _depts.remove(d);
                                    }
                                  });
                                  state.didChange(_depts);
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: AppColors.deepBlue,
                                contentPadding: const EdgeInsets.only(
                                    left: 4, right: 12),
                                title: Text(
                                  d,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
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
                  const SizedBox(height: 18),
                  Text(
                    'Deadline',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormField<DateTime>(
                    validator: (_) =>
                        _deadline == null ? 'Deadline is required' : null,
                    builder: (state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _pickDeadline,
                          borderRadius: BorderRadius.circular(14),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Deadline date',
                              errorText: state.errorText,
                              suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18),
                            ),
                            isEmpty: !_picked,
                            child: Text(
                              _picked
                                  ? _fmt(_deadline!)
                                  : 'Choose a date',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: _picked
                                    ? AppColors.textDark
                                    : AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  YellowButton(
                    label: 'Assign Course',
                    icon: Icons.assignment_turned_in_outlined,
                    expand: true,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}