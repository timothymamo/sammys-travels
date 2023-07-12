import API from './API'

const PlacesList = (places, hidden, setHidden) => {

  const mouseOver = (_, index) => {
    setHidden(c => {
      return {
        ...c,
        [index]: false
      };
    })
  }

  const mouseOut = (_, index) => {
    setHidden(c => {
      return {
        ...c,
        [index]: true
      };
    })
  }

  return (
    places.map((place, index) => (
      <li key={index} onMouseEnter={(e) => { mouseOver(e, index); }}
        onMouseLeave={(e) => { mouseOut(e, index); }}>
        {place.place}
        <span onClick={() => API("delete", "", 'delete/' + place.place, "")}
          hidden={hidden[index]}
          className="delete-button">
          x
        </span>
      </li>
    ))
  )
};

export default PlacesList;