const express = require("express");
const request = require("request");


const app = express();

const applicationId = 'afdc085b-377a-4351-b23e-5e1d35fb3700';
const clientId = '30990062-9618-40e1-a27b-7c6bcb23658a';
const clientSecret = 'T_Wk41dx2U9v22R5sQD4Z_E1u-l2B-jXHE';
const code =
  'eyJraWQiOiI2cjIzQ2FTeTF4cFdUUFBxYVRtX01Vc2RKZGo1RWlDTnRtME4yVTAxNTdFIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.MDMl4cW-N_lg0_kQrE8nfpCvELLQyuVE0SJ1ysVvvnnjFUZy_h1W1iMibzDeflgLlL-SbLeCfoyksSeaTiLWytQ7RJoXFflxB9G_d4d_neG-LHiXuV3vAwruioLmLzIKrFrP18Vn7UsKoR-iWg_ffcFmKeozPEtV12tNzoLXNQzCjvqzfjBwKYvGav8NKXYbslP2UuCurFM6RHkkhYWU-lRwfitNUCFJuNACwptAfadteTk1PeRsdeiQdNlHlXzks3wtBhQtJhSl70hI-kwh4D6BMj8Xbr17WdEJDgUm-wdzeoIpdDCT-SAqIxuYrNZyjMPBi7yKa-l7tEchJr2KBA.Vz95zDIta_2owpLo.VwTZa-VP08N9Nt78QjltKrRG4zBEU_wZJ3Jo3Z3TvZGB6fNbgVCNlm4rsRYDF5Gg7q9tTQPPRTiwuudizGJYdCsh-2mpq84tTjygoB3E1VONxcatS1TC5KYUmyrzyaXtXI0aa4y12r2Vk0r2krDGElQcMSpkN0EUshWYkBUdWAdVxkfOOsWsToknyl2PeKyeJgFkhRZZs8dm2RnSJOhWNHdyGER4Pr1SDQ14kvg7LzHelgoZQoZea-ZLloOAD5tdpUAKsaHp1wPNdaobP1xh1uB8N3mXc7t6NZFdC60ivlgWztAJ59UU0aVTODnxKmIXq8Pugi21NLqafnxIusRK3G2MY-ZcEKFnUg3DWlIcsdxHdjDmF5uNo6xmpLsKOjeAspH_18Gji6NaCr-lx1XbNRkNq_hs-E0HW0J1ejmk4AJXef6WWz4DzRf16qx_ysrj1zhvzexJAbpS48xJ_2thHQ3DKRSzyFgskVluRor2pOGnVOpZxE_rvKOa0bRgVSzzDhrDatlHXLM3DiwNVgjIV4JKeMRRNciUchk1vMG9YMsiBWbi0lFJl5wI5rsdt29LkMRSmvtbLvsm-MUqLAKcf7v17CaYVy5KHPKnPNK5U-uK4e-tiGag6UmhJlMhKWsMPE8VLwpEw_w1uHgQ0Z9SGuZNw6El6rnQ2JidFa7yBeCl6JszndREA50ytoNabB44ORcj1mwoeMzbUVD8zbcDT5JVLgBIvGSnSB049-kfPeP6-ZK_0DRR8Ui9QMzW-jwIFbRY8WPPpRgLXqxFJjunCsQYPbTqJY3sXmeVTZWOVbJWxj4TNAjrHN10_qGRUsfr4d6iJGk0xZE.e_cjYXmbbSzPty82QS82PQ';
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
    formData: {

    }
  };
};

const refreshTokenOption = () => {
  return {
    'method': 'POST',
    'url': 'https://dah2vb2cprod.b2clogin.com/914d88b1-3523-4bf6-9be4-1b96b4f6f919/oauth2/v2.0/token?p=B2C_1A_signup_signin_common',
    'headers': {
    },
    formData: {
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
    accessToken = obj.access_token;
    refreshToken = obj.refresh_token;
    console.log(accessToken);
    console.log("refresh token: " + refreshToken);

  });
  return accessToken;
}

const updateRefreshToken = () => {
  console.log("updating tokens");
  request(refreshTokenOption(), (err, response) => {
    if (error) {
      console.log("Error occured(123):" + error);
      throw new Error(error);

    }
    else {
      console.log("getting tokens from body");
      const obj = JSON.parse(response.body);
      if (obj.access_token != null) {
        accessToken = obj.access_token;
        refreshToken = obj.refresh_token;

        console.log("new tokens are:" + accessToken + " and " + refreshToken);
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

  setInterval(updateRefreshToken(), 120000);
})