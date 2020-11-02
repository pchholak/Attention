function sec_sum = getTimeSec()
clock_start_b=clock;  sec_sum =  clock_start_b(4)*60*60 + clock_start_b(5)*60 + clock_start_b(6);