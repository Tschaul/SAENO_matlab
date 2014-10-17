function im=bfprojection(stackname,zfrom,zto)

stack=readStackSprintf(stackname,zfrom,zto);

[immin,imin]=min(stack,[],3);
[immax,imax]=max(stack,[],3);

imdi=-(imax-imin);

imdi=imdi-min(imdi(:));
imdi=imdi/max(imdi(:));
imm=log(immax./immin);
imm=imm-prctile(imm(:),1);
imm=imm/prctile(imm(:),99.5);

im=imdi.*imm;

im=medfilt2(im);