
package com.project.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class ExBookNotFound extends WebApplicationException {

	private static final long serialVersionUID = 1L;

	public ExBookNotFound() {
		super(Response.status(Response.Status.BAD_REQUEST).entity("Book Not Found").type(MediaType.TEXT_PLAIN).build());
	}

}
