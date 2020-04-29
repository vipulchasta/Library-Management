
package com.project.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class ExUserNotFound extends WebApplicationException {

	private static final long serialVersionUID = 1L;

	public ExUserNotFound() {
		super(Response.status(Response.Status.BAD_REQUEST).entity("User Not Found").type(MediaType.TEXT_PLAIN).build());
	}

}
