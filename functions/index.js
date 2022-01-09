/* eslint-disable max-len */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

const cors = require("cors")({ origin: true });
admin.initializeApp();
const db = admin.firestore();

// dev functions

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

exports.testConnection = functions.https.onCall((data, context) => {
  return "Connection is OK";
});

// functions

//  exports.sendBidInEmail = functions.https

exports.getCurrentBidData = functions.https.onRequest(async (req, res) => {
  const tenant = req.query.tenant;
  const bidId = req.query.bid;
  const creator = req.query.creator;

  const bidDocRef = await db
    .collection("companies")
    .doc(tenant)
    .collection("bids")
    .doc(bidId)
    .get();
  const tenantInfo = await db.collection("companies").doc(tenant).get();
  const creatorDocRef = await db
    .collection("companies")
    .doc(tenant)
    .collection("users")
    .doc(creator)
    .get();
  cors(req, res, () => {
    if (req.method !== "POST") {
      return res.status(500).send("<h1> Your access has been denied</h1> ");
    }

    res.status(200).json({
      // fullBidData: bidDocRef,
      // fullTenantDetails: tenantDetails,

      companyName: tenantInfo["_fieldsProto"]["companyName"]["stringValue"],
      companyAddress:
        tenantInfo["_fieldsProto"]["companyAddress"]["stringValue"],
      companyMail: tenantInfo["_fieldsProto"]["companyMail"]["stringValue"],
      companyWebsite:
        tenantInfo["_fieldsProto"]["companyWebsite"]["stringValue"],
      companyLogo: tenantInfo["_fieldsProto"]["logoImageUrl"]["stringValue"],
      // userLimit: tenantInfo["_fieldsProto"]["usersLimit"]["integerValue"],
      companyPhone: tenantInfo["_fieldsProto"]["companyPhone"]["stringValue"],
      bidId: bidDocRef["_fieldsProto"]["bidId"]["stringValue"],
      createdBy: bidDocRef["_fieldsProto"]["createdBy"]["stringValue"],
      clientMail: bidDocRef["_fieldsProto"]["clientMail"]["stringValue"],
      clientName: bidDocRef["_fieldsProto"]["clientName"]["stringValue"],
      finalPrice: bidDocRef["_fieldsProto"]["finalPrice"]["doubleValue"],
      dateCreated: bidDocRef["_fieldsProto"]["date"]["timestampValue"],
      selectedProduct:
        bidDocRef["_fieldsProto"]["selectedProducts"]["arrayValue"],
      creatorName: creatorDocRef["_fieldsProto"]["name"]["stringValue"],
      creatorPhone: creatorDocRef["_fieldsProto"]["phoneNumber"]["stringValue"],
      creatorMail: creatorDocRef["_fieldsProto"]["email"]["stringValue"],
    });
  });
});
