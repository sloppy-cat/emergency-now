package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class Controller {

	@GetMapping("/")
	public String index() {
		return " 5일간의 K8s 본부 세미나에 참석하시느라 모두 수고 많으셨습니다. \n 미숙하지만 열심히 준비한 세미나 끝까지 들어주셔서 감사합니다!";
	}

}
