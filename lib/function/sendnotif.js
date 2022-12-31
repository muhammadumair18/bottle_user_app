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