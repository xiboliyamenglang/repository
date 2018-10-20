package Test;

public class Test3 {

    public static int test(int k, int[] m){
        int max = 0;
        int current = 0;
        for(int i=0; i<k; i++){ //子列左侧位置
            current += m[i];
            if(current > max){
                max = current;
            }else if(current < 0){
                current = 0;
            }
        }
        return max;
    }

    public static void main(String[] args) {
        int[] m = {-2,6,-1,13,2,-5};
        Test3.test(6,m);
    }
}
