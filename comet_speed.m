function comet_speed(varargin)
%COMET3 3-D Comet-like trajectories.
%   COMET3(Z) displays an animated three dimensional plot of the vector Z.
%   COMET3(X,Y,Z) displays an animated comet plot of the curve through the
%   points [X(i),Y(i),Z(i)].
%   COMET3(X,Y,Z,p) uses a comet of length p*length(Z). Default is p = 0.1.
%
%   COMET3(AX,...) plots into AX instead of GCA.
%
%   Example:
%       t = -pi:pi/500:pi;
%       comet3(sin(5*t),cos(3*t),t)
%
%   See also COMET.

%   Charles R. Denham, MathWorks, 1989.
%   Revised 2-9-92, LS and DTP; 8-18-92, 11-30-92 CBM.
%   Copyright 1984-2006 The MathWorks, Inc.

% Parse possible Axes input
[ax,args,nargs] = axescheck(varargin{:});

error(nargchk(1,4,nargs,'struct'));

% Parse the rest of the inputs
if nargs < 2, x = args{1}; end
if nargs == 2, y = args{2}; end
if nargs < 3, z = x; x = 1:length(z); y = 1:length(z); end
if nargs == 3, [x,y,z] = deal(args{:}); end
if nargs < 4, p = 0.10; end
if nargs == 4, [x,y,z,p] = deal(args{:}); end

if ~isscalar(p) || ~isreal(p) || p < 0 || p >= 1
    error(message('MATLAB:comet3:InvalidP'));
end

ax = newplot(ax);
if ~ishold(ax),
    [minx,maxx] = minmax(x);
    [miny,maxy] = minmax(y);
    [minz,maxz] = minmax(z);
    axis(ax,[minx maxx miny maxy minz maxz])
end

co = get(ax,'colororder');


if size(co,1)>=3
    colors = [ co(1,:);co(2,:);co(3,:)];
    lstyle = '-';
else
    colors = repmat(co(1,:),3,1);
    lstyle ='--';
end

m = length(z);
k = round(p*m);

head = line('parent',ax,'color',colors(1,:),'marker','o', ...
    'xdata',x(1),'ydata',y(1),'zdata',z(1),'tag','head');

if matlab.graphics.internal.isGraphicsVersion1
    % Choose first three colors for head, body, and tail
    set(head,'erasemode','xor');
    body = line('parent',ax,'color',colors(2,:),'linestyle',lstyle,'erase','none', ...
        'xdata',[],'ydata',[],'zdata',[],'Tag','body');
    tail = line('parent',ax,'color',colors(3,:),'linestyle','-','erase','none', ...
        'xdata',[],'ydata',[],'zdata',[],'Tag','tail');
    
    % Primary loop
    m = length(x);
    for i = k+2:m
        j = i-1:i;
        set(head,'xdata',x(i),'ydata',y(i),'zdata',z(i))
        set(body,'xdata',x(j),'ydata',y(j),'zdata',z(j))
        set(tail,'xdata',x(j-k),'ydata',y(j-k),'zdata',z(j-k))
        drawnow
    end
    
    % Clean up the tail
    for i = m+1:m+k
        j = i-1:i;
        set(tail,'xdata',x(j-k),'ydata',y(j-k),'zdata',z(j-k))
        drawnow
    end
    
else
    
    % ~GraphicsVersion1 implementation    
    % Choose first three colors for head, body, and tail
    body = animatedline('parent',ax,'color',colors(2,:),'linestyle',lstyle,...
                        'MaximumNumPoints',max(1,k),'Tag','body');
    tail = animatedline('parent',ax,'color',colors(3,:),'linestyle','-',...
                        'MaximumNumPoints',1+m, 'Tag','tail');
    
    if ( length(x) < 2000 )
        updateFcn = @()drawnow;
    else
        updateFcn = @()drawnow('update');
    end
    
    % Grow the body
    for i = 1:k
        set(head,'xdata',x(i),'ydata',y(i),'zdata',z(i))
        addpoints(body,x(i),y(i),z(i));
        updateFcn();
    end
    drawnow;
    
    % Primary loop
    m = length(x);
    for i = k+1:m
        set(head,'xdata',x(i),'ydata',y(i),'zdata',z(i))
        addpoints(body,x(i),y(i),z(i));
        addpoints(tail,x(i-k),y(i-k),z(i-k));
        updateFcn();
    end
    drawnow;
    % Clean up the tail
    for i = m+1:m+k
        addpoints(tail, x(i-k),y(i-k),z(i-k));
        updateFcn();
    end
    drawnow
    
    
end




% same subfunction as in comet
function [minx,maxx] = minmax(x)
minx = min(x(isfinite(x)));
maxx = max(x(isfinite(x)));
if minx == maxx
    minx = maxx-1;
    maxx = maxx+1;
end
