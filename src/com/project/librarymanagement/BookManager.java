package com.project.librarymanagement;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.project.util.HibernateUtil;

public class BookManager {

	private static SessionFactory factory;

	/**
	 * Update Book -> Updates the entire book entity in the database
	 * 
	 * @param book
	 */
	public static void updateBook(Book book) {
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			session.update(book);
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
	 * addBook() -> Creates a new book entity in the database
	 * 
	 * @param bookname
	 * @return Book Instance
	 */
	public static Book addBook(String bookname) {
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		Book book = null;

		try {
			tx = session.beginTransaction();
			book = new Book(bookname);
			session.save(book);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return book;
	}

	/**
	 * getAllBooks() -> Provides the list of books present in the database
	 * 
	 * @return List of the book
	 */
	@SuppressWarnings("unchecked")
	public static List<Book> getAllBooks() {
		List<Book> books = null;
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			books = session.createQuery("FROM Book").list();
			for (Iterator<?> iterator = books.iterator(); iterator.hasNext();) {
				Book book = (Book) iterator.next();
				System.out.print("UserName: " + book.getUsername());
				System.out.print(", Bookname: " + book.getBookname());
				System.out.println(", Id: " + book.getId());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return books;
	}

	/**
	 * getBooksByUser() -> Provides the list of books present in the database and
	 * assigned to the provided user
	 * 
	 * @param username
	 * @return List of the book
	 */
	@SuppressWarnings("unchecked")
	public static List<Book> getBooksByUser(String username) {
		List<Book> books = null;
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			books = session.createQuery("FROM Book WHERE username='" + username + "'").list();
			for (Iterator<?> iterator = books.iterator(); iterator.hasNext();) {
				Book book = (Book) iterator.next();
				System.out.print("UserName: " + book.getUsername());
				System.out.print(", Bookname: " + book.getBookname());
				System.out.println(", Id: " + book.getId());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return books;
	}

	@SuppressWarnings("unchecked")
	public static List<Book> getExpiringBooksByUser(String username, Integer daysInterval) {
		List<Book> books = null;
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			Date curDate = new Date(System.currentTimeMillis() + (daysInterval * 24 * 60 * 60 * 1000));
			System.out.println("cur: " + new Date(System.currentTimeMillis()));
			System.out.println("curDate: " + curDate);
			books = session
					.createQuery("FROM Book WHERE username='" + username + "' AND dateOfAssignmentExpire <= :curDate")
					.setParameter("curDate", curDate).list();
			for (Iterator<?> iterator = books.iterator(); iterator.hasNext();) {
				Book book = (Book) iterator.next();
				System.out.print("UserName: " + book.getUsername());
				System.out.print(", Bookname: " + book.getBookname());
				System.out.println(", Id: " + book.getId());
				System.out.println(", getDateOfAssignmentExpire: " + book.getDateOfAssignmentExpire());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return books;
	}

	/**
	 * getBookById -> Provides the book instance by its id, if it does not present
	 * in the database it will return null
	 * 
	 * @param bookId
	 * @return Book Instance
	 */
	@SuppressWarnings("unchecked")
	public static Book getBookById(int bookId) {
		List<Book> books = null;
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;
		Book book = null;
		try {
			tx = session.beginTransaction();
			books = session.createQuery("FROM Book WHERE id=" + bookId).list();
			for (Iterator<?> iterator = books.iterator(); iterator.hasNext();) {
				book = (Book) iterator.next();
				System.out.print("UserName: " + book.getUsername());
				System.out.print(", Bookname: " + book.getBookname());
				System.out.println(", Id: " + book.getId());
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return book;
	}

	/**
	 * removeBook() -> Removes book form the database
	 * 
	 * @param book instance
	 */
	public static void removeBook(Book book) {
		factory = HibernateUtil.getSessionFactory();
		Session session = factory.openSession();
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			session.delete(book);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
}
