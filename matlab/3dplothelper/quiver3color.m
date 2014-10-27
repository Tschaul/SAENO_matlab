function quiver3color(R,U,scale,maximum,cmap),
    
%     rng(10);

    if nargin<3
        scale=1;
        maximum=0;
        cmap='jet';
    elseif nargin<4
        maximum=0;
        cmap='jet';
    elseif nargin<5
        cmap='jet';
    end

    hold on;
    
    if strcmp(cmap,'jet')
        c=colormap(jet(64));
    elseif strcmp(cmap,'hot')
        c=colormap(hot(64));
    elseif strcmp(cmap,'hsv')
        c=colormap(hsv(64));
    elseif strcmp(cmap,'cool')
        c=colormap(cool(64));
    elseif strcmp(cmap,'spring')
        c=colormap(spring(64));
    elseif strcmp(cmap,'summer')
        c=colormap(summer(64));
    elseif strcmp(cmap,'autumn')
        c=colormap(autumn(64));
    elseif strcmp(cmap,'winter')
        c=colormap(winter(64));
    elseif strcmp(cmap,'gray')
        c=colormap(gray(64));
    elseif strcmp(cmap,'bone')
        c=colormap(bone(64));
    elseif strcmp(cmap,'copper')
        c=colormap(copper(64));
    elseif strcmp(cmap,'pink')
        c=colormap(pink(64));
    elseif strcmp(cmap,'lines')
        c=colormap(lines(64));
    end
        
    
    
    l=sqrt(sum(U.^2,2));
    
    if(maximum==0) maximum=max(l); end

    for i=1:size(R,1),
        
        if(l(i)<maximum)
            
            x1=R(i,1);
            y1=R(i,2);
            z1=R(i,3);
            
            x2=R(i,1)+scale*U(i,1);
            y2=R(i,2)+scale*U(i,2);
            z2=R(i,3)+scale*U(i,3);
            
            cc=ceil( (( l(i)/maximum ) +0.000001) * 64);
            
            if(cc>64) cc=64; end
            
%             if( (l(i)/maximum)>0.1 )
%                 patch([x1 x1 x2],[y1 y1 y2],[z1 z1 z2],[0 0 0],'edgecolor',c(cc,:),'edgealpha',l(i)/maximum*0.5,'LineWidth',0.5);
%             end
            
            if( (l(i)/maximum)>rand() )
                patch([x1 x1 x2],[y1 y1 y2],[z1 z1 z2],[0 0 0],'edgecolor',c(cc,:),'LineWidth',0.5);
            end
            
        end
        
        
    end
    
    axis equal
    view(3)
    hold off

end



