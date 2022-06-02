%% led_blink2.m
a = arduino('COM3');
a.pinMode(11,'output');
for i=1:10
    for j=0:255
        a.analogWrite(11,j);
        pause(0.01);
    end
end
delete(a);
