package com.notesy.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String fullname  = req.getParameter("fullname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        // TODO add DB insert later
        req.setAttribute("msg", "Account created. Please login.");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
