import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_trackr/core/data/api/api_ninja/samurai.dart';
import 'package:travel_trackr/core/data/models/airport/airport.dart';
import 'package:travel_trackr/core/data/models/city/city.dart';
import 'package:travel_trackr/core/presentation/bottomsheets/app_bottomsheet.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';
import 'package:travel_trackr/core/utils/context_extension.dart';
import 'package:travel_trackr/core/utils/spacing.dart';

import '../../di/injection.dart';
import '../../l10n/generated/l10n.dart';

class AirportPickerBottomsheet extends StatefulWidget {
  final void Function(Airport city)? onAirportSelected;

  const AirportPickerBottomsheet({
    Key? key,
    this.onAirportSelected,
  }) : super(key: key);

  @override
  State<AirportPickerBottomsheet> createState() =>
      _AirportPickerBottomsheetState();
}

class _AirportPickerBottomsheetState extends State<AirportPickerBottomsheet> {
  bool loading = false;
  bool error = false;
  List<Airport> loadedAirports = [];
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
      var airports = await getIt<Samurai>().getAirports(name: searchText);
      if (mounted) {
        setState(() {
          loadedAirports = airports;
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
                autofocus: true,
              ),
            ),
            20.0.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: loadedAirports.length + (loading ? 1 : 0),
                itemBuilder: (context, index) => loading && index == 0
                    ? const Center(child: CircularProgressIndicator())
                    : ListTile(
                        title: Text(loadedAirports[index - (loading ? 1 : 0)]
                                .iata
                                .isNotEmpty
                            ? loadedAirports[index - (loading ? 1 : 0)].iata
                            : loadedAirports[index - (loading ? 1 : 0)].city),
                        subtitle: Text(
                          loadedAirports[index - (loading ? 1 : 0)].name,
                          style: AppTextTheme.bodySmall,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          if (widget.onAirportSelected != null) {
                            widget.onAirportSelected!(
                                loadedAirports[index - (loading ? 1 : 0)]);
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
