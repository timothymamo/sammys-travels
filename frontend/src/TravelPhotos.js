function TravelPhotos(visited) {
  return (
    visited.slice(Math.max(visited.length - 3, 0)).map((photo, index) => (
      <div key={index} className="photo">
        <li>
          <img src={process.env.REACT_APP_BUCKET + photo.photo} alt={photo.place} />
          <p>{photo.place}</p>
        </li>
      </div>
    ))
  );
};


export default TravelPhotos;