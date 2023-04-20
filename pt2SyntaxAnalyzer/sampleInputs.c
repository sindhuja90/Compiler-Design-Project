for(;;) {
    i = 2 * 3;
}

for(int i = 10;;) {
    i = 2 * 3;
}

for(; i < 10 ;) {
    i = 2 * 3;
}

for(;; i++) {
    i = 2 * 3;
}

for(int i = 0, j = 0; i < j; i++, j++) {
    i = 2 * 3;
}

for(int i = 0; i < 10; i++) {
    if(i == j) {
        j = j + 1;
    }
}

for(int i = 0; i < 10; i++) {
    if(i == j) {
        j = j + 1;
    }
    else {
        j = j - 1;
    }
}

for(int i = 0; i < 10; i++) {
    for(int j = 0; j < i; j++) {
        if(i == j) {
            j = j + 1;
        }
    }
}

for(int i = 0, j = 0; i < j; i++, j++) {
    for(int k = 0; k < i; k++) {
        if(i == j) {
            k = k + 1;
        }
        else {
            k = k - 1;
        }
    }
}