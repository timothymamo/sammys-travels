import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'reactjs-popup/dist/index.css';
import './global.css';
import Visited from './Visited'
import ToGo from './ToGo'
import ShowMap from './Map'
import TravelPhotos from './TravelPhotos'

const App = () => {
  const [visited, setVisited] = useState([]);
  const [togo, setToGo] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [visitedRes, togoRes] = await Promise.all([
          axios.get(process.env.REACT_APP_SITE_API + 'visited'),
          axios.get(process.env.REACT_APP_SITE_API + 'togo'),
        ]);
        setVisited(visitedRes.data);
        setToGo(togoRes.data);
      } catch (err) {
        console.error(err);
      }
    };
    fetchData();
  }, [visited, togo])

  return (
    <>
      <header>
        <h1>Sammy's Travels</h1>
      </header>
      <div className="main">
        <div className="map_container clearfix">
          <div className="column x3">
            <div className="column x5">
              {Visited(visited)}
            </div>
            <div className="column x5">
              {ToGo(togo)}
            </div>
          </div>
          <div className="column x7">
            <div id="map" className="map">
              {ShowMap(visited, togo)}
            </div>
          </div>
          <div className="clearfix"></div>
        </div >
      </div >
      <div className="footer clearfix">
        <h2>Travel Photos</h2>
        {TravelPhotos(visited)}
      </div>
    </>
  );
};

export default App;