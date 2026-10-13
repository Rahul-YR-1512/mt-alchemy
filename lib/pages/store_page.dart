import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/product_card.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _segment = 'All';

  List<Product> get _visible {
    if (_segment == 'Digital') {
      return SampleData.products
          .where((p) => p.type == ProductType.digital)
          .toList();
    }
    if (_segment == 'Physical') {
      return SampleData.products
          .where((p) => p.type == ProductType.physical)
          .toList();
    }
    return SampleData.products;
  }

  @override
  Widget build(BuildContext context) {
    final products = _visible;
    return AppScaffold(
      title: 'Store',
      body: SingleChildScrollView(
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'MT Alchemy Store',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Tools and kits to keep the growth going.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 18),
              _segmented(),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 640 ? 3 : 2;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, i) {
                      final p = products[i];
                      return ProductCard(
                        product: p,
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.productDetail,
                          arguments: p,
                        ),
                        onAdd: () => _add(p),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _add(Product p) {
    AppState.instance.addToCart(p);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${p.name} added to cart'),
        backgroundColor: AppColors.deepBlue,
      ),
    );
  }

  Widget _segmented() {
    final options = ['All', 'Digital', 'Physical'];
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.lavender,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: options.map((o) {
          final selected = o == _segment;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _segment = o),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: selected ? AppColors.deepBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  o,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.deepBlue,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}