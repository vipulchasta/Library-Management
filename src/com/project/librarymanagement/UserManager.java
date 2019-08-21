package com.project.librarymanagement;

import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.project.util.HibernateUtil;

public class UserManager {

	private static SessionFactory factory;

	/**
	 * addUser() -> Adds User in the database
	 * 
	 * @param username
	 * @param password
	 * @param enabled
	 * @return User Instance
	 */
	public static User addUser(String username, String password, boolean enabled) {
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		User user = null;

		try {
			tx = session.beginTransaction();
			user = new User(username, password, enabled);
			session.save(user);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return user;
	}

	/**
	 * removeUser() -> Removes user form the database
	 * 
	 * @param user
	 */
	public static void removeUser(User user) {
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			session.delete(user);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	/**
	 * getAllUsers() -> Provides list of all users present in the database
	 * 
	 * @return List of User
	 */
	@SuppressWarnings("unchecked")
	public static List<User> getAllUsers() {
		List<User> users = null;
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			String hql = "FROM User";
			Query query = session.createQuery(hql);
			users = query.list();
			for (Iterator<?> iterator = users.iterator(); iterator.hasNext();) {
				User user = (User) iterator.next();
				System.out.print("UserName: " + user.getUsername());
				System.out.print(", Password: " + user.getPassword());
				System.out.println(", Enabled: " + user.getEnabled());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return users;
	}

	/**
	 * getUserByUsername() -> Provides User instance of a particular username,
	 * returns null if user is not present in the database
	 * 
	 * @param username
	 * @return User Instance
	 */
	@SuppressWarnings("unchecked")
	public static User getUserByUsername(String username) {
		List<User> users = null;
		User user = null;
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			String hql = "FROM User WHERE username = '" + username + "'";
			Query query = session.createQuery(hql);
			users = query.list();
			for (Iterator<?> iterator = users.iterator(); iterator.hasNext();) {
				user = (User) iterator.next();
				System.out.print("UserName: " + user.getUsername());
				System.out.print(", Password: " + user.getPassword());
				System.out.println(", Enabled: " + user.getEnabled());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return user;
	}
}
