const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { MEMORY_TYPE } = require("../models/memoryType");

exports.thumbnail = functions
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
  const admin = require("firebase-admin");
  const puppeteer = require("puppeteer");
  const { v1: uuidv1 } = require("uuid");

  const path = ref.path + "/thumbnail-" + uuidv1() + ".png";

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.setViewport({
    width: 1280,
    height: 800,
  });

  await page.goto(url);
  const result = await page.screenshot();

  await browser.close();

  const bucket = admin.storage().bucket();
  const file = bucket.file(path);
  await file.save(result);

  return {
    thumbnail: "gs://" + admin.app().options.storageBucket + "/" + path,
  };
}
