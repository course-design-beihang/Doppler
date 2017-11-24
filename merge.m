function [y]=merge(x,delta)
x1=sort(x);
x2=[x1(1)];
for i=2:length(x1)
    if x1(i)-x2(length(x2))>delta
        x2=[x2 x1(i)];
    end
end
y=x2;
    