package com.notesy.controller;
import com.notesy.model.NoteDAO;
import com.notesy.beans.Note;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;


/**
 * Servlet implementation class DownloadServlet
 */
@WebServlet("/download")
public class DownloadServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

    @Override
   
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("DOWNLOAD SERVLET REACHED");

        String idParam = req.getParameter("noteId");
        System.out.println("noteId param = " + idParam);

        if (idParam == null) {
            resp.sendError(400, "Missing noteId");
            return;
        }

        int id = Integer.parseInt(idParam);

        NoteDAO dao = new NoteDAO();
        Note note;

        try {
            note = dao.getNoteById(id);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "DB error");
            return;
        }

        if (note == null) {
            resp.sendError(404, "Note not found");
            return;
        }

        String dbPath = note.getFilePath();
        File file;

        // Absolute path
        if (dbPath.startsWith("C:") || dbPath.startsWith("/") ) {
            file = new File(dbPath);
        } else {
            file = new File(getServletContext().getRealPath("/"), dbPath);
        }

        System.out.println("FINAL path = " + file.getAbsolutePath());
        System.out.println("Exists? " + file.exists());

        if (!file.exists()) {
            resp.sendError(404, "File not found");
            return;
        }

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition",
                "attachment; filename=\"" + file.getName() + "\"");
        resp.setContentLengthLong(file.length());

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }

        System.out.println("DOWNLOAD COMPLETE");
    }
}