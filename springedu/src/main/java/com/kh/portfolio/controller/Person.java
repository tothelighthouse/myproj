package com.kh.portfolio.controller;

import javax.persistence.Entity;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
@Entity
public class Person {
		public String name;
		@Max(value = 30, message = "30세 이상만 가입 가능")
		public int age;

}
