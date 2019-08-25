
package com.project.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class ExUserHasBook extends WebApplicationException {

	private static final long serialVersionUID = 1L;

	public ExUserHasBook() {
		super(Response.status(Response.Status.BAD_REQUEST).entity("User Has Assigned Book").type(MediaType.TEXT_PLAIN)
				.build());
	}

}
