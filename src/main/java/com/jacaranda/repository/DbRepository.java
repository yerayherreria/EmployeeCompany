package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Company;

import com.jacaranda.utility.DBUtility;

public class DbRepository {
	public static <E> E find(Class<E> c,int id) throws Exception {
		Transaction transaction = null;
		Session session;
		E result = null;
		try {
			session = DBUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = session.find(c, id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la identidad.");
		}
		
		return result;
	}
	
	public static <E> List<E> findAll(Class<E> c) throws Exception {
		Transaction transaction = null;
		Session session;
		List<E> result = null;
		try {
			session = DBUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = ((List<E>) session.createSelectionQuery("From "+c.getName()).getResultList());
		} catch (Exception e) {
			throw new Exception("Error al obtener la identidad.");
		}
		
		return result;
	}
	
	public static Company lookCompany(String company) {
		Company result = null;
		Session session = DBUtility.getSessionFactory().openSession();
		
		SelectionQuery<Company> q =session.createSelectionQuery("From Company where company = :company",Company.class);
		q.setParameter("company", company);
		List<Company> companies= q.getResultList();
		if(companies.size()!=0) {result=companies.get(0);};
		session.close();
		return result;
	}
	
	public static <T> void addEntity(T t) {
		Transaction transaction = null;
		Session session = DBUtility.getSessionFactory().openSession();
	
		transaction = session.beginTransaction();
		try {
			session.persist(t);
			transaction.commit();
		} catch (IllegalStateException e) {
			e.printStackTrace();
			transaction.rollback();
		}
		
		session.close();
	}
	
}
