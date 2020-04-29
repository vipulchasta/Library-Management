
package com.project.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class ExInvalidBook extends WebApplicationException {

	private static final long serialVersionUID = 1L;

	public ExInvalidBook() {
		super(Response.status(Response.Status.BAD_REQUEST).entity("Book Is Not Valid").type(MediaType.TEXT_PLAIN)
				.build());
	}

}
