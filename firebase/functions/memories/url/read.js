import axios from "axios";
import functions from "firebase-functions";

export default async function (url) {
    const apiKey = functions.config().scrapingrobot.apikey;
  
    try {
      const { data } = await axios.post(
        "https://api.scrapingrobot.com",
        scrapingRobotConfig(url),
        {
          headers: { "Content-Type": "application/json" },
          params: { token: apiKey },
          maxContentLength: 1024 * 1024 * 10,
        },
      );
      if (data.status === "SUCCESS") {
        return data.result;
      } else {
        throw new Error(data.error);
      }
    } catch (error) {
      const errorText = error ?? "unavailable";
      console.error(`Scraping Robot error: ${errorText}`);
      return defaultHTML(errorText);
    }
  }
  
  function scrapingRobotConfig(url) {
    return {
      url,
      render: true,
      waitUntil: "networkiddle2",
      noImages: false,
      noFonts: false,
      noCss: false,
    };
  }
  
  function defaultHTML(message) {
    return `
      <!doctype html>
      <html lang="en">
          <head>
              <meta charset="utf-8">
              <title>${message}</title>
              <meta property="og:title" content="${message}" />
              <meta property="og:image" content="https://brain3k.com/assets/error.png" />
          </head>
          <body>
          <h1>${message}</h1>
          </body>
      </html>
      `;
  }
  