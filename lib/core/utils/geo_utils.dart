import 'dart:math';

double calculateDistance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  const R = 6371; //km
  double dlat = _deg2rad(lat2 - lat1);
  double dlon = _deg2rad(lon2 - lon1);

  double a = 
    sin(dlat / 2) * sin (dlat / 2) +
    cos(_deg2rad(lat1)) *
        cos(_deg2rad(lat2)) *
        sin(dlon / 2) *
        sin(dlon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _deg2rad(double deg) {
  return deg * (pi / 180);
}