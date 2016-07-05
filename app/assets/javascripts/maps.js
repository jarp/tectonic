// $(document).ready(function(){
//   if ( document.getElementById('map') ){
//
//     var map = new google.maps.Map(document.getElementById('places-map'));
//     var geocoder = new google.maps.Geocoder();
//     var bounds = new google.maps.LatLngBounds();
//     var user_cords;
//     var place_cords;
//     var infowindow = new google.maps.InfoWindow();
//     var placeService = new google.maps.places.PlacesService(map);
//     var matrixService = new google.maps.DistanceMatrixService();
//     var request = { placeId: $('#places-map').attr("place_id")};
//     var pinColor = "53697e";
//     var defaultPin = new google.maps.MarkerImage("//chart.googleapis.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor + "|" + "ffffff",
//         new google.maps.Size(48, 48),
//         new google.maps.Point(0,0),
//         new google.maps.Point(10, 34));
//
//
//     function initialize() {
//       placeService.getDetails(request, function(place, status) {
//         if (status == google.maps.places.PlacesServiceStatus.OK) {
//           place_cords = new google.maps.LatLng(place.geometry.location.lat(),place.geometry.location.lng())
//           map = new google.maps.Map(document.getElementById('places-map'), {
//             center: place_cords,
//             zoom: 12
//           });
//
//           var marker = new google.maps.Marker({
//             map: map,
//             icon: defaultPin,
//             position: place.geometry.location
//           });
//
//           google.maps.event.addListener(marker, 'click', function() {
//             infowindow.setContent(place.name);
//             infowindow.open(map, this);
//           });
//
//           getUserLocation();
//
//         }
//
//       });
//     }
//
//     function getUserLocation(){
//       var geolocationOptions = {
//         enableHighAccuracy: true,
//         timeout: 5000,
//         maximumAge: 0
//       };
//       navigator.geolocation.getCurrentPosition(success, error, geolocationOptions);
//     }
//
//     function getDistance(){
//       matrixService.getDistanceMatrix(
//         {
//           origins: [user_cords],
//           destinations: [place_cords],
//           travelMode: google.maps.TravelMode.DRIVING,
//           unitSystem: google.maps.UnitSystem.IMPERIAL,
//           avoidHighways: false,
//           avoidTolls: false
//         }, distanceHandler);
//     }
//
//     function distanceHandler(response, status){
//       if (status == google.maps.DistanceMatrixStatus.OK) {
//         if(response.rows.length > 0){
//           var data = response.rows[0].elements[0];
//           $('#travel-info').html("<p>Travel Time: " + data.distance.text + " | " + data.duration.text ).fadeIn();
//         }
//       } else {
//         alert('Error was: ' + status);
//       }
//     }
//
//     function success(pos) {
//       var crd = pos.coords;
//       user_cords = new google.maps.LatLng(crd.latitude, crd.longitude)
//       getDistance();
//     };
//
//     function error(err) {
//       console.warn('ERROR(' + err.code + '): ' + err.message);
//     };
//
//   initialize();
//
//   }
// });
