import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { oneri, sikayet, teknikDestek, tumGonderiler }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.oneri: true,
          Filter.sikayet: true,
          Filter.teknikDestek: true,
          Filter.tumGonderiler: true,
        });
  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void resetFilters(
      bool isActiveOneri, bool isActiveSikayet, bool isActiveTeknikDestek) {
    if (isActiveOneri && isActiveSikayet && isActiveTeknikDestek) {
      state = {
        Filter.oneri: true,
        Filter.sikayet: true,
        Filter.teknikDestek: true,
        Filter.tumGonderiler: true,
      };
    } else {
      state = {...state, Filter.tumGonderiler: false};
    }
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());
