const express = require("express");
const request = require("request");


const app = express();

const applicationId = 'afdc085b-377a-4351-b23e-5e1d35fb3700';
const clientId = '30990062-9618-40e1-a27b-7c6bcb23658a';
const clientSecret = 'T_Wk41dx2U9v22R5sQD4Z_E1u-l2B-jXHE';
const code =
'eyJraWQiOiI2cjIzQ2FTeTF4cFdUUFBxYVRtX01Vc2RKZGo1RWlDTnRtME4yVTAxNTdFIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.husvtvk4VRe3EO1et5qvBs3ShDsofw84PO8LMgBWMYW2OKDtrr5O2B8MGixrWSYb47h5mBaCceT4oYK72r6myRiZN_HnCpZ1AXsg2-m77ksNdOBsmCSBIyKCGHKbFoYhzEzqYnuee-stNINtLFJg1nfI0RQGUn6fgUkMApFidkosO5Nxgkb9F5xCZtA2cLtFLTMlTrcqRhUGmwGysLVq5nZWfRv7bOapNHv5yu7W7A0mGLtJzfLKBt9HhOvNUNBjGSHeHoLjoSFrWifQhmHZ7rGUVYYd4rxTAZ22GP24wCTDqnhY0llMJ0IkJVoX7NyRa0mvb3huC4Lc4aW-RMxEXg.B2fCHnrhhQPl-Wc6.u1nR2TIFiUe0ws-RImD7bxu0zUX2mQdc5LXApnu7i1mwtBSWpWyeYqZhUf0gAOcLixUZLKtzy5dmkBmYN-ZlPpQjvtOxA_zdK7fcqoHinqsaYWOdc7xRIX23i4MpBPMrqDLNzZIEX4fUwJzISEokmB7MmZL8-MJHuL3zJG9HOQqfGyArgkFMKv1Dy_G4eRw191D51vpuX0yTAHN13242l9iKI6JHINLHi7Sl9VmnO090BqDzlRYh6iMM5qT4uwBbFQYAFruCl-3AZUZMJbsLQxE-rdNMcz9apruS0_G8ADTEzsNKBNt9iaN7T0OxH0oRos1DieHR5P-INaeNbJ5VxoHYPmqA_d-1-XqF9I1yHdY2FEKFkW0w9e_g8wVOYdwy3Tef4GlJ4Q9wFsTUlILAeEtW_9Phdq5JPtjTeqvLPkxpWMJD1owv8A63O-qM6h42Cj5kyVxPXAehwbv3Vf3flIOq42u8b58ZpDw4Y4pTntRYvIWrIbp6gCcqcNS1rm1eBtxEvm7m0QXh6hHe6kphrz7geV24JexsRxmq7IO2spD_zDYpL4Brh9eAv7Yjh2WGBDoxtGXEGQ2aNkstJf_N0a9XUR_BoDQR2mG_e-_fdf_EaHiw9V5NA499sZiEqUBKfPsRYB3nYTH578orbRhazezlWLQcSEUBi8UDTNC9jwXuHb51cXSLSQeGJeXAjhL2lzqqk24ONFbzGg9ZMQMTfbxpI2He5xu0cd_y-qxjPiP2Eve4YCrMFpr7WAGgKF6tfj1z7H_WGd0Wob-M_L4Y4gDGY03dujCQn6JYXpCI9L8QvQFWldLKprArQH4nMwEL8rR_MqV5k_g7SnYolg.WHGkNcCLIrHoAon7k4cXAw';
var accessToken;
var refreshToken;
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

const vehicleStatusOptions = () => {
  return {
    'method': 'POST',
    'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a/status',
    'headers': {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Application-Id': applicationId,
      'Authorization': 'Bearer ' + accessToken,
      'api-version': '2020-06-01',
      'callback-url': '{{callback-url}}'
    },
    form: {

    }
  };
};

const refreshTokenOption = () => {
  return {
    'method': 'POST',
    'url': 'https://dah2vb2cprod.b2clogin.com/914d88b1-3523-4bf6-9be4-1b96b4f6f919/oauth2/v2.0/token?p=B2C_1A_signup_signin_common',
    'headers': {
    },
    form: {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': clientId,
      'client_secret': clientSecret
    }
  };
}
const vehicleInfoOptions = () => {
  return {
    'method': 'GET',
    'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a',
    'headers': {
      'Application-Id': applicationId,
      'Authorization': 'Bearer ' + accessToken,
      'api-version': '2020-06-01'
    }
  };
}

const vehicleLocationPostOptions = () => {
  return {
    'method': 'POST',
    'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a/location',
    'headers': {
      'Application-Id': applicationId,
      'Authorization': 'Bearer ' + accessToken,
      'api-version': '2020-06-01'
    }
  };
}

const vehicleLocationGetOptions = () => {
  return {
    'method': 'GET',
    'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a/location',
    'headers': {
      'Application-Id': applicationId,
      'Authorization': 'Bearer ' + accessToken,
      'api-version': '2020-06-01'
    }
  };
}

const getAccessToken = () => {
  request(accessTokenOptions, function (error, response) {
    if (error) throw new Error(error);


    //get access token first
    obj = JSON.parse(response.body);
    console.log("First time token:");
    console.table(obj);

    accessToken = obj.access_token;
    refreshToken = obj.refresh_token;
    console.log(accessToken);
    console.log("refresh token: " + refreshToken);
    setInterval(updateRefreshToken, 120000);
  });
  return accessToken;
}

const updateRefreshToken = () => {
  console.log("updating tokens");
  request(refreshTokenOption(), (err, response) => {
    console.log("request refresh token");
    if (err) {
      console.log("Error occured(123):" + err);
      throw new Error(err);

    }
    else {
      console.log("getting tokens from body");
      const obj = JSON.parse(response.body);
      console.table(obj);
      if (obj.access_token != null) {
        accessToken = obj.access_token;
        refreshToken = obj.refresh_token;

        console.log("new tokens are:" + accessToken + "\n and " + refreshToken);
      }


    }
  })
}

app.get('/refresh', async (req, res) => {
  updateRefreshToken();
  console.log("Updated tokens");
});



app.get('/', async (req, res) => {

 // updateRefreshToken();

  //res.sendFile(__dirname + '/oauth.html');
});

app.get('/vehicle_info', (req, mainRes) => {

  console.table(vehicleInfoOptions);
  request(vehicleInfoOptions(), (error, res) => {
    if (error) {
      console.log("error here" + error);
      throw new Error(error);
    }

    console.table(res.statusMessage);
    vehicleInfo = res.body;
    mainRes.send(JSON.stringify(vehicleInfo));
  });

});


//this retrieves the location of the vehicle from the api and sends it to the frontend
app.get('/location', (req, res) => {
  let location;
  updateAccessToken();
  request(vehicleLocationPostOptions(), (error, response) => {
    if (error) throw new Error(error);
    console.table(response.body);

    request(vehicleLocationGetOptions(), (err, thirdRes) => {
      location = thirdRes.body;
      res.send(JSON.stringify(location))
    })
      ;
  });


})

app.listen(3000, () => {
  console.log("Listening");
  getAccessToken();

 
})