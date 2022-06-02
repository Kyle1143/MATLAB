%%a_read.m
a = arduino('COM3');
a.analogReference('default')
tic
while(toc<10)
    ain = a.analogRead(0)*(5/1023);
    fprintf('Voltage = %f\n',ain)
    pause(0.5);
end
delete(a);
