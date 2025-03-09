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
        _updateLocalStorage(); // Ensure local storage syncs properly
      } else {
        wishlist.clear();
        _updateLocalStorage();
      }
    } on DioException catch (e) {
      Message_Utils.displayToast("Error fetching wishlist: ${e.toString()}");
      wishlist.clear();
      _updateLocalStorage();
    } catch (e) {
      wishlist.clear();
      _updateLocalStorage();
    }
  }

  /// Adds an item to the wishlist (locally first, then API)
  Future<void> addToFav(FavouriteVegitables vegitable) async {
    wishlist.add(vegitable);
    _updateLocalStorage(); // Update storage immediately

    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        Message_Utils.displayToast("Authentication error. Please log in.");
        wishlist.remove(vegitable); // Rollback UI
        _updateLocalStorage();
        return;
      }

      Map<String, String> request = {
        'vegitableId': vegitable.sId!,
        Constants.userId: storage.read(Constants.id),
      };
      var response = await apiService.addToFavourites(request);

      if (response.success == true) {
        fetchAllWishlist(); // Refresh from backend
        // CustomSnackBar(response.message.toString(), "S");
      } else {
        // wishlist.remove(vegitable); // Rollback UI
        _updateLocalStorage();
        CustomSnackBar(response.message.toString(), "E");
      }
    } on DioException catch (e) {
      wishlist.remove(vegitable); // Rollback UI
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    } catch (e) {
      wishlist.remove(vegitable);
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    }
  }

  /// Removes an item from the wishlist (locally first, then API)
  Future<void> removeFromFav(String itemId) async {
    FavouriteVegitables? removedItem;
    try {
      removedItem = wishlist.firstWhere((item) => item.sId == itemId);
    } catch (e) {
      return;
    }

    wishlist.remove(removedItem);
    _updateLocalStorage();

    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        Message_Utils.displayToast("Authentication error. Please log in.");
        wishlist.add(removedItem);
        _updateLocalStorage();
        return;
      }

      Map<String, String> request = {
        Constants.userId: storage.read(Constants.id),
        'vegitableId': itemId,
      };
      var response = await apiService.removeFromFav(request);

      if (response.success == true) {
      } else {
      }
    } on DioException catch (e) {
      wishlist.add(removedItem); // Rollback UI
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    } catch (e) {
      wishlist.add(removedItem);
      _updateLocalStorage();
      Message_Utils.displayToast(e.toString());
    }
  }

  /// Toggles wishlist status of an item
  Future<void> toggleWishlist(FavouriteVegitables item) async {
    if (item.sId == null || item.sId!.isEmpty) return;
    if (wishlist.any((fav) => fav.sId == item.sId)) {
      await removeFromFav(item.sId!);
    } else {
      await addToFav(item);
    }
  }

  /// Updates local storage with the current wishlist
  void _updateLocalStorage() {
    List<Map<String, dynamic>> wishlistData = wishlist.map((e) => e.toJson()).toList();
    storage.write("wishlist", wishlistData);
  }

  bool isFavourite(String id) {
    return wishlist.any((item) => item.sId == id);
  }
}
