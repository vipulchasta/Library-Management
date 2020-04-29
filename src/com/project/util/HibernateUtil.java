package com.project.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
	private static Boolean isInitialized = false;
	private static SessionFactory factory = null;

	@SuppressWarnings("deprecation")
	public static void AppHibernateInit() {
		if (!isInitialized) {
			try {
				factory = new Configuration().configure().buildSessionFactory();
			} catch (Throwable ex) {
				System.err.println("Failed to create sessionFactory object." + ex);
				throw new ExceptionInInitializerError(ex);
			}
			isInitialized = true;
		}
	}

	public static SessionFactory getSessionFactory() {
		if (!isInitialized) {
			AppHibernateInit();
		}
		return factory;
	}

	public static void shutdown() {
		// Close caches and connection pools
		getSessionFactory().close();
	}
}