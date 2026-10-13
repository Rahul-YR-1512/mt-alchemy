import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Product Detail',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 640,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GradientImage(
                gradient: product.gradient,
                imagePath: product.imagePath,
                height: 230,
                borderRadius: 28,
                icon: product.type == ProductType.digital
                    ? Icons.cloud_download_outlined
                    : Icons.inventory_2_outlined,
                overlay: Align(
                  alignment: Alignment.topLeft,
                  child: AppTag(
                    label: product.typeLabel,
                    background: Colors.white.withValues(alpha: 0.9),
                    textColor: AppColors.deepBlue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.tag.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: AppColors.lavenderText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                product.name,
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'RM${product.price.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  height: 1.55,
                  color: AppColors.textMuted,
                ),
              ),
              if (product.type == ProductType.digital) ...[
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lavender,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.bolt_outlined,
                          color: AppColors.deepBlue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Instant access: after payment this file appears in My Digital Products.',
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            height: 1.45,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 22),
              YellowButton(
                label: 'Add to Cart',
                icon: Icons.add_shopping_cart,
                expand: true,
                onPressed: () {
                  AppState.instance.addToCart(product);
                  Navigator.pushNamed(context, Routes.cart);
                },
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, Routes.store),
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}