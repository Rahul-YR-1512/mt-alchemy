import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Cart',
      showCart: false,
      body: ListenableBuilder(
        listenable: AppState.instance,
        builder: (context, _) {
          final state = AppState.instance;
          final items = state.cart;
          if (items.isEmpty) {
            return PageBody(
              maxWidth: 560,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: const BoxDecoration(
                      color: AppColors.lavender,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shopping_cart_outlined,
                        size: 40, color: AppColors.deepBlue),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Your cart is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Browse the store to add tools and kits.',
                    style: GoogleFonts.inter(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 18),
                  YellowButton(
                    label: 'Continue Shopping',
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.store),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: PageBody(
              maxWidth: 680,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionTitle(title: 'Your items'),
                  const SizedBox(height: 12),
                  ...items.map((item) => _cartItem(context, item)),
                  const SizedBox(height: 12),
                  _summary(state),
                  const SizedBox(height: 18),
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.store),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Continue Shopping'),
                  ),
                  const SizedBox(height: 10),
                  YellowButton(
                    label: 'Proceed to Checkout',
                    icon: Icons.lock_outline,
                    expand: true,
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.checkout),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _cartItem(BuildContext context, CartItem item) {
    final p = item.product;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CalmCard(
        child: Row(
          children: [
            GradientImage(
              gradient: p.gradient,
              height: 62,
              borderRadius: 14,
              icon: p.type == ProductType.digital
                  ? Icons.cloud_download_outlined
                  : Icons.inventory_2_outlined,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    p.tag,
                    style: GoogleFonts.inter(
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _qtyButton(
                        Icons.remove,
                        () => AppState.instance.decrement(item),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '${item.quantity}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      _qtyButton(
                        Icons.add,
                        () => AppState.instance.increment(item),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'RM${item.lineTotal.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.deepBlue,
                  ),
                ),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () => AppState.instance.removeFromCart(item),
                  child: const Icon(Icons.delete_outline,
                      size: 18, color: AppColors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lavender,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon, size: 16, color: AppColors.deepBlue),
      ),
    );
  }

  Widget _summary(AppState state) {
    return CalmCard(
      child: Column(
        children: [
          _summaryRow('Subtotal', 'RM${state.cartSubtotal.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          _summaryRow('Discount', 'RM0'),
          const SizedBox(height: 10),
          _summaryRow('Shipping', 'RM10'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'RM${state.cartTotal.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            color: AppColors.textMuted,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}