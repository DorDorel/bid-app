/* eslint-disable no-undef */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});


exports.createBidFlowRunner = functions.https.onCall(async (data, context) => {
  const tenantId = data.tenantId;
  const createdBy = data.createdBy;
  const date = data.date;
  const clientMail = data.clientMail;
  const clientName = data.clientName;
  const finalPrice = data.finalPrice;
  const selectedProduct = data.selectedProduct;

  // eslint-disable-next-line max-len
  const bidCollections = db.collection("companies").doc(tenantId).collection("bids");
  const bidInDB = await bidCollections.add({
    "createdBy": createdBy,
    "date": date,
    "clientMail": clientMail,
    "clientName": clientName,
    "finalPrice": finalPrice,
    "selectedProduct": selectedProduct,
  });

  console.log(bidInDB.id);
});


// exports.sendBidInEmail

exports.testConection = functions.https.onCall((data, context) => {
  return "Connection is OK";
});


