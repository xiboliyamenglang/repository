package Test;

import java.util.Stack;

/**
 * 用2个堆栈实现队列，入队和出队
 */
public class Solution {
    Stack<Integer> stack1 = new Stack<Integer>();
    Stack<Integer> stack2 = new Stack<Integer>();

    public void push(int node) {
        stack1.push(node);
        System.out.println("push "+node);
    }

    public int pop() {
        if(stack1.empty()){
            return -1;
        }

        //将堆栈1中的元素压入堆栈2中
        do{
            stack2.push(stack1.pop());
        }while(!stack1.empty());

        //移除堆栈2栈顶元素，判空则直接返回
        int result = stack2.pop();
        if(stack2.empty()){
            return result;
        }

        //将堆栈2中的剩余元素压回堆栈1中
        do{
            stack1.push(stack2.pop());
        }while(!stack2.empty());

        return result;
    }

    public static void main(String[] args) {
        Solution solution = new Solution();
        solution.push(1);
        solution.push(2);
        solution.push(3);
        solution.pop();
        solution.pop();
        solution.push(4);
        solution.pop();
        solution.push(5);
        solution.pop();
        solution.pop();

        //["PSH1","PSH2","PSH3","POP","POP","PSH4","POP","PSH5","POP","POP"]
    }
}
