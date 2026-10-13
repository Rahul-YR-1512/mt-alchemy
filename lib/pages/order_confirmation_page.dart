import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    List<CartItem> items = state.lastOrderItems;
    if (items.isEmpty) {
      items = [
        CartItem(SampleData.products[0], 1),
        CartItem(SampleData.products[2], 1),
      ];
    }
    final total = state.lastOrderTotal == 0 ? 118 : state.lastOrderTotal;

    return AppScaffold(
      title: 'Order Confirmation',
      showCart: false,
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 560,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: const BoxDecoration(
                    color: AppColors.greenSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_rounded,
                      size: 52, color: AppColors.green),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Thank you for your order.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Order #MA1003 · Payment Successful',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 22),
              CalmCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            GradientImage(
                              gradient: item.product.gradient,
                              height: 46,
                              borderRadius: 12,
                              icon: Icons.shopping_bag_outlined,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.product.name,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            Text(
                              '×${item.quantity}',
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'RM${item.lineTotal.toStringAsFixed(0)}',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 6),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount paid',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          'RM${total.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              YellowButton(
                label: 'My Digital Products',
                icon: Icons.download_outlined,
                expand: true,
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.myDigitalProducts),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order #MA1003 is being prepared.'),
                    backgroundColor: AppColors.deepBlue,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Track Order'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.home,
                  (route) => false,
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}