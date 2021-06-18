import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import { auth } from "firebase-admin";
admin.initializeApp();
const db = admin.firestore();


const createUserFile = require("./create_user");
exports.createUser = createUserFile.createUser;


exports.testConection = functions.https.onCall((data, context)=> {
  return ["this", "is", "a ", "test", 100];
});

exports.setNewUserTenantId = functions.https.onCall((data,context)=>{
  const uid = data.uid;
  const firestoreUser = db.collection("users").doc(uid);
  




});









