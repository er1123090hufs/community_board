package org.zerock.sp1.store;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Qualifier("america_chef")
@Repository
public class AmericanChef implements Chef{

    @Override
    public String cook(){
        return "팬케잌";
    }

}
