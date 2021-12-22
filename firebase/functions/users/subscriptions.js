import admin from "firebase-admin";
import axios from "axios";
import functions from "firebase-functions";

export default functions
  .region("europe-west1")
  .https.onRequest(async (req, res) => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }
    if (
      req.headers.authorization !==
      "Bearer " + functions.config().revenuecat.webhook.token
    ) {
      return res.status(401).send("Unauthorized");
    }
    if (req.body?.event?.type === "TEST") {
      return res.status(200).send("success");
    }
    const appUserId = req.body?.event?.app_user_id;
    if (appUserId === undefined) {
      return res.status(400).send("Bad Request");
    }
    try {
      await updateSubscription(appUserId);
      return res.status(200).send("success");
    } catch (error) {
      console.error(`Updating subscription error: ${error}`);
      return res.status(500).send("Internal Server Error");
    }
  });

async function updateSubscription(userId) {
  const config = {
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      Authorization: "Bearer " + functions.config().revenuecat.secret,
    },
  };

  const { data } = await axios.get(
    `https://api.revenuecat.com/v1/subscribers/${userId}`,
    config,
  );

  const entitlement = data?.subscriber?.entitlements?.pro_entitlement;
  let hasSubscription = false;

  if (entitlement !== undefined) {
    hasSubscription = Date.parse(entitlement.expires_date) > Date.now();
  }

  const dataToUpdate = {
    limit: hasSubscription ? 5000 : 100,
    subscription: hasSubscription ? "pro" : admin.firestore.FieldValue.delete(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  return admin.firestore().collection("users").doc(userId).update(dataToUpdate);
}
