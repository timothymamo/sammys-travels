import { MapContainer, Marker, Popup, TileLayer } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css'

import iconVisited from './images/marker_visited.png';
import iconToGo from './images/marker_togo.png';
import iconShadow from 'leaflet/dist/images/marker-shadow.png';

let IconVisited = L.icon({
  iconUrl: iconVisited,
  shadowUrl: iconShadow,
  iconAnchor: [12, 38],
  popupAnchor: [0, -38]
});

let IconToGo = L.icon({
  iconUrl: iconToGo,
  shadowUrl: iconShadow,
  iconAnchor: [12, 38],
  popupAnchor: [0, -38]
});

function ShowMap(visited, togo) {
  return (
    <MapContainer center={[25, 0]} zoom={2}>
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      {togo.map((togo, index) => (
        <Marker key={index} position={[togo.longitude, togo.latitude]} icon={IconToGo}>
          <Popup className="request-popup">
            <p>{togo.place}</p>
          </Popup>
        </Marker>
      ))}
      {visited.map((visited, index) => (
        <Marker key={index} position={[visited.longitude, visited.latitude]} icon={IconVisited}>
          <Popup className="request-popup">
            <img src={process.env.REACT_APP_BUCKET + visited.photo} alt={visited.place} />
            <p>{visited.place}</p>
          </Popup>
        </Marker>
      ))}
    </MapContainer>
  );
};

export default ShowMap;