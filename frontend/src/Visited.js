import Popup from 'reactjs-popup';
import API from './API'
import PlacesList from './PlacesList'


function Visited(visited, place, setPlace, photo, setPhoto, hidden, setHidden) {
  const handleChange = (event) => {
    const { name, value } = event.target;
    setPlace((prevFormData) => ({ ...prevFormData, [name]: value }));
  };

  const handleFileChange = (event) => {
    setPhoto(event.target.files[0]);
  };

  const addVisited = async (place, photo) => {
    var data = JSON.stringify({
      "place": place,
      "photo": photo.name,
    });

    API("post", data, "addvisited", "")

    const formData = new FormData();
    formData.append("file", photo);

    const headers = { "Content-Type": "multipart/form-data" };

    API("post", formData, "uploadphoto", headers)
  };

  return (
    <ul className="list">
      <li className="header visited">Visited<Popup trigger=
        {<button className="add-button">+</button>}
        modal nested>
        {
          close => (
            <div className="modal">
              <button className="close" onClick={close}>X</button>
              <form>
                <label className="header" htmlFor="place">Place Visited: </label>
                <input type="text" name="place" value={place.place} onChange={handleChange} />
                <input className="file" type="file" onChange={handleFileChange} />
                <button onClick={() => { addVisited(place.place, photo); close(); }}>Submit</button>
              </form>
            </div>
          )
        }
      </Popup>
      </li>
      {PlacesList(visited, hidden, setHidden)}
    </ul>
  )
};

export default Visited;