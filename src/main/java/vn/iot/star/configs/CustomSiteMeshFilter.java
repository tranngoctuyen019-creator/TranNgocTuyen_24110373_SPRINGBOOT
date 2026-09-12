package vn.iot.star.configs;

import org.sitemesh.builder.SiteMeshFilterBuilder;


import org.sitemesh.config.ConfigurableSiteMeshFilter;


public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("/*", "web.jsp")
				.addDecoratorPath("/admin/*", "admin.jsp")
				.addExcludedPath("/api/**").addExcludedPath("/api/**");
	}
}