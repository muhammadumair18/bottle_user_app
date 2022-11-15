var admin = require("firebase-admin");

var serviceAccount = require("G:/Android Projects/flutter folders/bottle_user_app/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var registrationtoken='ePyhQLo9TdyyuDXWDgP6vx:APA91bEP_B7Ltox0xEdOMiMTwGa7GPTu2xfFrPKP1sEyELO8W9pGJRqyEJSNp5ak0MnMZAr5rDp0MXbKE5sjJj0Yd0VFiyMBn7gAehwlMcZMsf9xwlwJMKv1bRqCe8ibcxAOAm8SDPd9';

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