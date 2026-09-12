package vn.iot.star.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

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
@Table(name = "users")
@NamedQuery(
    name = "User.findAll",
    query = "SELECT u FROM User u ORDER BY u.userId DESC"
)
@NamedQuery(
    name = "User.findLatest",
    query = "SELECT u FROM User u ORDER BY u.createdAt DESC, u.userId DESC"
)
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userId;

	@Column(
	    name = "fullname",
	    columnDefinition = "NVARCHAR(255) NULL"
	)
	private String fullName;

	@Column(
	    name = "username",
	    columnDefinition = "NVARCHAR(100) NULL"
	)
	private String username;

	@Column(
	    name = "password",
	    columnDefinition = "NVARCHAR(255) NULL"
	)
	private String password;

	@Column(
	    name = "email",
	    columnDefinition = "NVARCHAR(255) NULL"
	)
	private String email;

	@Column(
	    name = "phone",
	    columnDefinition = "NVARCHAR(20) NULL"
	)
	private String phone;

	@Column(
	    name = "address",
	    columnDefinition = "NVARCHAR(500) NULL"
	)
	private String address;

	@Column(
	    name = "avatar",
	    columnDefinition = "NVARCHAR(255) NULL"
	)
	private String avatar;

	@Column(name = "status")
	private int status;

	@Column(
	    name = "role",
	    columnDefinition = "NVARCHAR(20) DEFAULT 'USER'"
	)
	private String role;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	public User(String fullName, String username, String password, String email, String phone, String address,
			String avatar, int status, String role) {
		this.fullName = fullName;
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.avatar = avatar;
		this.status = status;
		this.role = (role == null || role.isBlank()) ? "USER" : role;
		this.createdAt = LocalDateTime.now();
	}
}
