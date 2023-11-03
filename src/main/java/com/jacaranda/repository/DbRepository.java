package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Company;
import com.jacaranda.model.CompanyProject;
import com.jacaranda.model.EmployeeProject;
import com.jacaranda.model.User;
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
	
	public static EmployeeProject find(EmployeeProject cp) throws Exception {
		Session session;
		EmployeeProject result = null;
		try {
			session = DBUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = session.find(EmployeeProject.class, cp);
		} catch (Exception e) {
			throw new Exception("Error al obtener la identidad.");
		}
		
		return result;
	}
	
	public static <T> T findUser(Class<T> c, String id) throws Exception{
        Session session;
        T result = null;
        try {
            session = DBUtility.getSessionFactory().openSession();
        } catch (Exception e) {
            throw new Exception("Error en la base de datos");
        }
        try {
            result = session.find(c, id);
        } catch (Exception e) {
            throw new Exception("Error al obtener la entidad");
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
	
	public static Company lookCompany(String name) {
		Company result = null;
		Session session = DBUtility.getSessionFactory().openSession();

		SelectionQuery<Company> q =
				session.createSelectionQuery("From Company where name = :name", Company.class);
				q.setParameter("name", name);
				List<Company> companys = q.getResultList(); 
				if(companys.size() != 0) {
					result = companys.get(0);
				}
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
	
	public static <T> void editEntity(T t) {
		Transaction transaction = null;
		Session session = DBUtility.getSessionFactory().openSession();
	
		transaction = session.beginTransaction();
		try {
			session.merge(t);
			transaction.commit();
		} catch (IllegalStateException e) {
			e.printStackTrace();
			transaction.rollback();
		}
		
		session.close();
	}
	
	public static <T> void deleteEntity(Class<T> t,int id ) {
		Transaction transaction = null;
		T result = null;
		Session session = DBUtility.getSessionFactory().openSession();
		
		SelectionQuery<T> q =session.createSelectionQuery("From "+t.getName()+" where id = :id",t);//Creamos la consulta para sacar la tarea con el mismo PK
		q.setParameter("id", id);
		List<T> entitys= q.getResultList();
		if(entitys.size()!=0) { result=entitys.get(0);transaction = session.beginTransaction();}//Guardamos el resultado de la consulta
		session.remove(result);//Se borra la tarea con remove.
		transaction.commit();
	}
	
	
}
