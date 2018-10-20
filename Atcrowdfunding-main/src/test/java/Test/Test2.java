package Test;

public class Test2 {

    public static void main(String[] args) {
        long start1 = System.currentTimeMillis();
        System.out.println("start1:"+start1);
        Test2.printN1(50000);
        long end1 = System.currentTimeMillis();
        System.out.println("end1:"+end1);
        System.out.println("time1:"+(end1-start1));

        long start2 = System.currentTimeMillis();
        System.out.println("start2:"+start2);
        Test2.printN1(50000);
        long end2 = System.currentTimeMillis();
        System.out.println("end2:"+end2);
        System.out.println("time2:"+(end2-start2));


    }

    public static void printN1(int N){
        for(int i=1; i<N; i++){
            System.out.println("printN1:"+i);
        }
    }

    public static void printN2(int N){
        if(N != 0){
            printN2(N-1);
            System.out.println("printN2:"+N);
        }
    }

}
