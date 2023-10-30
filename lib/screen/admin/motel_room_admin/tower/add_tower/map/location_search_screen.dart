import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/motel_room_admin/tower/add_tower/map/location_search_controller.dart';
import 'package:gohomy/utils/debounce.dart';
import 'package:google_maps_webservice/places.dart' as places;

class LocationSearchScreen extends GetView<LocationSearchController> {
  LocationSearchScreen({super.key}) {
    Get.put(LocationSearchController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _SearchField(),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Obx(() {
        return controller.state.status.isInitial
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Center(child: Text("Search for a location")),
              )
            : controller.state.status.isError
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(child: Text(controller.state.message)),
                  )
                : controller.state.status.isLoaded
                    ? ListView.builder(
                        itemCount: controller.state.data.length,
                        itemBuilder: (context, index) {
                          final item = controller.state.data[index]
                              as places.Prediction?;
                          return _Card(item: item);
                        },
                      )
                    : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class _SearchField extends GetView<LocationSearchController> {
  const _SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              hintText: 'Search location',
              prefixIcon: const Icon(Icons.search),
              // loading indicator on the right side of the text field
              suffixIcon: controller.state.status.isLoading
                  ? const Center(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(5),
            ),
            onChanged: (v) async {
              EasyDebounce.debounce(
                  'location_search_screen', const Duration(milliseconds: 250),
                  () {
                controller.getSearchResult();
              });
            },
          ),
        ),
      );
    });
  }
}

class _Card extends StatelessWidget {
  const _Card({
    super.key,
    required this.item,
  });

  final places.Prediction? item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${item?.structuredFormatting?.mainText}'),
      subtitle: Text('${item?.structuredFormatting?.secondaryText}'),
      onTap: () {
        Get.back(result: item);
      },
    );
  }
}
