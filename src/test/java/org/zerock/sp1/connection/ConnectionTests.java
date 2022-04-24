package org.zerock.sp1.connection;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.zerock.sp1.util.ConnectionUtil;

import java.sql.Connection;
@Log4j2
public class ConnectionTests{


    @Test
    public void dbTests(){
        try {
            Connection con = ConnectionUtil.INSTANCE.getConnection();
            log.info(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}