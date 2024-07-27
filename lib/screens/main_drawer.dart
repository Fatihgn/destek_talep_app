import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/providers/filter_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors().green,
                AppColors().dark_blue.withOpacity(0.9)
              ], end: Alignment.bottomRight, begin: Alignment.topLeft)),
              child: Row(
                children: [
                  const Icon(
                    Icons.settings,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    "Kategori Ayarları",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              )),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.hotel_class_sharp,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              "Öneri",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            trailing: Switch(
              value: activeFilters[Filter.oneri]!,
              onChanged: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.oneri, value);
                ref.read(filterProvider.notifier).resetFilters(
                    value,
                    activeFilters[Filter.sikayet]!,
                    activeFilters[Filter.teknikDestek]!);
              },
              activeColor: AppColors().green,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.warning,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              "Şikayet",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            trailing: Switch(
              value: activeFilters[Filter.sikayet]!,
              onChanged: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.sikayet, value);
                ref.read(filterProvider.notifier).resetFilters(
                    activeFilters[Filter.oneri]!,
                    value,
                    activeFilters[Filter.teknikDestek]!);
              },
              activeColor: AppColors().green,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.account_circle_sharp,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              "Teknik Destek",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            trailing: Switch(
              value: activeFilters[Filter.teknikDestek]!,
              onChanged: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.teknikDestek, value);
                ref.read(filterProvider.notifier).resetFilters(
                    activeFilters[Filter.oneri]!,
                    activeFilters[Filter.sikayet]!,
                    value);
              },
              activeColor: AppColors().green,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.all_inclusive_sharp,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              "Tüm Gönderiler",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            trailing: Switch(
              value: activeFilters[Filter.tumGonderiler]!,
              onChanged: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.tumGonderiler, value);
                if (value) {
                  ref
                      .read(filterProvider.notifier)
                      .setFilter(Filter.oneri, true);
                  ref
                      .read(filterProvider.notifier)
                      .setFilter(Filter.sikayet, true);
                  ref
                      .read(filterProvider.notifier)
                      .setFilter(Filter.teknikDestek, true);
                }
              },
              activeColor: AppColors().green,
            ),
          ),
        ],
      ),
    );
  }
}
