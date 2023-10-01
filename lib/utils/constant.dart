 enum Chatfilter {Number, Resume, Video, Interest}



   int completeint(int complete) {
    int value = 0;
    if (complete > 0 && complete <= 10) {
      value = 9;
    } else if (complete > 10 && complete <= 20) {
      value = 8;
    } else if (complete > 20 && complete <= 30) {
      value = 7;
    } else if (complete > 30 && complete <= 40) {
      value = 6;
    } else if (complete > 40 && complete <= 50) {
      value = 5;
    } else if (complete > 50 && complete <= 60) {
      value = 4;
    } else if (complete > 60 && complete <= 70) {
      value = 3;
    } else if (complete > 70 && complete <= 80) {
      value = 2;
    } else if (complete > 80 && complete <= 90) {
      value = 1;
    } else if (complete > 90 && complete <= 100) {
      value = 0;
    }
    return value;
  }