/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.udea.logica;

import com.udea.hb.Empresa;
import com.udea.hb.NewHibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Diego
 */
public class consulta_empresa {

    public List<Empresa> getEmpresa() {

        List<Empresa> empre = null;
        Session session = null;

        try {
            session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();

            Query q = session.createQuery("from Empresa");
            empre = q.list();

            session.getTransaction().commit();

        } catch (Exception e) {
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return empre;
    }


    public List<Empresa> buscarEmpresa(String criterio, String valor) {

        List<Empresa> empre = null;
        Session session = null;

        try {
            session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();

            Query q = null;

            if (criterio.equals("rut")) {
                q = session.createQuery("from Empresa where rut = :valor");
                q.setParameter("valor", valor);
            } else if (criterio.equals("nombre")) {
                q = session.createQuery("from Empresa where nombre like :valor");
                q.setParameter("valor", "%" + valor + "%");
            }

            empre = q.list();

            session.getTransaction().commit();

        } catch (Exception e) {
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return empre;
    }

    public Empresa obtenerEmpresaPorRut(String rut) {
        Empresa empresa = null;
        Session session = null;
        try {
            session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            empresa = (Empresa) session.get(Empresa.class, rut);
            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return empresa;
    }

    public boolean insertarEmpresa(String rut, String nombre, String direccion) {
        Session session = null;
        try {
            session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Empresa empresa = new Empresa(rut, nombre, direccion);
            session.save(empresa);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean actualizarEmpresa(String rut, String nombre, String direccion) {
        Session session = null;
        try {
            session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Empresa empresa = (Empresa) session.get(Empresa.class, rut);
            if (empresa != null) {
                empresa.setNombre(nombre);
                empresa.setDireccion(direccion);
                session.update(empresa);
                session.getTransaction().commit();
                return true;
            }
            session.getTransaction().commit();
            return false;
        } catch (Exception e) {
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean eliminarEmpresa(String rut) {
        Session session = null;
        try {
            session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Empresa empresa = (Empresa) session.get(Empresa.class, rut);
            if (empresa != null) {
                session.delete(empresa);
                session.getTransaction().commit();
                return true;
            }
            session.getTransaction().commit();
            return false;
        } catch (Exception e) {
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
