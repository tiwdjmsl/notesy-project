package com.notesy.controller;

import com.notesy.beans.Note;
import com.notesy.service.NoteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/upload-note")
@MultipartConfig
public class UploadController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final NoteService noteService = new NoteService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            req.setCharacterEncoding("UTF-8");

            // -------- Get Form Fields --------
            String title = req.getParameter("title");
            String author = req.getParameter("author");
            String category = req.getParameter("category");
            String paidVal = req.getParameter("isPaid");
            String priceVal = req.getParameter("price");

            boolean isPaid = "1".equals(paidVal);

            double price = (isPaid && priceVal != null && !priceVal.isBlank())
                    ? Double.parseDouble(priceVal)
                    : 0.0;

            // -------- Get Logged-in User --------
            HttpSession session = req.getSession(false);
            String uploader = (session != null)
                    ? (String) session.getAttribute("user")
                    : "Guest";

            // Defaults if user leaves fields blank
            if (author == null || author.isBlank()) author = uploader;
            if (category == null || category.isBlank()) category = "General";

            // -------- Handle File Upload --------
            Part filePart = req.getPart("file");

            if (filePart == null || filePart.getSize() == 0) {
                resp.sendRedirect("upload.jsp?error=nofile");
                return;
            }

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            // Permanent storage folder
            String storagePath = "C:/notes_storage";

            File dir = new File(storagePath);
            if (!dir.exists()) dir.mkdirs();

            File savedFile = new File(dir, fileName);
            filePart.write(savedFile.getAbsolutePath());

            // -------- Build Note Object --------
            Note n = new Note();
            n.setTitle(title);
            n.setAuthor(author);
            n.setCategory(category);
            n.setPaid(isPaid);
            n.setPrice(price);

            // store relative path for downloads
            n.setFilePath("C:/notes_storage/" + fileName);

            n.setUploader(uploader);

            boolean success = noteService.uploadNote(n);

            if (success)
                resp.sendRedirect("explore?uploaded=1");
            else
                resp.sendRedirect("upload.jsp?error=db");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("upload.jsp?error=exception");
        }
    }
}
