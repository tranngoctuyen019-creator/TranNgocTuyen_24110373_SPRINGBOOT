package vn.iot.star.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import vn.iot.star.utils.FileStorageService;

@RestController
public class ImageController {

	private final FileStorageService fileStorageService;

	ImageController(FileStorageService fileStorageService) {
		this.fileStorageService = fileStorageService;
	}

	@GetMapping("/image")
	public ResponseEntity<Resource> image(@RequestParam(name = "fname", required = false) String fname) {

		if (fname == null || fname.isBlank()) {
			return ResponseEntity.notFound().build();
		}

		File file = fileStorageService.resolve(fname);

		if (!file.exists() || !file.isFile()) {
			return ResponseEntity.notFound().build();
		}

		MediaType contentType = MediaType.APPLICATION_OCTET_STREAM;

		try {
			String probed = Files.probeContentType(file.toPath());
			if (probed != null) {
				contentType = MediaType.parseMediaType(probed);
			}
		} catch (IOException ignored) {
			// fall back to octet-stream below
		}

		Resource resource = new FileSystemResource(file);

		return ResponseEntity.ok()
				.contentType(contentType)
				.header(HttpHeaders.CACHE_CONTROL, "no-cache")
				.body(resource);
	}
}
