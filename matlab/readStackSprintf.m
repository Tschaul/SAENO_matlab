function stack=readStackSprintf(namestr, from, to)

    sz=to-from;
    
    im=rgb2gray(imread(sprintf(namestr,from)));
    
    [sx,sy]=size(im);
    
    stack=zeros(sx,sy,sz);
    
    stack(:,:,1)=im;
    
    for i=2:sz
       
        stack(:,:,i)=rgb2gray(imread(sprintf(namestr,i+from-1)));
        
    end
    
    
end