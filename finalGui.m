function finalGui
    %defining global component to make functions run smoothly.
    global gooey

    %creating a single figure and all edit buttons and two push buttons
    gooey.f = figure('Name','Plot Buddy','NumberTitle','off');   
    gooey.xaxis    = uicontrol('Style','edit',...
                 'String','X Axis Title','Position',[200,100,70,25]);
    gooey.yaxis    = uicontrol('Style','edit',...
                 'String','Y Axis Title','Position',[100,300,70,25]);
    gooey.fplotTitle = uicontrol('Style','edit',...
                 'String','Plot Title','Position',[250,400,70,25]);
    gooey.xvalues    = uicontrol('Style','edit',...
                 'String','(X Values,..)','Position',[315,50,70,25]);
    gooey.yvalues    = uicontrol('Style','edit',...
                 'String','(Y Values,..)','Position',[315,25,70,25]);
    gooey.resetbutton = uicontrol('Style','pushbutton',...
                 'String','Reset','Position',[50,25,70,25], 'Callback', {@reset});
    gooey.pltbutton = uicontrol('Style','pushbutton',...
                 'String','Plot, buddy!','Position',[350,400,70,25], 'Callback', {@pltUserInput});
    gooey.xlmt = uicontrol('Style','edit',...
                 'String','0 10 ','Position',[200,75,70,25]);
    gooey.xlmtdisplayMessage = uicontrol('Style','text',...
                 'String','X-Axis Lim','Position',[125,72,70,25]);     
    gooey.ylmt = uicontrol('Style','edit',...
                 'String','0 10','Position',[100,275,70,25]);
    gooey.ylmtdisplayMessage = uicontrol('Style','text',...
                 'String','Y-Axis Lim','Position',[25,270,70,25]); 
    gooey.markerdisplayMessage = uicontrol('Style','text',...
                 'String','Choose Point Marker/Color','Position',[420,370,150,25]);
    ha = axes('Units','Pixels','Position',[210,155,200,185]);    
    
    %uibutton group for changing color of markers (first set of radio
    %buttons)
    gooey.bg = uibuttongroup('Visible','on',...
                  'Position',[0.8 0.02 .13 .45],...
                  'SelectionChangedFcn',@bselection);
    r1 = uicontrol(gooey.bg,'Style',...
                      'radiobutton',...
                      'String','Red',...
                      'Position',[10 100 100 30],...
                      'HandleVisibility','on', 'Tag', '1');
    r2 = uicontrol(gooey.bg,'Style','radiobutton',...
                      'String','Blue',...
                      'Position',[10 125 100 30],...
                      'HandleVisibility','on', 'Tag', '2');
    r3 = uicontrol(gooey.bg,'Style','radiobutton',...
                      'String','Green',...
                      'Position',[10 150 100 30],...
                      'HandleVisibility','on', 'Tag', '3');

    gooey.markercolor = 'r';    %initialized default gooeymarkercolor
    
    %callback for making an output of the selection by user on first set on
    %radio buttons
    %the cases are based on the tags added to each radio button
    function bselection(source,event)
        switch get(event.NewValue,'tag') 
            case '1'     
                disp('red')
                gooey.markercolor = 'r';
            case '2'        
                disp('blue')
                gooey.markercolor = 'b';
            case '3'  
                disp('green')
                gooey.markercolor = 'g';
        end
    gooey.markercolor  
    end

    %uibutton group for changing markers (second set of radio buttons)
    gooey.bbg = uibuttongroup('Visible','on',...
                  'Position',[0.8 0.45 .13 .45],...
                  'SelectionChangedFcn',@cselection);
    r4 = uicontrol(gooey.bbg,'Style',...
                      'radiobutton',...
                      'String','*',...
                      'Position',[10 100 100 30],...
                      'HandleVisibility','on', 'Tag', '4');
    r5 = uicontrol(gooey.bbg,'Style','radiobutton',...
                      'String','+',...
                      'Position',[10 125 100 30],...
                      'HandleVisibility','on', 'Tag', '5');
    r6 = uicontrol(gooey.bbg,'Style','radiobutton',...
                      'String','.',...
                      'Position',[10 150 100 30],...
                      'HandleVisibility','on', 'Tag', '6');
    gooey.marker = '*'; %initialized default marker
    
    %callback function for recording output of user selection (second set
    %of radio buttons)
    %the cases are based on the tags added to each radio button
    function cselection(source,event)
        switch get(event.NewValue,'tag') 
        case '6'     
            disp('.')
            gooey.marker = '.';
        case '4'        
            disp('*')
            gooey.marker = '*';
        case '5'  
            disp('+')
            gooey.marker = '+';
        end
    gooey.marker
    end
        
    plot (0,0)   %empty plot upon start up 

    
    %callback for when user hits the button "plot, buddy!"
    function [] = pltUserInput(source,eventdata)
        x1 = str2num(gooey.xvalues.String);
        y1 = str2num(gooey.yvalues.String);
        %making sure only numerical values are accepted
        if isnan((gooey.xvalues.String)) 
            a = errordlg('Please enter a numerical value');
        elseif isnan(gooey.yvalues.String)
            aa = errordlg('Please enter a numerical value');
              
        else
            x2 = gooey.xlmt.String;
            y2 = gooey.ylmt.String;
            xlm = str2num(x2);
            ylm = str2num(y2);
            %making sure limits are only numerical and in two element
            %vector form
            if isvector(xlm) == false || numel(xlm) ~= 2
                bbb = errordlg('Please enter a numerical vector with 2 elements for the x limits. ');
            elseif isvector(ylm) == false || numel(ylm) ~= 2
                bb = errordlg('Please enter a numerical vector with 2 elements for the y limits.');
            else
                %if the x and y values are the same length, this will plot
                %all of the user inputs (and accept no inputs some boxes)
                if length(x1) == length(y1)
                    plot(x1,y1,'marker',gooey.marker,'color',gooey.markercolor)
                    xtitle = gooey.xaxis.String;
                    ytitle = gooey.yaxis.String;
                    mainTitle= gooey.fplotTitle.String;
                    xlabel(xtitle)
                    ylabel(ytitle)
                    title(mainTitle)
                    xlim(xlm)
                    ylim(ylm)
                else
                b = errordlg('Please enter same length for x and y values. Please only enter numerical values.');
                end
            end
        end

  

        
    end
    %switching back to default values when user hits reset button
    function [] = reset(source,event)
        hold off
        plot(0,0)
        gooey.xaxis    = uicontrol('Style','edit',...
                 'String','X Axis Title','Position',[200,100,70,25]);
        gooey.yaxis    = uicontrol('Style','edit',...
                     'String','Y Axis Title','Position',[100,300,70,25]);
        gooey.fplotTitle = uicontrol('Style','edit',...
                     'String','Plot Title','Position',[250,400,70,25]);
        gooey.xvalues    = uicontrol('Style','edit',...
                     'String','(X Values,..)','Position',[315,50,70,25]);
        gooey.yvalues    = uicontrol('Style','edit',...
                     'String','(Y Values,..)','Position',[315,25,70,25]);
        gooey.resetbutton = uicontrol('Style','pushbutton',...
                     'String','Reset','Position',[50,25,70,25], 'Callback', {@reset});
        gooey.pltbutton = uicontrol('Style','pushbutton',...
                     'String','Plot, buddy!','Position',[350,400,70,25], 'Callback', {@pltUserInput});
        gooey.xlmt = uicontrol('Style','edit',...
                     'String','0 10 ','Position',[200,75,70,25]);
        gooey.xlmtdisplayMessage = uicontrol('Style','text',...
                     'String','X-Axis Lim','Position',[125,72,70,25]);     
        gooey.ylmt = uicontrol('Style','edit',...
                     'String','0 10','Position',[100,275,70,25]);
        gooey.ylmtdisplayMessage = uicontrol('Style','text',...
                     'String','Y-Axis Lim','Position',[25,270,70,25]); 
    
    end
end