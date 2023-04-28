var admin = require("firebase-admin");

var serviceAccount = require("G:/Android Projects/flutter folders/bottle_user_app/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var registrationtoken='ejYYWxNmRPCBPr2D0yEjcN:APA91bEuueI0khJ1YI99pd_IdM_vOeRz6FQ_taouNW49g0raY638z58mdCVeeA8mtb7o_IssdXNI_USre5Q4VO9ldyyJERyXVUHw7I71TvM9kIRfTSRYDmSp00uUNHOuPUe8qmmd06HB';

var message = {
  notification:{
      title: "Portugal vs. Denmark",
      body: "great match!"
      },
  data: {
    type: "warning",
    content: "A new weather warning has been created!",
    route: 'red'
  },
  token:registrationtoken
};

admin
  .messaging()
  .send(message)
  .then((response) => {
    console.log("Successfully sent message:", response);
  })
  .catch((error) => {
    console.log("Error sending message:", error);
  });




//
//install node
//create function folder create js file in the folder and install npm in the function folder(by opening terminal in specific function folder)
//then run command(npm install --save firebase-admin) in the function folder
//Then write the following code in the js file
//
//var registrationtoken="";
//var message = {
//  notification:{
//      title: "title",
//      body: "body"
//      },
//  data: {
//    type: "warning",
//    content: "A new weather warning has been created!",
//    route: 'red'
//  },
//  token:registrationtoken
//};
//admin.messaging().send(message).then((response) => {console.log("Successfully sent message:", response);
//  }).catch((error) => {console.log("Error sending message:", error);});
//
//In Service account tab of firebase project settings copy the below code given there and paste it top of js file
//Also also create private key and paste the file in your project
//and give the path of that key file in js file serviceAccount variable
