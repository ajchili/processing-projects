// https://www.interviewcake.com/question/java/product-of-other-numbers

int[] arrayOfInts = new int[] { 1, 7, 3, 4 };

void setup() {
  for (int product : getProductsOfAllIntsExceptAtIndex(arrayOfInts)) {
    print(product + " ");
  }
}

int[] getProductsOfAllIntsExceptAtIndex(int[] arrayOfInts) {
  if (arrayOfInts.length < 2) {
    throw new ArrayIndexOutOfBoundsException("Provided array must have a length of 2 or greater!");
  }
  int[] products = new int[arrayOfInts.length];
  for (int i = 0; i < arrayOfInts.length; i++) {
    int product = 1;
    for (int j = 0; j < arrayOfInts.length; j++) {
      if (j != i) {
        product *= arrayOfInts[j];
      }
    }
    products[i] = product;
  }
  return products;
}