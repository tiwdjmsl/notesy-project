package com.notesy.controller;

import com.notesy.model.DB;
import com.notesy.beans.Note;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.nio.file.Files;

@WebServlet("/Controller")
public class Controller extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DB db = new DB();

    // ===================== GET REQUESTS =====================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String page = req.getParameter("page");
        HttpSession session = req.getSession(false);

        if (page == null) {
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
            case "mynotes":
                req.setAttribute("notes",
                        db.getNotesByUser((String) session.getAttribute("user")));
                forward(req, res, "mynotes.jsp");
                break;

            // ---------- EXPLORE ----------
            case "explore":
                req.setAttribute("notes", db.getAllNotes());
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
                
                //----------Search File--------
            case "search":
                String keyword = req.getParameter("q");
                req.setAttribute("notes", db.searchNotes(keyword));
                req.setAttribute("keyword", keyword);
                forward(req, res, "explore.jsp");
                break;

        }
    }


    // ===================== POST REQUESTS =====================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String page = req.getParameter("page");

        switch (page) {

            // ---------- LOGIN ----------
            case "login":
                handleLogin(req, res);
                break;

            // ---------- REGISTER ----------
            case "register":
                db.registerUser(
                        req.getParameter("username"),
                        req.getParameter("password")
                );
                req.setAttribute("message", "Account created — please login.");
                forward(req, res, "login.jsp");
                break;

            // ---------- ADD / UPLOAD NOTE ----------
            case "addnote":
                handleAddNote(req, res);
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

        Note n = new Note();

        n.setTitle(req.getParameter("title"));
        n.setAuthor(req.getParameter("author"));
        n.setCategory(req.getParameter("category"));
        n.setDescription(req.getParameter("description"));

        n.setPaid(Boolean.parseBoolean(req.getParameter("paid")));
        n.setPrice(Double.parseDouble(req.getParameter("price")));

        // default stats
        n.setLikes(0);
        n.setViews(0);
        n.setDownloads(0);

        // file metadata only (DB stores path)
        n.setFilePath(req.getParameter("filePath"));

        n.setUploader((String) req.getSession().getAttribute("user"));

        db.addNote(n);

        res.sendRedirect("Controller?page=mynotes");
    }
//----dl purchase---
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

        // ---------- USER ALREADY PURCHASED ----------
        streamFile(note.getFilePath(), res);
    }



	

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
