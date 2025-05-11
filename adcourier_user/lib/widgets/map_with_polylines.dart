import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../constant.dart';

class MapWithPolylines extends StatefulWidget {
  final double originLatitude;
  final double originLongitude;
  final double destLatitude;
  final double destLongitude;
  final String address;

  const MapWithPolylines(
      {Key? key,
      required this.originLatitude,
      required this.originLongitude,
      required this.destLatitude,
      required this.destLongitude,
      required this.address})
      : super(key: key);

  @override
  MapWithPolylinesState createState() => MapWithPolylinesState();
}

class MapWithPolylinesState extends State<MapWithPolylines> {
  late GoogleMapController mapController;

  // double originLatitude = 26.48424, originLongitude = 50.04551;
  // double destLatitude = 26.46423, destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(widget.originLatitude, widget.originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.destLatitude, widget.destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.originLatitude, widget.originLongitude),
          zoom: 12),
      myLocationEnabled: true,
      tiltGesturesEnabled: false,
      compassEnabled: false,
      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(markers.values),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
        origin: PointLatLng(widget.originLatitude, widget.originLongitude),
        destination: PointLatLng(widget.destLatitude, widget.destLongitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: widget.address)],
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
