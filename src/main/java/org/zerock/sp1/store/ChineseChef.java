package org.zerock.sp1.store;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("china_chef")
public class ChineseChef implements Chef{

    @Override
    public String cook(){
        return "짜장면";
    }

}
