package org.zerock.sp1.store;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Qualifier("korea_chef")
@Repository
public class KoreanChef implements Chef{

    @Override
    public String cook(){
        return "불고기";
    }

}
