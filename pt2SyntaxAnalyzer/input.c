for(int i = 0, j = 0, l = 0; i < j; i++, j++) {
    for(int k = 0; k < i; k++) {
        if(i == j) {
            k = k + 1;
        }
        else {
            k = k - 1;
        }
    }
}