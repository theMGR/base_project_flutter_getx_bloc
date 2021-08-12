import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGoogle extends StatefulWidget {
  final void Function(GoogleMapController controller)? onMapCreated;

  /// The initial position of the map's camera.
  final CameraPosition initialCameraPosition;

  /// True if the map should show a compass when rotated.
  final bool compassEnabled;

  /// True if the map should show a toolbar when you interact with the map. Android only.
  final bool mapToolbarEnabled;

  /// Geographical bounding box for the camera target.
  final CameraTargetBounds cameraTargetBounds;

  /// Type of map tiles to be rendered.
  final MapType mapType;

  /// Preferred bounds for the camera zoom level.
  ///
  /// Actual bounds depend on map data and device.
  final MinMaxZoomPreference minMaxZoomPreference;

  /// True if the map view should respond to rotate gestures.
  final bool rotateGesturesEnabled;

  /// True if the map view should respond to scroll gestures.
  final bool scrollGesturesEnabled;

  /// True if the map view should show zoom controls. This includes two buttons
  /// to zoom in and zoom out. The default value is to show zoom controls.
  ///
  /// This is only supported on Android. And this field is silently ignored on iOS.
  final bool zoomControlsEnabled;

  /// True if the map view should respond to zoom gestures.
  final bool zoomGesturesEnabled;

  /// True if the map view should be in lite mode. Android only.
  ///
  /// See https://developers.google.com/maps/documentation/android-sdk/lite#overview_of_lite_mode for more details.
  final bool liteModeEnabled;

  /// True if the map view should respond to tilt gestures.
  final bool tiltGesturesEnabled;

  /// Padding to be set on map. See https://developers.google.com/maps/documentation/android-sdk/map#map_padding for more details.
  final EdgeInsets padding;

  /// Markers to be placed on the map.
  final Set<Marker> markers;

  /// Polygons to be placed on the map.
  final Set<Polygon> polygons;

  /// Polylines to be placed on the map.
  final Set<Polyline> polylines;

  /// Circles to be placed on the map.
  final Set<Circle> circles;

  /// Tile overlays to be placed on the map.
  final Set<TileOverlay> tileOverlays;

  /// Called when the camera starts moving.
  ///
  /// This can be initiated by the following:
  /// 1. Non-gesture animation initiated in response to user actions.
  ///    For example: zoom buttons, my location button, or marker clicks.
  /// 2. Programmatically initiated animation.
  /// 3. Camera motion initiated in response to user gestures on the map.
  ///    For example: pan, tilt, pinch to zoom, or rotate.
  final VoidCallback? onCameraMoveStarted;

  /// Called repeatedly as the camera continues to move after an
  /// onCameraMoveStarted call.
  ///
  /// This may be called as often as once every frame and should
  /// not perform expensive operations.
  final CameraPositionCallback? onCameraMove;

  /// Called when camera movement has ended, there are no pending
  /// animations and the user has stopped interacting with the map.
  final VoidCallback? onCameraIdle;

  /// Called every time a [GoogleMap] is tapped.
  final ArgumentCallback<LatLng>? onTap;

  /// Called every time a [GoogleMap] is long pressed.
  final ArgumentCallback<LatLng>? onLongPress;

  /// True if a "My Location" layer should be shown on the map.
  ///
  /// This layer includes a location indicator at the current device location,
  /// as well as a My Location button.
  /// * The indicator is a small blue dot if the device is stationary, or a
  /// chevron if the device is moving.
  /// * The My Location button animates to focus on the user's current location
  /// if the user's location is currently known.
  ///
  /// Enabling this feature requires adding location permissions to both native
  /// platforms of your app.
  /// * On Android add either
  /// `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />`
  /// or `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />`
  /// to your `AndroidManifest.xml` file. `ACCESS_COARSE_LOCATION` returns a
  /// location with an accuracy approximately equivalent to a city block, while
  /// `ACCESS_FINE_LOCATION` returns as precise a location as possible, although
  /// it consumes more battery power. You will also need to request these
  /// permissions during run-time. If they are not granted, the My Location
  /// feature will fail silently.
  /// * On iOS add a `NSLocationWhenInUseUsageDescription` key to your
  /// `Info.plist` file. This will automatically prompt the user for permissions
  /// when the map tries to turn on the My Location layer.
  final bool myLocationEnabled;

  /// Enables or disables the my-location button.
  ///
  /// The my-location button causes the camera to move such that the user's
  /// location is in the center of the map. If the button is enabled, it is
  /// only shown when the my-location layer is enabled.
  ///
  /// By default, the my-location button is enabled (and hence shown when the
  /// my-location layer is enabled).
  ///
  /// See also:
  ///   * [myLocationEnabled] parameter.
  final bool myLocationButtonEnabled;

  /// Enables or disables the indoor view from the map
  final bool indoorViewEnabled;

  /// Enables or disables the traffic layer of the map
  final bool trafficEnabled;

  /// Enables or disables showing 3D buildings where available
  final bool buildingsEnabled;

  /// Which gestures should be consumed by the map.
  ///
  /// It is possible for other gesture recognizers to be competing with the map on pointer
  /// events, e.g if the map is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The map will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty, the map will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  const MapGoogle(
      {Key? key,
      this.onMapCreated,
      this.initialCameraPosition = const CameraPosition(target: LatLng(11.1271, 78.6569), zoom: 6.0),
      //this.onMapCreated,
      this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
      this.compassEnabled = true,
      this.mapToolbarEnabled = true,
      this.cameraTargetBounds = CameraTargetBounds.unbounded,
      this.mapType = MapType.normal,
      this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
      this.rotateGesturesEnabled = true,
      this.scrollGesturesEnabled = true,
      this.zoomControlsEnabled = true,
      this.zoomGesturesEnabled = true,
      this.liteModeEnabled = false,
      this.tiltGesturesEnabled = true,
      this.myLocationEnabled = false,
      this.myLocationButtonEnabled = true,
      this.padding = const EdgeInsets.all(0),
      this.indoorViewEnabled = false,
      this.trafficEnabled = false,
      this.buildingsEnabled = true,
      this.markers = const <Marker>{},
      this.polygons = const <Polygon>{},
      this.polylines = const <Polyline>{},
      this.circles = const <Circle>{},
      this.onCameraMoveStarted,
      this.tileOverlays = const <TileOverlay>{},
      this.onCameraMove,
      this.onCameraIdle,
      this.onTap,
      this.onLongPress})
      : super(key: key);

  @override
  _MapGoogleState createState() => _MapGoogleState(
      onMapCreated: onMapCreated,
      initialCameraPosition: initialCameraPosition,
      compassEnabled: compassEnabled,
      mapToolbarEnabled: mapToolbarEnabled,
      cameraTargetBounds: cameraTargetBounds,
      mapType: mapType,
      minMaxZoomPreference: minMaxZoomPreference,
      rotateGesturesEnabled: rotateGesturesEnabled,
      scrollGesturesEnabled: scrollGesturesEnabled,
      zoomControlsEnabled: zoomControlsEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled,
      liteModeEnabled: liteModeEnabled,
      tiltGesturesEnabled: tiltGesturesEnabled,
      padding: padding,
      markers: markers,
      polygons: polygons,
      polylines: polylines,
      circles: circles,
      tileOverlays: tileOverlays,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
      onTap: onTap,
      onLongPress: onLongPress,
      myLocationEnabled: myLocationEnabled,
      myLocationButtonEnabled: myLocationButtonEnabled,
      indoorViewEnabled: indoorViewEnabled,
      trafficEnabled: trafficEnabled,
      buildingsEnabled: buildingsEnabled,
      gestureRecognizers: gestureRecognizers);
}

class _MapGoogleState extends State<MapGoogle> {
  final void Function(GoogleMapController controller)? onMapCreated;
  final CameraPosition initialCameraPosition;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final MapType mapType;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool liteModeEnabled;
  final bool tiltGesturesEnabled;
  final EdgeInsets padding;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<TileOverlay> tileOverlays;
  final VoidCallback? onCameraMoveStarted;
  final CameraPositionCallback? onCameraMove;
  final VoidCallback? onCameraIdle;
  final ArgumentCallback<LatLng>? onTap;
  final ArgumentCallback<LatLng>? onLongPress;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool indoorViewEnabled;
  final bool trafficEnabled;
  final bool buildingsEnabled;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  GoogleMapController? mapController;

  _MapGoogleState(
      {required this.onMapCreated,
      required this.initialCameraPosition,
      required this.compassEnabled,
      required this.mapToolbarEnabled,
      required this.cameraTargetBounds,
      required this.mapType,
      required this.minMaxZoomPreference,
      required this.rotateGesturesEnabled,
      required this.scrollGesturesEnabled,
      required this.zoomControlsEnabled,
      required this.zoomGesturesEnabled,
      required this.liteModeEnabled,
      required this.tiltGesturesEnabled,
      required this.padding,
      required this.markers,
      required this.polygons,
      required this.polylines,
      required this.circles,
      required this.tileOverlays,
      required this.onCameraMoveStarted,
      required this.onCameraMove,
      required this.onCameraIdle,
      required this.onTap,
      required this.onLongPress,
      required this.myLocationEnabled,
      required this.myLocationButtonEnabled,
      required this.indoorViewEnabled,
      required this.trafficEnabled,
      required this.buildingsEnabled,
      required this.gestureRecognizers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _googleMap(context));
  }

  GoogleMap _googleMap(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: compassEnabled,
        mapToolbarEnabled: mapToolbarEnabled,
        cameraTargetBounds: cameraTargetBounds,
        mapType: mapType,
        minMaxZoomPreference: minMaxZoomPreference,
        rotateGesturesEnabled: rotateGesturesEnabled,
        scrollGesturesEnabled: scrollGesturesEnabled,
        zoomControlsEnabled: zoomControlsEnabled,
        zoomGesturesEnabled: zoomGesturesEnabled,
        liteModeEnabled: liteModeEnabled,
        tiltGesturesEnabled: tiltGesturesEnabled,
        padding: padding,
        markers: markers,
        polygons: polygons,
        polylines: polylines,
        circles: circles,
        tileOverlays: tileOverlays,
        onCameraMoveStarted: onCameraMoveStarted,
        onCameraMove: onCameraMove,
        onCameraIdle: onCameraIdle,
        onTap: onTap,
        onLongPress: onLongPress,
        myLocationEnabled: myLocationEnabled,
        myLocationButtonEnabled: myLocationButtonEnabled,
        indoorViewEnabled: indoorViewEnabled,
        trafficEnabled: trafficEnabled,
        buildingsEnabled: buildingsEnabled,
        gestureRecognizers: gestureRecognizers);
  }
}
