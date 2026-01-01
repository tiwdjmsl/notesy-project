package com.notesy.controller;

import com.notesy.model.DB;
import com.notesy.beans.Note;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.nio.file.Files;
import java.util.List;

@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DB db = new DB();

    // ===================== GET REQUESTS =====================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String page = req.getParameter("page");
        HttpSession session = req.getSession(false);

        // ---------- HOME / FEATURED NOTES ----------
        if (page == null || page.equals("home")) {

            List<Note> notes = db.getFeaturedNotes();
            req.setAttribute("notes", notes);

            forward(req, res, "index.jsp");
            return;
        }

        switch (page) {

            // ---------- LOGOUT ----------
            case "logout":
                if (session != null) session.invalidate();
                forward(req, res, "logout.jsp");
                break;

            // ---------- VIEW MY NOTES ----------
            case "profile":
                req.setAttribute(
                    "notes",
                    db.getNotesByUser((String) session.getAttribute("user"))
                );
                forward(req, res, "profile.jsp");
                break;

            // ---------- EXPLORE ----------
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


            // ---------- SEARCH ----------
            case "search":
                String keyword = req.getParameter("q");
                req.setAttribute("notes", db.searchNotes(keyword));
                req.setAttribute("keyword", keyword);
                forward(req, res, "explore.jsp");
                break;

            // ---------- DELETE NOTE ----------
            case "deletenote":
                db.deleteNote(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("Controller?page=mynotes");
                break;

            // ---------- DOWNLOAD FILE ----------
            case "download":
                handleDownload(req, res);
                break;

            default:
                forward(req, res, "index.jsp");
                break;
                
             // ---------- UPLOAD PAGE ----------
            case "upload":
                forward(req, res, "upload.jsp");
                break;
        }
    }

    // ===================== POST REQUESTS =====================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String page = req.getParameter("page");

        switch (page) {

            case "login":
                handleLogin(req, res);
                break;

            case "register":
                db.registerUser(
                    req.getParameter("username"),
                    req.getParameter("password")
                );
                req.setAttribute("message", "Account created — please login.");
                forward(req, res, "login.jsp");
                break;

            // ✅ THIS WAS MISSING
            case "addnote":
                handleAddNote(req, res);
                break;

            default:
                res.sendRedirect("Controller?page=home");
                break;
        }

    }

    // ===================== LOGIN =====================
    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String u = req.getParameter("username");
        String p = req.getParameter("password");

        if (db.validateUser(u, p)) {
            req.getSession().setAttribute("user", u);
            forward(req, res, "profile.jsp");
        } else {
            req.setAttribute("error", "Invalid username or password");
            forward(req, res, "login.jsp");
        }
    }

    // ===================== ADD / UPLOAD NOTE =====================
    private void handleAddNote(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        System.out.println(">>> handleAddNote() CALLED <<<");

        Note n = new Note();

        n.setTitle(req.getParameter("title"));
        n.setDescription(req.getParameter("description"));
        n.setCategory(req.getParameter("category"));
        n.setAuthor(req.getParameter("author"));

        n.setPaid(Boolean.parseBoolean(req.getParameter("paid")));
        n.setPrice(Double.parseDouble(req.getParameter("price")));

        n.setLikes(0);
        n.setDownloads(0);

        n.setFilePath(req.getParameter("filePath"));
        n.setUploader((String) req.getSession().getAttribute("user"));

        db.addNote(n);

        res.sendRedirect("Controller?page=home");
    }



    // ===================== DOWNLOAD =====================
    private void handleDownload(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String user = (String) req.getSession().getAttribute("user");
        int noteId = Integer.parseInt(req.getParameter("id"));

        Note note = db.getNoteById(noteId);

        // ---------- FREE NOTE ----------
        if (!note.isPaid()) {
            streamFile(note.getFilePath(), res);
            return;
        }

        // ---------- PAID NOTE ----------
        if (!db.hasPurchased(user, noteId)) {
            req.setAttribute("note", note);
            req.setAttribute("error", "This is a paid note. Please purchase first.");
            forward(req, res, "payment.jsp");
            return;
        }

        streamFile(note.getFilePath(), res);
    }

    // ===================== FILE STREAM =====================
    private void streamFile(String path, HttpServletResponse res) throws IOException {

        File file = new File(path);

        res.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
        res.setContentType(Files.probeContentType(file.toPath()));

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = res.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytes;
            while ((bytes = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytes);
            }
        }
    }

    // ===================== FORWARD HELPER =====================
    private void forward(HttpServletRequest req, HttpServletResponse res, String page)
            throws ServletException, IOException {
        req.getRequestDispatcher(page).forward(req, res);
    }
}
