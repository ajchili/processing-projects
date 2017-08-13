// https://www.interviewcake.com/question/java/highest-product-of-3

int[] arrayOfInts = new int[]{ 1, 10, -5, 1, -100 };

void setup() {
  int[] array = getHighestProduct(3, arrayOfInts);
  int product = 1;
  for (int i : array) {
    print(i + " ");
    product *= i;
  }
  print("\nProduct: " + product);
  System.exit(0);
}

int[] getHighestProduct(int size, int[] arrayOfInts) {
  if (size > arrayOfInts.length) {
    throw new ArrayIndexOutOfBoundsException("Provided array of integers is not large enough.");
  }
  int[] highestInts = new int[size];
  int[] lowestInts = new int[size - (size % 2)];
  int numOfNegatives = 0;
  for (int current : arrayOfInts) {
    if (current > 0) {
      for (int i = 0; i < highestInts.length; i++) {
        if (current > highestInts[i]) {
          for (int j = highestInts.length - 1; j > i; j--) {
            highestInts[j] = highestInts[j - 1];
          }
          highestInts[i] = current;
          break;
        }
      }
    } else {
      for (int i = 0; i < lowestInts.length; i++) {
        if (current < lowestInts[i]) {
          for (int j = lowestInts.length - 1; j > i; j--) {
            lowestInts[j] = lowestInts[j - 1];
          }
          lowestInts[i] = current;
          numOfNegatives++;
          break;
        }
      }
    }
  }
  if (numOfNegatives % 2 == 0) {
    for (int negative : lowestInts) {
      if (negative < 0) {
        for (int i = 0; i < highestInts.length; i++) {
          if (negative * -1 > highestInts[i]) {
            for (int j = highestInts.length - 1; j > i; j--) {
              highestInts[j] = highestInts[j - 1];
            }
            highestInts[i] = negative;
            break;
          }
        }
      }
    }
  }
  return highestInts;
}