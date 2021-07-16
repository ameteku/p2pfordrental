const express = require("express");
const request = require("request");


const app = express();

const applicationId = "afdc085b-377a-4351-b23e-5e1d35fb3700";
const clientId = '30990062-9618-40e1-a27b-7c6bcb23658a';
const clientSecret = 'T_Wk41dx2U9v22R5sQD4Z_E1u-l2B-jXHE';
const code = 'eyJraWQiOiI2cjIzQ2FTeTF4cFdUUFBxYVRtX01Vc2RKZGo1RWlDTnRtME4yVTAxNTdFIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.SMRiPeTqVZwNr1nfSrczVIRMgpKVTn020RyA2aA5g5ELRhHurMosOxJSQ-tOMYT5_E06gh0NRaPVzqP0YG9lejCkjbhE_6wJR-zb6bXORvnZqMGko3tZZ7lE1XVcy-acCRHiEZX0oGnsEgXHmPpEYEA1vOfjSKFBhUeSFnXmHKsvSJFaj5eThU-pfI2OJKf3aJNXqH1huPpAIdtLr4ReZ35rWnA5NgSgFbj_KHXH4PAepIgsLWWG4d9aznvAuFKAdK-ne7-6tJ3Z9mjunshTFmbaZ2AAaFyu_gpczx9kpOf3G8stG60Xyypze143U43gD5RHqObcyZCVgZ-5ugwq9w.QfjJEmJJyZDOZFZN.tSaMhCkUEb0PcwvOVvFtUhqAkOl5VgciSdufaUANi0NUXuzk2KOPVkfYm6wnsLvN8Xn-7TwVWeIbEVg_NAMcEEnZRlP8QHKKSTmDxGk7K1VacYUCN2CaxwB3VJa83B6x1-y4zepCfs1ofD2pzFCG3PVdoMmg--P46iSAoSCOJGjvGLcQ7NaYrTRYmddyb1qpvgOCEeJu5OxAiVwyz7g0ZNqiB2YTtjVlVWE47eQ1xuf4-WjTut_PN_lWYk1Oa3d5v7ZrBg3rD-FmCcjBXV_R2Oh79Id7-tbGxdzrWO9E52p6fnSg4t5ojuOyDu5J9vSFvmXGWpe1rScmqKM8MkOExlv3UOkqgYB4zLAItSEjvDz4Mr9821NIhNBc1PnrqjJcgpuUv0VADzb3tMgf6CG3JWGhpsX1S7DgcsPIfY8sLnE9CgG5CnNr2ztajijabHYga0bjrwsgiXdv5L3k0DYUbj7ZTHLgHNVdZmiFTJrYjG5GEFmODbf2UBt-WV2Pb1-HRUpCXseYsmPIgtpc9ZeIfPQNtz3DRbTO1DfLJiao1wXPeMkfwKHewbHtoU8M_XxuV1WbubhqPeFO7EvjS1aHMTrT12Wy5zrCCHMaLEZJLDuYeXC1bsj7y0ehduam42TSmpm8_keqm7_0-1LB92SnQtlI0dvBvIM-FmNzq3MaoX6-T41FoueEA-Hnm579LdfzwBVC80RQqBcUra6J6jfjYdZOzKKW81PFcK1BcdmA1aYmGYKv-tIdCYHq0k_kjNO9ssMc5MwUKmJ6Raqo41Br2IDKISqKm6rAQ02gZwlOrBumWftE6pw2MgKo_bXEsPGrBEKxYdF8HV9P4nuI.bNA7ACciTnXlzYs-DUvMrw';
let accessToken = '';
// app.get('/oauth/redirect', (req, res) => {
//   console.log("in here");
//   console.log(req.query.code);

// })


const accessTokenOptions = {
  'method': 'POST',
  'url': 'https://dah2vb2cprod.b2clogin.com/914d88b1-3523-4bf6-9be4-1b96b4f6f919/oauth2/v2.0/token?p=B2C_1A_signup_signin_common',
  'headers': {
    'Content-Type': 'application/x-www-form-urlencoded'
  },
  form: {
    'grant_type': 'authorization_code',
    'client_id': clientId,
    'client_secret': clientSecret,
    'code': code,
    'redirect_uri': 'https%3A%2F%2Flocalhost%3A3000'
  }
};

const vehicleStatusOptions = {
  'method': 'POST',
  'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a/status',
  'headers': {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Application-Id': applicationId,
    'Authorization': 'Bearer null',
    'api-version': '2020-06-01',
    'callback-url': '{{callback-url}}'
  },
  formData: {

  }
};

const vehicleInfoOptions = {
  'method': 'GET',
  'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a',
  'headers': {
    'Application-Id': applicationId,
    'Authorization': 'Bearer null',
    'api-version': '2020-06-01'
  }
};

const vehicleLocationOptions = {
  'method': 'POST',
  'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a/location',
  'headers': {
    'Application-Id': applicationId,
    'Authorization': 'Bearer null',
    'api-version': '2020-06-01'
  }
};

const updateAccessToken = async () => {
  request(accessTokenOptions, function (error, response) {
    if (error) throw new Error(error);


    //get access token first
    accessToken = JSON.parse(response.body).access_token;
    console.log(accessToken);
  });
}

app.get('/refresh', (req, res) => {
  updateAccessToken();
  res.send(JSON.stringify("Success"));

})


app.get('/', (req, res) => {
  updateAccessToken();
  res.send(JSON.stringify("Getting token"));
  
  //res.sendFile(__dirname + '/oauth.html');
});

app.get('/vehicle_info', (req, mainRes) => {

  let vehicleInfo;
 //sending a post request for vehicle status as it is need for the get request to work
 request(vehicleStatusOptions, (error, response) => {
  console.log("sending vehicle status post req");
  if (error) {
    mainRes.send(JSON.stringify(Error(error).message));
    throw new Error(error);
  }
  console.table(response.statusMessage);

  //after sending post request, send get req for vehicl info
  request(vehicleInfoOptions, (error, res) => {
    if (error) throw new Error(error);
    console.table(res.body);
    vehicleInfo = res.body;
    mainRes.send(JSON.stringify(vehicleInfo));
  });

});

})

//this retrieves the location of the vehicle from the api and sends it to the frontend
app.get('/location', (req, res) => {
  let location;
  updateAccessToken();
  request(vehicleLocationOptions, (error, response) => {
    if (error) throw new Error(error);
    console.table(response.body);
    location = response.body;
  });

  res.send(JSON.stringify(location));
})

app.listen(3000, () => {
  console.log("Listening");
})