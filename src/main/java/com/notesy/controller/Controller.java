package com.notesy.controller;

import com.notesy.model.DB;
import com.notesy.beans.Note;
import com.notesy.beans.User;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.nio.file.Files;
import java.util.List;

@WebServlet("/Controller")
@MultipartConfig
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DB db = new DB();

    // ===================== GET =====================
    // Pages that users OPEN IN BROWSER belong here
    @Override
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String page = req.getParameter("page");
        HttpSession session = req.getSession(false);

        // Default page = HOME
        if (page == null || page.equals("home")) {
            List<Note> featured = db.getFeaturedNotes();
            req.setAttribute("featuredNotes", featured);
            forward(req, res, "index.jsp");
            return;
        }

        switch (page) {

            case "logout":
                if (session != null) session.invalidate();
                forward(req, res, "logout.jsp");
                break;

            case "upload":
                forward(req, res, "upload.jsp");
                break;
                
            case "download":
                handleDownload(req, res);   // <-- add this line
                break;
                
            case "open_download":
                openDownload(req, res);
                break;
                
            case "payment":
                int noteId = Integer.parseInt(req.getParameter("id"));
                Note notePay = db.getNoteById(noteId);

                req.setAttribute("note", notePay);
                forward(req, res, "payment.jsp");
                break;


    
            case "search":
                String keyword = req.getParameter("q");
                List<Note> results = db.searchNotes(keyword);

                req.setAttribute("notes", results);
                req.setAttribute("keyword", keyword);

                forward(req, res, "explore.jsp");
                break;

            case "profile":

                HttpSession s = req.getSession(false);

                if (s == null || s.getAttribute("user_id") == null) {
                    res.sendRedirect("login.jsp");
                    return;
                }

                int userId = (Integer) s.getAttribute("user_id");

                DB dbp = new DB();

                // Load notes for tabs
                req.setAttribute("myNotes", dbp.getNotesByUser(userId));
                req.setAttribute("purchasedNotes", dbp.getPurchasedNotes(userId));
                req.setAttribute("favoriteNotes", dbp.getFavoriteNotes(userId));

                // ===== CALCULATE STATS HERE =====
                int uploadedCount = dbp.countUserNotes(userId);
                double totalSales = dbp.getTotalSales(userId);

                req.setAttribute("statsNotes", uploadedCount);
                req.setAttribute("statsSales", totalSales);

                forward(req, res, "profile.jsp");
                break;


            case "explore":
                String category = req.getParameter("category");

                if (category != null && !category.isEmpty()) {
                    req.setAttribute("notes", db.getNotesByCategory(category));
                    req.setAttribute("activeCategory", category);
                } else {
                    req.setAttribute("notes", db.getAllNotes());
                    req.setAttribute("activeCategory", "All");
                }

                forward(req, res, "explore.jsp");
                break;

            default:
                forward(req, res, "index.jsp");
        }
    }


    // ===================== POST =====================
    // Actions triggered by forms & buttons belong here
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String page = req.getParameter("page");
        if (page == null) page = "";

        switch (page) {

            case "login":
                handleLogin(req, res);
                break;

            case "register":
                handleRegister(req, res);
                break;

            case "addnote":
                handleAddNote(req, res);
                break;
            case "pay":
                handlePayment(req, res);
                break;
                

           

            

            default:
                forward(req, res, "index.jsp");
        }
    }


    // ===================== LOGIN =====================
    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (db.validateUser(username, password)) {
        	User u = db.getUserByUsername(username);
            req.getSession().setAttribute("user", username);
            req.getSession().setAttribute("user_id", u.getUserId());
            forward(req, res, "profile.jsp");
        } else {
            req.setAttribute("error", "Invalid username or password");
            forward(req, res, "login.jsp");
        }
    }


    // ===================== REGISTER =====================
    private void handleRegister(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean success = db.registerUser(username, email, password);

        if (success) {
            res.sendRedirect("login.jsp?status=registered");
        } else {
            req.setAttribute("error", "Registration failed. Try again.");
            forward(req, res, "register.jsp");
        }
    }


    // ===================== ADD NOTE =====================
    private void handleAddNote(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {


        Note n = new Note();

        int userId = (int) req.getSession().getAttribute("user_id");
        n.setUserId(userId);

        n.setTitle(req.getParameter("title"));
        n.setDescription(req.getParameter("description"));
        n.setCategory(req.getParameter("category"));
        n.setLikes(0);

        // temporary placeholders until file upload is implemented
        String priceParam = req.getParameter("price");
        n.setPrice(priceParam == null || priceParam.isEmpty()
                ? 0.0
                : Double.parseDouble(priceParam));

        // ===== FILE UPLOAD =====
        // ===== CREATE /uploads FOLDER =====
        String uploadDir = getServletContext().getRealPath("") + "uploads";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();



        // ===== PDF FILE (required) =====
        Part filePart = req.getPart("file");

        if (filePart == null || filePart.getSize() == 0) {
            System.out.println("UPLOAD ERROR: No PDF uploaded");
            res.sendRedirect("Controller?page=upload&error=nofile");
            return;
        }

        String pdfName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String pdfPath = uploadDir + File.separator + pdfName;

        filePart.write(pdfPath);

        // store relative path in DB
        n.setFilePath("uploads/" + pdfName);



        // ===== THUMBNAIL (optional) =====
        Part thumbPart = req.getPart("thumb");

        if (thumbPart != null && thumbPart.getSize() > 0) {

            String thumbName = "thumb_" + System.currentTimeMillis()
                    + "_" + thumbPart.getSubmittedFileName();

            String thumbPath = uploadDir + File.separator + thumbName;

            thumbPart.write(thumbPath);

            n.setPicture("uploads/" + thumbName);

        } else {
            // fallback placeholder image
            n.setPicture("assets/images/default.jpg");
        }

        


        // ===== SAVE NOTE TO DATABASE =====
        db.addNote(n);

        System.out.println("NOTE SAVED:");
        System.out.println("PDF  = " + n.getFilePath());
        System.out.println("THUMB = " + n.getPicture());
        res.sendRedirect("Controller?page=upload&status=success");
    }
    
    private void openDownload(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");

        if (idParam == null) {
            req.setAttribute("error", "Note not found.");
            forward(req, res, "download.jsp");
            return;
        }

        int id = Integer.parseInt(idParam);
        Note note = db.getNoteById(id);

        if (note == null) {
            req.setAttribute("error", "Note not found.");
            forward(req, res, "download.jsp");
            return;
        }

        req.setAttribute("note", note);
        forward(req, res, "download.jsp");
    }

    private void handlePayment(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");
        int noteId = Integer.parseInt(req.getParameter("id"));

        // 🟢 Record purchase in DB
        db.recordPurchase(userId, noteId);

        System.out.println("PAYMENT SUCCESS → recorded purchase for user " + userId);

        // Redirect to download
        res.sendRedirect("Controller?page=download&id=" + noteId);
    }



 // ===================== DOWNLOAD =====================
    private void handleDownload(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        int noteId = Integer.parseInt(req.getParameter("id"));
        Note note = db.getNoteById(noteId);

        if (note == null) {
            req.setAttribute("error", "Note not found.");
            forward(req, res, "download.jsp");
            return;
        }

        // Convert relative DB path → real server path
        String realPath = getServletContext().getRealPath("/") + note.getFilePath();
        File file = new File(realPath);

        if (!file.exists()) {
            req.setAttribute("error", "File missing on server.");
            forward(req, res, "download.jsp");
            return;
        }

        res.setHeader("Content-Disposition",
                "attachment; filename=\"" + file.getName() + "\"");
        res.setContentType("application/pdf");
        res.setContentLengthLong(file.length());

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = res.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytes;
            while ((bytes = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytes);
            }
        }
    }





    // ===================== FORWARD =====================
    private void forward(HttpServletRequest req, HttpServletResponse res, String page)
            throws ServletException, IOException {
        req.getRequestDispatcher(page).forward(req, res);
    }
}
