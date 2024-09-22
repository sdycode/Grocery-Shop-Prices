import 'package:groceryshopprices/lib.dart';
import 'package:json_cache/json_cache.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
 
class UtilityHandler {
  //

  static UtilityHandler? instance;
  static JsonCache? jsonCache;

  static Future<UtilityHandler?> getInstance() async {
    if (instance == null) {
      CacheStore? cacheStore;
      final LocalStorage storage = LocalStorage(validUID);
      jsonCache = JsonCacheMem(JsonCacheLocalStorage(storage));
      var dir = await getApplicationSupportDirectory();

      cacheStore = HiveCacheStore(dir.path);
      // var cacheOptions = CacheOptions(
      //   store: cacheStore,
      //   maxStale: const Duration(days: 7),
      //   policy: CachePolicy.request,
      //   hitCacheOnErrorExcept: [], // for offline behaviour
      // );
      // Dio dio = Dio()
      //   ..interceptors.add(
      //     DioCacheInterceptor(options: cacheOptions),
      //   );
      return instance = UtilityHandler._internal();
    } else {
      return instance;
    }
  }

  UtilityHandler._internal();
  
  /// app realted
}
