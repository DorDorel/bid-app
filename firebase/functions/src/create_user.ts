import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const db = admin.firestore();


// Callable funciton to create a user 
exports.createUser = functions.https.onCall(async (data, context) => {

    var firebaseError = "";
    console.log("function was called by user with id  : " + context.auth?.uid || null); 
    if (!data.email || !data.password) return { "status": "failure", "message": "email or password not provided" }
    const email = data.email;
    const password = data.password;
    //craete user using firebase auth
    const firebaseUser = await admin.auth().createUser({ email: email, password: password }).catch((err) => {
        console.log("Firebase user creation error " + err);
        firebaseError = err;
    });
    if (firebaseUser) {
        //if user is created, save it to Users collection for custom user
        await db
            .collection("Users")
            .doc(firebaseUser.uid)
            .set(
                {
                    uid: firebaseUser.uid,
                    email: data.email,
                    Name: data.name,
                    isAdmin: data.isAdmin,
                    tenantId: data.tenantId
                },
                { merge: true }
            )
            .then(() => {
                console.log("User Created");
                return {
                    "status": "success",
                    "uid": firebaseUser.uid
                };
            })
            .catch((err) => {
                console.log("Error Creating user : " + err);
                return {
                    "status": "failure",
                    "message": "User Creation Error"
                };
            });
    }
    else return { "status": "failure", "message": "User Creation Error : " + firebaseError };
    return {
        "status": "success",
        "uid": firebaseUser.uid
    };

});

module.exports.createUser = exports.createUser;

