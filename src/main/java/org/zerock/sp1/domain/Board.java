package org.zerock.sp1.domain;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Getter
public class Board {

    private Integer bno;
    private String title;
    private String contents;
    private String writer;

    private LocalDateTime regDate;
    private LocalDateTime updateDate;

    private int replyCount;

    private String mainImage;

}
