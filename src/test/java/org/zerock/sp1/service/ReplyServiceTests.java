package org.zerock.sp1.service;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.sp1.dto.ReplyDTO;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/root-context.xml")
public class ReplyServiceTests {

    @Autowired
    private ReplyService replyService;

    @Test
    public void testInsert(){
        ReplyDTO replyDTO = new ReplyDTO();
        replyDTO.setBno(393193);
        replyDTO.setReplyText("댓글 서비스를 통한 댓글추가 기능 테스트!!! ");
        replyDTO.setReplyer("user123456");

        replyService.register(replyDTO);
    }


}
