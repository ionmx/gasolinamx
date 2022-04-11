let map;

function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 28.6407, lng: -106.0726 },
    zoom: 12,
  });

  google.maps.event.addListenerOnce(map, 'bounds_changed', function() {
    getStations();
  });

  map.addListener("dragend", () => {
    getStations();
  });
}



function getStations() {
	let bounds = map.getBounds();
    let NE = bounds.getNorthEast();
    let SW = bounds.getSouthWest();
    let NW = new google.maps.LatLng(NE.lat(),SW.lng());
    let SE = new google.maps.LatLng(SW.lat(),NE.lng());
    let p1 = NW.lat() + "," + NW.lng();
    let p2 = SE.lat() + "," + SE.lng();

	url = 'https://gasolinamx.herokuapp.com/api/v1/area?'
	url = url + 'p1=' + p1 + '&p2=' + p2
	fetch(url)
		.then(response => response.json())
		.then(data => populateStations(data))
}


function populateStations(data) {
	for (var i in data) {
		new google.maps.Marker({
      		map: map,
      		position: new google.maps.LatLng(data[i].latitude,data[i].longitude),
      		label: {
    			text: data[i].regular,
    			fontSize: "8px"
  			}

    	});
	}
}
