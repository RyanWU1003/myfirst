package tw.iii.config;

import java.util.Properties;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class RootAppConfig {

	Environment env;

	@Autowired
	public void setEnv(Environment env) {
		this.env = env;
	}

	@Bean
	public DataSource dataSource() throws IllegalArgumentException, NamingException {
		JndiObjectFactoryBean factoryBean = new JndiObjectFactoryBean();
		factoryBean.setJndiName("java:comp/env/connectSQLServerJdbc/OrderService");
		factoryBean.setProxyInterface(DataSource.class);
		factoryBean.afterPropertiesSet();
		return (DataSource) factoryBean.getObject();
	}
	public Properties hibernateProperties() {
		Properties hProperties = new Properties();
//		hProperties.put("hibernate.connection.driver_class", com.microsoft.sqlserver.jdbc.SQLServerDriver.class);
//		hProperties.put("hibernate.connection.url", "jdbc:sqlserver://localhost:1433;databaseName=Topic");
//		hProperties.put("hibernate.connection.username", "watcher");
//		hProperties.put("hibernate.connection.password", "P@ssw0rd");
		hProperties.put("hibernate.dialect", org.hibernate.dialect.SQLServerDialect.class);
		hProperties.put("hibernate.current_session_context_class", "thread");
		hProperties.put("hibernate.show_sql", Boolean.TRUE);
		hProperties.put("hibernate.format_sql", Boolean.TRUE);
		return hProperties;
	}

	@Bean(destroyMethod = "destroy")
	public LocalSessionFactoryBean sessionFactory() throws IllegalArgumentException, NamingException {
		LocalSessionFactoryBean factory = new LocalSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setPackagesToScan(new String[] { "tw.iii.model" });
		factory.setHibernateProperties(hibernateProperties());
		return factory;
	}


	@Bean(name = "transactionManager")
	@Autowired
	public HibernateTransactionManager transactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager htManager = new HibernateTransactionManager();
		htManager.setSessionFactory(sessionFactory);
		return htManager;
	}
}
