function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%
% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
% 25x401
                 
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
%10x26

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1)); %25x401
Theta2_grad = zeros(size(Theta2)); %10*26

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%

% 5000 training examples
% 20x20 = 400 grid 
% 5000*400 X
% 1x5000 y

% layer 1 = 25 layers
% layer 2 = 10 layers(0~9, 0=>labeled as 10)


zeta0 = [ones(m,1), X]*Theta1'; % 5000*(400+1)*401*25 
sig1 = sigmoid(zeta0);  %5000*25

zeta1 = [ones(size(sig1 ,1),1), sig1]*Theta2'; % 5000*(25+1)*26*10
H = sig2 = sigmoid(zeta1);  %5000*10

Y=zeros(m,num_labels); %matrix 5000 * num_labels(10)

for i = 1:m,
  Y(i,y(i)) =1;  % (i,y^(i)) size = 5000*10
end;


J = (1/m)*sum(sum(-Y.*log(H)-(1-Y).*log(1-H)));

% Y size 5000*10
% log(H) size 5000*10
%¢²¢²A.?B=am+bn+co+dp+eq+fr if the sizes are equal
%https://www.coursera.org/learn/machine-learning/discussions/all/threads/AzIrrO7wEeaV3gonaJwAFA

reg = (lambda/(2*m))*(sum(sum(Theta1(:,2:end).^2))+sum(sum(Theta2(:,2:end).^2)));
%remove theta(:,1) 

J = reg + J;

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%

Del3 = H-Y; % Delta(3) = a-y, 5000*10

Del2 = (Del3*Theta2);  
% delta(L) = delta(L+1) * theta(L).*a(L).*(1-a(L))

%delta(2) = delta(3) * theta(2)
% 5000*10 * 10 * 26 -> 5000*26

Del2 = Del2.*[ones(size(zeta0,1),1) sigmoidGradient(zeta0)];

%delta(2) = del(2).*G'(zeta0)
% (5000*26) .* (5000*(25+1))

Del2 = Del2(:,2:end); 
% 5000*25,remove first column of del2

Theta1_grad = (1/m)*Del2'*[ones(m,1), X]; %25x(400+1)
Theta2_grad = (1/m)*Del3'*[ones(size(sig1 ,1),1), sig1]; %10*(25+1)
% theta_grad(i) = (1/m)*zeta(i)*delta(i+1)



% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

temp1 = Theta1;
temp2 = Theta2;

temp1(:,1)=0;
temp2(:,1)=0; % column   

Theta1_grad = Theta1_grad + (lambda/m)*temp1;
Theta2_grad = Theta2_grad + (lambda/m)*temp2;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
