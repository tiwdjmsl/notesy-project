package com.notesy.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String email = req.getParameter("email");
        String pass  = req.getParameter("password");

        // TODO replace with real auth later
        if (email.equals("demo@gmail.com") && pass.equals("123")) {
            HttpSession session = req.getSession();
            session.setAttribute("user", "Demo");
            resp.sendRedirect("explore");
        } else {
            req.setAttribute("error", "Invalid login");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
