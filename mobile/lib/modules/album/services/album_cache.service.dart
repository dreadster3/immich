
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/constants/hive_box.dart';
import 'package:immich_mobile/modules/home/services/asset_cache.service.dart';
import 'package:openapi/api.dart';

class AlbumCacheService extends JsonCache<List<AlbumResponseDto>> {
  AlbumCacheService() : super(albumListCacheBox, albumListCachedAssets);

  @override
  void put(List<AlbumResponseDto> data) {
    putRawData(data.map((e) => e.toJson()).toList());
  }

  @override
  List<AlbumResponseDto> get() {
    try {
      final mapList =  readRawData() as List<dynamic>;

      final responseData = mapList
          .map((e) => AlbumResponseDto.fromJson(e))
          .whereNotNull()
          .toList();

      return responseData;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

}

final albumCacheServiceProvider = Provider(
      (ref) => AlbumCacheService(),
);
