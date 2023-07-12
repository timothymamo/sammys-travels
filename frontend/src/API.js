import axios from 'axios';

function API(method, data, endpoint, headers) {
  if (headers === "") {
    headers = { 'Content-Type': 'application/json' }
  }

  var config = {
    method: method,
    maxBodyLength: Infinity,
    url: process.env.REACT_APP_SITE_API + endpoint,
    headers: headers,
    data: data
  };

  axios(config).then(function (response) {
    console.log(JSON.stringify(response.data));
  }).catch(function (error) {
    console.log(error);
  });
};

export default API;