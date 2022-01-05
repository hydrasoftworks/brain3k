import admin from "firebase-admin";
import puppeteer from "puppeteer";
import { v1 } from "uuid";

export default async function (ref, url, html) {
  try {
    const path = ref.path + "/thumbnail-" + v1() + ".png";
    const result = await takeThumbnail(url, html);
    await saveThumbnail(path, result);

    return JSON.parse(
      JSON.stringify({
        thumbnail: "gs://" + admin.app().options.storageBucket + "/" + path,
      }),
    );
  } catch (error) {
    console.error(`Taking screenshot error: ${error}`);
    return {};
  }
}

async function takeThumbnail(url, html) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.setViewport({
    width: 1280,
    height: 800,
  });

  await page.goto(url);
  await page.setContent(html, { waitUntil: "networkidle2" });
  const result = await page.screenshot();

  await browser.close();
  return result;
}

async function saveThumbnail(path, result) {
  const bucket = admin.storage().bucket();
  const file = bucket.file(path);
  await file.save(result);
}
