F=[5555]
fid1 = fopen('test.txt','a+');
fprintf(fid1,' %i\n',F);
fclose(fid1);

fid1 = fopen('test.txt','r');
A = fscanf(fid1,'%f');
fclose(fid1);

