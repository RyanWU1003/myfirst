package tw.iii.config;

import javax.servlet.Filter;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import tw.iii.util.OpenSessionViewFilter;

public class DispatcherServletInitialzer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {

		return new Class[] {RootAppConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		
		return new Class[] {MvcJavaConfig.class};
	}

	@Override
	protected String[] getServletMappings() {

		return new String[] {"/"};
	}

	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter enFilter = new CharacterEncodingFilter();
		enFilter.setEncoding("UTF-8");
		enFilter.setForceEncoding(true);
		return new Filter[] {enFilter};
	}
	
	public void onStartup(ServletContext servletContext) throws ServletException {
		AnnotationConfigWebApplicationContext rootcontext = new AnnotationConfigWebApplicationContext();
		rootcontext.register(MvcJavaConfig.class);		//取得MvcJavaConfig裡的設定檔
		rootcontext.setServletContext(servletContext);
		ServletRegistration.Dynamic mvc = servletContext.addServlet("mvc", new DispatcherServlet(rootcontext));
		mvc.setLoadOnStartup(1);
		mvc.addMapping("/");
		FilterRegistration.Dynamic filter = servletContext.addFilter("endcodingFilter", new CharacterEncodingFilter());
		filter.setInitParameter("encoding", "UTF-8");
		filter.setInitParameter("forceEncoding", "true");
		filter.addMappingForUrlPatterns(null, false, "/*");
		filter = servletContext.addFilter("OpenSessionInViewFilter", OpenSessionViewFilter.class);
		filter.setInitParameter("sessionFactoryBeanName", "sessionFactory");
		filter.addMappingForUrlPatterns(null, true, "/*");
		filter.addMappingForServletNames(null, true, "mvc");

		servletContext.addListener(new ContextLoaderListener(rootcontext));
	}
	
	

}
