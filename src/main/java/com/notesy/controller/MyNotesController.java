package com.notesy.controller;

import com.notesy.service.NoteService;
import com.notesy.beans.Note;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-notes")
public class MyNotesController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final NoteService noteService = new NoteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String uploader = (String) session.getAttribute("user");

        List<Note> myNotes = noteService.getUserNotes(uploader);

        req.setAttribute("myNotes", myNotes);
        req.getRequestDispatcher("/my-notes.jsp").forward(req, resp);
    }
}
