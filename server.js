
/* functions of the server,
1. Take login credentials and return user object,
2. Take in api credentials and authorize access
3. Once login anf access is granted, return vehicle info object
4. Send request for locking, unlocking, reporting and notifying driver
5. log out/invaliddate session
*/


const https = require('https');
const express = require("express")
const request = require("request");


const app = express();

app.get('/', () =>{

})

//code for getting the access_token from ford
app.get("/get_token", (req, res) => {

  var options = {
    'method': 'POST',
      'url': 'https://dah2vb2cprod.b2clogin.com/914d88b1-3523-4bf6-9be4-1b96b4f6f919/oauth2/v2.0/token?p=B2C_1A_signup_signin_common',
      'headers': {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      form: {
    'grant_type': 'authorization_code',
    'client_id': '30990062-9618-40e1-a27b-7c6bcb23658a',
    'client_secret': 'T_Wk41dx2U9v22R5sQD4Z_E1u-l2B-jXHE',
    'code': 'eyJraWQiOiI2cjIzQ2FTeTF4cFdUUFBxYVRtX01Vc2RKZGo1RWlDTnRtME4yVTAxNTdFIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.HZJfhdrvkwjacTmQvsHCDUUSDLy2qSQCjFoTROvX-EmiUAHSmINeewanoz3IWGbpPGfRQkbkaL0L1C5V_a0HRgaFoYOXWTAsChuMSmIZqzFbuSvbPJJRKJjLLKRcILS814xjLOsq401QBOHtvG75RSRmFLui0hXFgXNYC9-kWQ8Cua0xJIvUUzNdjpgx5mp9gDyNBB6B-sERatEBnN6Hv44slKqRkyE8P_Z5vaf8NTVTAgQba-R_6GzZGUalf-O84QbrHLPPHP9mMjePp-tG0KjIWg7xtsDBetWjx78OlOqu6X7vfpuYBweITP4v-IXRzIZQtQ1vLBIuyGzTud1X6g.yquJYJ_yp0z-B_Dy.IX31Y0oSNCvh-GJJnZhi0ZF-Nl3dH3WW0S4G1sqCiXetbIpq3SLovaj971q1JoCbfbyaPFzculpsXngNIKdiuHF8fFiGCM_WG9Fcseaa4XEopkgqxvCNjsd2f-LnUzruKKfICDBMMHoAaeC1u1i9Az7OgPm1IiSuf5iSyrkpbwisAFGglQmL13HJoZWGx350QoONy4rMMIG6ivaTvEUvWn9MeyFLsF9mV_MRRXxAVPBpZqC6XM4coEe4OGxz5tB9p9KvZk8q7a9Vdx_awPXLhUok_JBnh3dpzLuTJsP9JzoA5OahRfibmNBveiY_wP3I8EXgrd7D2w4MEZ_mSfnYvrHC555jy1v3v34oMk_HMyRdwT6L0Wy8CIKsPCPsDEpr75KX0kOin7-QTgza-kCK3byQcEPsOwoMYKB_kod5-Tgr41LsazTs6lB0FU3K1PZFd0uClusRa5j2TA5t7KhWtvGu-hK03jkfikYJsq-pAgiXQydrVqHk5CRlIMLZ8C4lNvQ9ObT4RZCBTvA3fmAxrgxHCrWZcYYImr0gvV_1fznPjyZfkk7qMmYe1siOBYCgwK-125EsPTW4lbBc70IGPpUumeOu9iMwTY2EYdscBcMPhCnn-8eOxWQ7n9E1kTZo1bQGS3qUG1qTeQ7Q-a0cgcjYbriR6YnNI_e2PgfcfV-i-_gTxwXiPsJ7R2nNFlXhfPIYa5Fj27YxtBIOPTssReL_FuRnflT6mnAVrdz4YCbUuOBCYWfwCVRTLA0ePKVNtkXlFu9IKlT6HIC7IipEA8kb4Z8_FFUq-c3WmeXeIneiOMgoFU5ayV9pj4Q7ALTjwWdHr4Pf1xpJ5Q.-CHCvIEF2gxx7ZpBC3pGEA',
    'redirect_uri': 'https%3A%2F%2Flocalhost%3A3000'
  }
};

let body;
request(options, (error, response)=> {
  if(error) console.log(error);
  body = response.body;
  res.send(body);
})



})



app.listen(3000,()=> {
    console.log("listening on port 3000");
})
