import functions from "firebase-functions";
import admin from "firebase-admin";
import { MEMORY_TYPE } from "../models/memoryType.js";
import puppeteer from "puppeteer";
import { v1 } from "uuid";

export default functions
  .runWith({ timeoutSeconds: 540, memory: "2GB" })
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onUpdate(async ({ after }) => {
    let data = after.data();

    if (data.processed !== true || data.thumbnail !== undefined) return;

    switch (data.type) {
      case MEMORY_TYPE.url: {
        const result = await makeThumbnailForURL(after.ref, data.value);
        data = { ...data, ...result };
        break;
      }
      default:
        break;
    }

    await after.ref.update({
      ...data,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

async function makeThumbnailForURL(ref, url) {
  const path = ref.path + "/thumbnail-" + v1() + ".png";

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.setViewport({
    width: 1280,
    height: 800,
  });

  await page.goto(url, { waitUntil: "networkidle2" });
  const result = await page.screenshot();

  await browser.close();

  const bucket = admin.storage().bucket();
  const file = bucket.file(path);
  await file.save(result);

  return {
    thumbnail: "gs://" + admin.app().options.storageBucket + "/" + path,
  };
}
