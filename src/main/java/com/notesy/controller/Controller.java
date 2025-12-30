package com.notesy.controller;


import com.notesy.model.NoteDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;

@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
   
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String page = req.getParameter("page");

        try {

            // ---------- DOWNLOAD ----------
            if ("download".equals(page)) {

                String id = req.getParameter("noteId");

                NoteDAO dao = new NoteDAO();
                com.notesy.beans.Note note = dao.getNoteById(Integer.parseInt(id));

                if (note == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                            "Note not found");
                    return;
                }

                // Build absolute file path
                String filePath = getServletContext().getRealPath("/") + note.getFilePath();
                java.io.File file = new java.io.File(filePath);

                if (!file.exists()) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                            "File not found on server");
                    return;
                }

                resp.setContentType("application/octet-stream");
                resp.setHeader("Content-Disposition",
                        "attachment; filename=\"" + file.getName() + "\"");

                try (java.io.FileInputStream in = new java.io.FileInputStream(file);
                     java.io.OutputStream out = resp.getOutputStream()) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;

                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }

                return; // IMPORTANT — stop further routing
            }

            // ---------- NORMAL ROUTING ----------
            if (page == null || page.equals("home")) {
                req.getRequestDispatcher("/index.jsp").forward(req, resp);

            } else if (page.equals("explore")) {
                resp.sendRedirect("/explore.jsp");

            } else if (page.equals("profile")) {
                req.getRequestDispatcher("/profile.jsp").forward(req, resp);

            } else {
                resp.sendError(404, "Page not found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Server error: " + e.getMessage());
        }
    }
}