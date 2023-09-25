# Advanced-Digital-Systems-Project
The task is to design an 8-bit Comparator for signed 2’s complement representation numbers, and then to write a complete code for functional verification. 
Your task is to create a library element that compares 2 numbers (A and B) represented in signed 2’s complement representation and to produce 3 outputs F1(A=B), F2(A>B), and F3 (A<B).
The element must be designed using two approaches.
1. The first one is the direct adder approach where the two numbers are subtracted from each other and based on the sign of the result the output is determined.
2. The Second approach is a magnitude comparator and a sign comparator. The second approach was implemented using a bitwise XOR
   between the two numbers' magnitudes and defining the highest priority differently.
   Then that bit is compared and the output is determined.

The two approaches are compared based on delay and accuracy.
 
