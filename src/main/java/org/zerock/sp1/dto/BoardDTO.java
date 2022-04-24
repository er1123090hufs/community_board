package org.zerock.sp1.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BoardDTO {

    private Integer bno;
    private String title;
    private String contents;
    private String writer;

    private LocalDateTime regDate;
    private LocalDateTime updateDate;

}
