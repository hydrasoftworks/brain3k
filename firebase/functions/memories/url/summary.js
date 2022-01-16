import axios from "axios";
import functions from "firebase-functions";

export default async function (url) {
  try {
    const { data } = await axios.get("https://api.smmry.com", {
      headers: { "Content-Type": "application/json" },
      params: smmryParameters(url),
      maxContentLength: 1024 * 1024 * 10,
    });
    if (data.sm_api_content !== undefined) {
      return JSON.parse(
        JSON.stringify({
          summary: data.sm_api_content.replace(/\[BREAK\]/g, "\\n"),
          neurons: data.sm_api_keyword_array,
          title: data.sm_api_title.length === 0 ? undefined : data.sm_api_title,
        }),
      );
    } else {
      throw new Error(data.sm_api_message);
    }
  } catch (error) {
    const errorText = error ?? "unavailable";
    console.error(`Smmry error: ${errorText}`);
    return {};
  }
}

function smmryParameters(url) {
  const apiKey = functions.config().smmry.apikey;

  return {
    SM_API_KEY: apiKey,
    SM_LENGTH: 7,
    SM_KEYWORD_COUNT: 20,
    SM_WITH_BREAK: true,
    SM_URL: url,
  };
}
