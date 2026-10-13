import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class TeamProgressTable extends StatelessWidget {
  final List<EmployeeProgress> employees;

  const TeamProgressTable({super.key, this.employees = SampleData.employees});

  @override
  Widget build(BuildContext context) {
    return CalmCard(
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            Container(
              color: AppColors.lavender,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: const _HeaderRow(),
            ),
            ...List.generate(employees.length, (i) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.divider),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: _EmployeeRow(e: employees[i]),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.lavenderText,
    );
    return Row(
      children: [
        Expanded(flex: 3, child: Text('Employee', style: style)),
        Expanded(flex: 2, child: Text('Department', style: style)),
        Expanded(flex: 3, child: Text('Course', style: style)),
        Expanded(flex: 3, child: Text('Progress', style: style)),
        Expanded(flex: 2, child: Text('Status', style: style)),
      ],
    );
  }
}

class _EmployeeRow extends StatelessWidget {
  final EmployeeProgress e;

  const _EmployeeRow({required this.e});

  @override
  Widget build(BuildContext context) {
    final nameStyle = GoogleFonts.inter(
      fontSize: 12.5,
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    );
    final mutedStyle = GoogleFonts.inter(
      fontSize: 12,
      color: AppColors.textMuted,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(e.name,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: nameStyle),
        ),
        Expanded(
          flex: 2,
          child: Text(e.department,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: mutedStyle),
        ),
        Expanded(
          flex: 3,
          child: Text(e.course,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: mutedStyle),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: e.progress / 100,
                    minHeight: 6,
                    backgroundColor: AppColors.lavender,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.deepBlue),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 34,
                child: Text(
                  '${e.progress.toStringAsFixed(0)}%',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 2, child: _StatusTag(status: e.status)),
      ],
    );
  }
}

class _StatusTag extends StatelessWidget {
  final String status;

  const _StatusTag({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (status) {
      case 'Completed':
        bg = AppColors.greenSoft;
        fg = AppColors.green;
        break;
      case 'In Progress':
        bg = AppColors.lavender;
        fg = AppColors.lavenderText;
        break;
      default:
        bg = const Color(0xFFF0F0F4);
        fg = AppColors.textMuted;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: AppTag(
        label: status,
        background: bg,
        textColor: fg,
      ),
    );
  }
}