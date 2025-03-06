import 'package:dio/dio.dart';
import 'package:fresh_picked/core/app_export.dart';
import '../../../data/models/AllFavodel/all_fav_model.dart';

class FavouritesController extends GetxController {
  final ApiService apiService = ApiService(dio: DioClient().getDio());
  final secureStorage = const FlutterSecureStorage();
  var wishlist = <FavouriteVegitables>[].obs;
  var storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      fetchAllWishlist();
    });
  }

  /// Fetches all wishlist items
  Future<void> fetchAllWishlist() async {
    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        Message_Utils.displayToast("Token is missing. Please log in.");
        return;
      }

      Map<String, String> request = {
        Constants.userId: storage.read(Constants.id),
      };

      var response = await apiService.getAllFavourites(request);
      if (response.success == true && response.data?.user?.favouriteVegitables != null) {
        wishlist.assignAll(response.data!.user!.favouriteVegitables!);
        storage.write("wishlist", wishlist.map((e) => e.sId).toList());
      } else {
        wishlist.clear();
        storage.remove("wishlist");
      }
    } on DioException catch (e) {
      Message_Utils.displayToast("Error fetching wishlist: ${e.toString()}");
      wishlist.clear();
    } catch (e) {
      wishlist.clear();
    }
  }

  /// Adds an item to the wishlist (locally first, then API)
  Future<void> addToFav(String vegitableId) async {
    wishlist.add(FavouriteVegitables(sId: vegitableId));
    _updateLocalStorage();

    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        Message_Utils.displayToast("Authentication error. Please log in.");
        return;
      }

      Map<String, String> request = {
        'vegitableId': vegitableId,
        Constants.userId: storage.read(Constants.id),
      };
      var response = await apiService.addToFavourites(request);

      if (response.success == true) {
        fetchAllWishlist(); // Refresh from backend
        CustomSnackBar(response.message.toString(), "S");
      } else {
        wishlist.removeWhere((item) => item.sId == vegitableId); // Rollback UI
        _updateLocalStorage();
        CustomSnackBar(response.message.toString(), "E");
      }
    } on DioException catch (e) {
      wishlist.removeWhere((item) => item.sId == vegitableId); // Rollback UI
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    } catch (e) {
      wishlist.removeWhere((item) => item.sId == vegitableId);
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    }
  }

  /// Removes an item from the wishlist (locally first, then API)
  Future<void> removeFromFav(String itemId) async {
    wishlist.removeWhere((item) => item.sId == itemId);
    _updateLocalStorage();

    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        Message_Utils.displayToast("Authentication error. Please log in.");
        return;
      }

      Map<String, String> request = {
        Constants.userId: storage.read(Constants.id),
        'vegitableId': itemId,
      };
      var response = await apiService.removeFromFav(request);

      if (response.status == true) {
        CustomSnackBar(response.message.toString(), "S");
      } else {
        wishlist.add(FavouriteVegitables(sId: itemId)); // Rollback UI
        _updateLocalStorage();
        CustomSnackBar(response.message.toString(), "E");
      }
    } on DioException catch (e) {
      wishlist.add(FavouriteVegitables(sId: itemId)); // Rollback UI
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    } catch (e) {
      wishlist.add(FavouriteVegitables(sId: itemId));
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    }
  }

  /// Toggles wishlist status of an item
  void toggleWishlist(FavouriteVegitables item) async {
    if (wishlist.any((fav) => fav.sId == item.sId)) {
      await removeFromFav(item.sId ?? "");
    } else {
      await addToFav(item.sId ?? "");
    }
  }

  /// Updates local storage with the current wishlist
  void _updateLocalStorage() {
    storage.write("wishlist", wishlist.map((e) => e.sId).toList());
  }
}
