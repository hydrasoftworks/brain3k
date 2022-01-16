import { MEMORY_TYPE } from "../../models/memoryType.js";
import admin from "firebase-admin";
import functions from "firebase-functions";
import getMetadata from "./metadata.js";
import getNeurons from "./neurons.js";
import getThumbnail from "./thumbnail.js";
import readHTMLFromURL from "./read.js";
import readSummaryFromURL from "./summary.js";

export default functions
  .runWith({ timeoutSeconds: 540, memory: "2GB" })
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onWrite(async ({ after }) => {
    if (!after.exists) return;

    let data = after.data();
    if (data.type !== MEMORY_TYPE.url || data.processed === true) return;

    const url = data.value;
    let [html, summary] = await Promise.all([
      readHTMLFromURL(url),
      readSummaryFromURL(url),
    ]);
    const metadata = await getMetadata(url, html);
    const neurons = await getNeurons(html);

    let thumbnail = {};
    if (metadata.thumbnail === undefined) {
      thumbnail = await getThumbnail(after.ref, url, html);
    }

    data = {
      ...data,
      ...metadata,
      ...neurons,
      ...summary, // Smmry neurons overwrite local ones
      ...thumbnail,
    };

    await after.ref.update({
      ...data,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      processed: true,
    });
  });
