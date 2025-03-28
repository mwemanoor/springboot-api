package com.example.rest_api.student;

import jakarta.persistence.*;
import lombok.*;

    @Setter
    @Getter
    @Entity
    @Data
    @AllArgsConstructor
    @NoArgsConstructor

    public class Student {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;
        private String name;
        private String enrolledProgram;
    }

