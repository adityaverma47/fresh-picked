import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../core/app_export.dart';
import '../data/models/AllFavodel/all_fav_model.dart';
import '../data/models/AllVegetablesModel/all_vegetables_model.dart';
import '../views/favourites/controller/favourites_controller.dart';

class CustomVegetable extends StatelessWidget {
  final Vegitables product;

  const CustomVegetable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favouritesController = Get.find<FavouritesController>();

    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                buildProductImage(product.vegitableImage ?? ImageConstants.greenCauliflower),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() {
                    final isFav = favouritesController.isFavourite(product.sId ?? "");
                    return GestureDetector(
                      onTap: () {
                        favouritesController.toggleWishlist(
                          FavouriteVegitables(sId: product.sId ?? ""),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.redAccent,
                          size: 22,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            product.name ?? 'No Name',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.inter,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: ColorConstants.redColor),
              SizedBox(width: 8.w),
              Text(
                _formatDistance(product.distance),
                style: TextStyle(fontSize: 13.sp, fontFamily: AppFonts.inter),
              ),
            ],
          ),
          Text(
            product.cost ?? 'N/A',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.inter,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String _formatDistance(String? distance) {
    if (distance == null || distance.isEmpty) return "0 m"; // Default to 0m

    // Extract numeric value and unit (e.g., "500 m" or "2.3 km")
    final regex = RegExp(r'([\d.]+)\s*(m|km)?', caseSensitive: false);
    final match = regex.firstMatch(distance);

    if (match != null) {
      double value = double.tryParse(match.group(1) ?? "0") ?? 0;
      String? unit = match.group(2)?.toLowerCase();

      if (unit == "m") {
        if (value < 1000) {
          return "${value.toInt()} m"; // Show meters if <1000m
        }
        value = value / 1000; // Convert meters to km
        return "${value.toStringAsFixed(1)} km";
      }

      if (unit == "km") {
        return "${value.toStringAsFixed(1)} km"; // Show km directly
      }
    }

    return "0 m"; // Fallback
  }

  Widget buildProductImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Image.asset(
        ImageConstants.tomato, // Default asset image
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Image.asset(ImageConstants.tomato),
        ),
      );
    }
  }
}
