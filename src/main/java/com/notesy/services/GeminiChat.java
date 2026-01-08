package com.notesy.services;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.json.*;

public class GeminiChat {

    // 🔹 Put your API Key here
    private static final String API_KEY = "AIzaSyCrW0o2hbOwffKzEk1hJovYsjDfhlzjjsc";

    private static final String ENDPOINT =
        "https://generativelanguage.googleapis.com/v1/models/"
      + "gemini-2.5-flash-lite:generateContent?key=" + API_KEY;


    public static String ask(String userMessage, String context) {


        try {

            // ============================================
            // 🔹 1) BASIC TOPIC FILTER (server-side guard)
            // ============================================
            String q = userMessage.toLowerCase();

            boolean isRelated =
                    q.contains("note") || q.contains("upload") || q.contains("buy") ||
                    q.contains("purchase") || q.contains("download") ||
                    q.contains("payment") || q.contains("cart") ||
                    q.contains("profile") || q.contains("account") ||
                    q.contains("login") || q.contains("register");

            if (!isRelated) {
                return "Sorry — I can only help with the Notesy website 😊";
            }


            // ============================================
            // 🔹 2) OPEN CONNECTION
            // ============================================
            URL url = new URL(ENDPOINT);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();

            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);


            // ============================================
            // 🔹 3) WEBSITE-ONLY SYSTEM INSTRUCTION + CONTEXT
            //    (THIS is the part that restricts answers)
            // ============================================
            JsonObject reqBody = Json.createObjectBuilder()
                .add("contents", Json.createArrayBuilder()
                    .add(Json.createObjectBuilder()
                        .add("parts", Json.createArrayBuilder()
                            .add(Json.createObjectBuilder()
                                .add("text",
                                    "You are Notesy Help Bot. Only answer questions "
                                  + "related to the Notesy website — notes, uploading, "
                                  + "buying, payments, cart, downloads, and accounts. "
                                  + "If the question is unrelated, reply exactly with: "
                                  + "\"Sorry, I can only help with the Notesy website.\""
                                  + "\n\n"
                                  + "Website context: Notesy is a student note-sharing "
                                  + "platform where users upload, purchase, and download "
                                  + "study notes. Payments are simulation only."
                                  + "ONLY recommend notes that exist in the list below.\n"
                                  + "If no suitable note exists, say politely that no matching notes are available.\n\n"
                                  + context
                                  + "\n\nUser: " + userMessage
                                )))))
                .build();


            // ============================================
            // 🔹 4) SEND REQUEST
            // ============================================
            try (OutputStream os = con.getOutputStream();
                 JsonWriter writer = Json.createWriter(os)) {
                writer.writeObject(reqBody);
            }


            // ============================================
            // 🔹 5) READ RESPONSE
            // ============================================
            InputStream is = (con.getResponseCode() == 200)
                    ? con.getInputStream()
                    : con.getErrorStream();

            JsonReader reader = Json.createReader(is);
            JsonObject json = reader.readObject();

            System.out.println("Gemini API Response = " + json); // DEBUG


            // -------- Safe Parsing --------
            if (json.containsKey("candidates")) {
                return json.getJsonArray("candidates")
                    .getJsonObject(0)
                    .getJsonObject("content")
                    .getJsonArray("parts")
                    .getJsonObject(0)
                    .getString("text")
                    .trim();
            }

            if (json.containsKey("error")) {
                return "⚠ Gemini Error: "
                        + json.getJsonObject("error").getString("message");
            }

            return "⚠ Unexpected AI response format.";

        } catch (Exception e) {
            e.printStackTrace();
            return "⚠ Sorry — AI service is unavailable right now.";
        }
    }
}
