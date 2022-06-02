%%sw_count.m
a = arduino('COM3');
pin = 12;
a.pinMode(pin,'input');
c = 0; %counter
s = 0; %state
while(c < 10)
    din = a.digitalRead(pin);
    if(din == 0 && s ==0)
        c = c + 1;
        fprintf('c = %d\n',c);
        s = 1;
    end
    if(din == 1 && s == 1)
        s = 0;
    end
end
delete(a);
