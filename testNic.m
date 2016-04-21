clear all;
nic = nic();
nic = nic.receive(100);
nic = nic.receive(200);
nic.buffer
nic = nic.send();
nic.buffer