
package com.notesy.controller;

import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

import com.notesy.service.NoteService;
import com.notesy.beans.Note;

@WebServlet("/explore")
public class ExploreController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final NoteService noteService = new NoteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    	String keyword = req.getParameter("q");
    	String subject = req.getParameter("subject");

    	boolean hasSearch =
    	    (keyword != null && !keyword.trim().isEmpty()) ||
    	    (subject != null && !subject.equals("all"));

    	List<Note> notes;

    	if (hasSearch) {
    	    notes = noteService.searchExploreNotes(keyword, subject);
    	} else {
    	    notes = noteService.getExploreNotes();   // <-- SHOW ALL NOTES
    	}

    	req.setAttribute("noteList", notes);
    	req.setAttribute("q", keyword);
    	req.setAttribute("subject", subject);

    	req.getRequestDispatcher("explore.jsp").forward(req, resp);
}
}