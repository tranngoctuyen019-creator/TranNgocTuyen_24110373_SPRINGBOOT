package vn.iot.star.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="categories")
@NamedQuery(
    name = "Category.findAll",
    query = "SELECT c FROM Category c"
)
public class Category implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int categoryId;

	@Column(
	    name="categoryname",
	    columnDefinition ="NVARCHAR(255) NULL"
	)
	private String categoryname;

	@Column(
	    name="images",
	    columnDefinition ="NVARCHAR(255) NULL"
	)
	private String images;

	@Column(name="status")
	private int status;
}