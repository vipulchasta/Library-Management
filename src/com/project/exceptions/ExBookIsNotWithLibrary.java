
package com.project.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class ExBookIsNotWithLibrary extends WebApplicationException {

	private static final long serialVersionUID = 1L;

	public ExBookIsNotWithLibrary() {
		super(Response.status(Response.Status.BAD_REQUEST).entity("Book is Asigned to someone")
				.type(MediaType.TEXT_PLAIN).build());
	}

}
