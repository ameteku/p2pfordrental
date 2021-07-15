const express = require("express");
const request = require("request");


const app = express();

const applicationId = "afdc085b-377a-4351-b23e-5e1d35fb3700";
const clientId = '30990062-9618-40e1-a27b-7c6bcb23658a';
const clientSecret = 'T_Wk41dx2U9v22R5sQD4Z_E1u-l2B-jXHE';
const code = 'eyJraWQiOiI2cjIzQ2FTeTF4cFdUUFBxYVRtX01Vc2RKZGo1RWlDTnRtME4yVTAxNTdFIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.AuVaDZOmWNPVxIzVhoMjxuohY2fk57XDt3aV7J77ucRec7foeJ5b0LpD4tkYK3idg_I1rbVmTYVwZUc4ErbGT2rw4o4tk0ojsXJfLcXlG2jzh1KFBELLrisVWub7d7Q0fXconYv4lQasblE8USMWHXXep0evaKzVV5gJn0ObusFem8xTN0hOK7NdbhC18izkHUvHe931590N24RomSLym3-IQFPQBc3moGHDp4_CxjfwhLb-BdgoVVS3fsvOmBvV8BpXg0fqi3kXW9MXXo0JCHoPWREJmilVcySh7Qczql_ITVJK1AOjKRjrLVoAkSCgIyJ_8lkcliUCPOGe5itjZw.Gai5ATNWQa2q0HmI.u62AVkXnwPRFhh6ZW2YUBiAdB-Vsp6NpdVKBX3eS_ivazxILU_fqwetsNHxAXGKOhaYacHkgcVjezckCncem8OobcSa-cd1O43nYYY2RurD_JwGxtr_JD2fWk11_VxV0aK05IdBa-e8HcJdt-_sXotETyMvBrCSpVdunRpdgkMCByTteVzy0zzXehmHeXWND5x-K9bEqGJG6pDRPfQYE2_9kj1c1g6J9gHcg2m_7d9oQ6Tj2hmnu_eNIbZwPihKnZEo2d8YhxPETLrC9h-fQmL0RxTquQpX7yX_vxgbRw8SriyttunlO_fnJs_OZYS3JXmy3JYXle2g7w2R02AVm1wqhx5gLU4EFLyXLxblV9bMo6HeMJmLnTDm51wjWHUrrm_6eP1bAGd7RDKA_tmaQJibxBb9WWQ2kVvBvolReRT5n6R5ed3GVWCvoM20AyT1wwYAxLLUeyW2gdxbTaCL8Wge6I_VwYIMXc4rYQozXM4_D0QWDXAcivmaiL8NonW5zSWFAEjmcSCPxPJ4sutBtHFzKYVYOnEPDL8pfgbP9OSTsHdeJF2Xvz9gIdHSz1U-c_dCR-7NQ5y-FSybrAmoW6LknG2JZtPmVr1WcikxrC9nR-44xDbbgJ6B72s_hkRPpfLFvl9ocWGPGbJ-mhNouS7-umvaLE7ON3ao215KkY49roHEcYAXQgSDZHx9-6u4a3v51TXSoBr-CzxYVnHSZUZ8-I6K4q4hJZRV3R53Zb17CQ1Aj4g0AWKVcrM-kA-HnA5tJyog6YbKTwT1-VqtLVbW8OoW_DkFPghxgkL7ifOo8f4EtSZn6OY1sDpjE8DQ19txVLQGDvd2O.C2U1NwtVUcwtaCNDoP_wsg';
let accessToken = '';
// app.get('/oauth/redirect', (req, res) => {
//   console.log("in here");
//   console.log(req.query.code);

// })


const accessTokenOptions =  {
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

const vehicleStatusOptions =  {
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

const vehicleLocationOptions =  {
  'method': 'POST',
  'url': 'https://api.mps.ford.com/api/fordconnect/vehicles/v1/8a7f9fa878849d8a0179579d2f26043a/location',
  'headers': {
    'Application-Id': applicationId,
    'Authorization': 'Bearer null',
    'api-version': '2020-06-01'
  }
};

const updateAccessToken = () => {
  request(accessTokenOptions, function (error, response) {
    if (error) throw new Error(error);
    console.table(response.body);

    //get access token first
    accessToken = response.body.accessToken;
});
}


app.get('/', (req, res) => {
res.sendFile(__dirname  +'/oauth.html');
});

app.get('/vehicle_info', (req, res) => {
  
  let vehicleInfo;

  updateAccessToken();

   //sending a post request for vehicle status as it is need for the get request to work
   request(vehicleStatusOptions, (error, response) => {
    if (error) throw new Error(error);
    console.table(response.body);

    //after sending post request, send get req for vehicl info
    request(vehicleInfoOptions, (error, res) => {
      if (error) throw new Error(error);
      console.table(res.body);
      vehicleInfo = res.body;
    });
 
    
  });

  res.send(JSON.stringify(vehicleInfo));
} )

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

app.listen(3000, () =>{
console.log("Listening");
})