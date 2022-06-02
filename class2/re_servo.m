%%re_servo.m
a = arduino('COM3');
a.servoAttach(10);
a.servoWrite(10,90);
disp('90')
pause(2);
for i=1:5
    a.servoWrite(10,90+45);
    disp('90+45')
    pause(1);
    a.servoWrite(10,90-45');
    disp('90-45')
    pause(1);
end
a.servoWrite(10,90);
disp('90')
pause(2);
a.servoDetach(10);
delete(a);