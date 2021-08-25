/* eslint-disable max-len */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

// dev functions

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

exports.testConection = functions.https.onCall((data, context) => {
  return "Connection is OK";
});

// functions

exports.getCurrentBidData = functions.https.onRequest(async (req, res)=>{
  if (req.method !== "POST") {
    return res.status(500).send("<h1> Your access has been denied</h1> ");
  }
  const tenant = req.query.tenant;
  const bidId = req.query.bid;

  const bidDocRef = await db.collection("companies").doc(tenant).collection("bids").doc(bidId).get();
  const tenantInfo = await db.collection("companies").doc(tenant).get();
  res.status(200).json({
    // fullBidData: bidDocRef,
    // fullTenantDetals: tenantDeatls,
    tenantInfo: {companyName: tenantInfo["_fieldsProto"]["companyName"]["stringValue"],
      companyAddress: tenantInfo["_fieldsProto"]["companyAddress"]["stringValue"],
      companyMail: tenantInfo["_fieldsProto"]["companyMail"]["stringValue"],
      companyWebsite: tenantInfo["_fieldsProto"]["companyWebsite"]["stringValue"],
      companyLogo: tenantInfo["_fieldsProto"]["logoImageUrl"]["stringValue"],
      userLimet: tenantInfo["_fieldsProto"]["usersLimit"]["integerValue"],
      companyPhone: tenantInfo["_fieldsProto"]["companyPhone"]["stringValue"],
    },

    bidDetails: {bidId: bidDocRef["_fieldsProto"]["bidId"]["stringValue"],
      createdBy: bidDocRef["_fieldsProto"]["createdBy"]["stringValue"],
      clientMail: bidDocRef["_fieldsProto"]["clientMail"]["stringValue"],
      clientName: bidDocRef["_fieldsProto"]["clientName"]["stringValue"],
      finalPrice: bidDocRef["_fieldsProto"]["finalPrice"]["doubleValue"],
      dateCreated: bidDocRef["_fieldsProto"]["date"]["timestampValue"],
      selectedProduct: bidDocRef["_fieldsProto"]["selectedProducts"]["arrayValue"]},
  });
});
