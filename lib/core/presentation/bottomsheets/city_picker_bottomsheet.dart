import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_trackr/core/data/api/api_ninja/samurai.dart';
import 'package:travel_trackr/core/data/models/city/city.dart';
import 'package:travel_trackr/core/presentation/bottomsheets/app_bottomsheet.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';
import 'package:travel_trackr/core/utils/context_extension.dart';
import 'package:travel_trackr/core/utils/spacing.dart';

import '../../di/injection.dart';
import '../../l10n/generated/l10n.dart';

class CityPickerBottomsheet extends StatefulWidget {
  final String? country;
  final void Function(City city)? onCitySelected;

  const CityPickerBottomsheet({
    Key? key,
    this.country,
    this.onCitySelected,
  }) : super(key: key);

  @override
  State<CityPickerBottomsheet> createState() => _CityPickerBottomsheetState();
}

class _CityPickerBottomsheetState extends State<CityPickerBottomsheet> {
  bool loading = false;
  bool error = false;
  List<City> loadedCities = [];
  Timer? debounce;
  String searchText = '';

  void onChanged(String value) {
    searchText = value;
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 300), search);
  }

  Future<void> search() async {
    setState(() {
      loading = true;
      error = false;
    });
    try {
      var cities = await getIt<Samurai>().getCities(
        name: searchText,
        country: widget.country,
      );
      if (mounted) {
        setState(() {
          loadedCities = cities;
          loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          loading = false;
          error = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomsheet(
      child: SizedBox(
        height: context.screenHeight * 0.85,
        child: Column(
          children: [
            20.0.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44.0),
              child: AppTextField(
                hint: S.of(context).city,
                onChanged: onChanged,
              ),
            ),
            20.0.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: loadedCities.length + (loading ? 1 : 0),
                itemBuilder: (context, index) => loading && index == 0
                    ? const Center(child: CircularProgressIndicator())
                    : ListTile(
                        title:
                            Text(loadedCities[index - (loading ? 1 : 0)].name),
                        onTap: () {
                          Navigator.pop(context);
                          if (widget.onCitySelected != null) {
                            widget.onCitySelected!(
                                loadedCities[index - (loading ? 1 : 0)]);
                          }
                        },
                      ),
                separatorBuilder: (context, index) => loading && index == 0
                    ? const SizedBox.shrink()
                    : const Divider(height: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
