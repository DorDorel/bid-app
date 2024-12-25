import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/products_provider.dart';
import '../../../data/models/product.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    productsData.fetchData();

    return productsData.products.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Catalog",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 32.0,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Expanded(
                      child: CardSwiper(
                        controller: controller,
                        cardsCount: productsData.products.length,
                        numberOfCardsDisplayed: 3,
                        backCardOffset: const Offset(30, 30),
                        padding: const EdgeInsets.all(10.0),
                        onSwipe: (previousIndex, currentIndex, direction) {
                          return true;
                        },
                        cardBuilder: (context,
                                index,
                                horizontalThresholdPercentage,
                                verticalThresholdPercentage) =>
                            ProductCard(
                          product: productsData.products[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(
              product.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
