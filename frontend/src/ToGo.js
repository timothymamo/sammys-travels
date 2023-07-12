import Popup from 'reactjs-popup';
import API from './API'
import PlacesList from './PlacesList'

function ToGo(togo, place, setPlace, hidden, setHidden) {
  const handleChange = (event) => {
    const { name, value } = event.target;
    setPlace((prevFormData) => ({ ...prevFormData, [name]: value }));
  };

  const addToGo = async (place) => {
    var data = JSON.stringify({
      "place": place,
    });

    API("post", data, "addtogo", "")
  };

  return (
    <ul className="list">
      <li className="header togo">To Go<Popup trigger=
        {<button className="add-button">+</button>}
        modal nested>
        {
          close => (
            <div className="modal">
              <button className="close" onClick={close}>X</button>
              <form>
                <label className="header" htmlFor="place">Place To Go: </label>
                <input type="text" name="place" value={place.place} onChange={handleChange} />
                <button onClick={() => { addToGo(place.place); close(); }}>Submit</button>
              </form>
            </div>
          )
        }
      </Popup>
      </li>
      {PlacesList(togo, hidden, setHidden)}
    </ul>
  );
};

export default ToGo;