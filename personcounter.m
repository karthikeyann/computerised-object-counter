function personcounter

Fs=8000;
recordtime=1000;
lower=0.05;
upper=0.100;
PLAYSOUND=0;
t= 1:2000;
sound =   2*sin(2*pi*t*1000/Fs);
count=0;    %when you restart the program, reload the old value here
sel=0;
STOPPED = 1;

% Figure Window
hfig = figure('Name','Person Counter',...
    'Numbertitle','off',...
    'Position',[600 500 350 100],...
    'Menubar','none',...
    'Resize','off',...
    'KeyPressFcn',@keyPressFcn,...
    'CloseRequestFcn',@closeRequestFcn);

% Menus
filemenu = uimenu('Label','File');
uimenu(filemenu,'Label','About','Callback',@aboutFcn);
uimenu(filemenu,'Label','Exit','Callback',@closeRequestFcn);

% Buttons
uicontrol(hfig,'Style','PushButton',...
    'Position',[10 10 75 25],...
    'String','START',...
    'Callback',@startFcn);
uicontrol(hfig,'Style','PushButton',...
    'Position',[140 10 75 25],...
    'String','RESET (R)',...
    'Callback',@resetFcn);
uicontrol(hfig,'Style','PushButton',...
    'Position',[265 10 75 25],...
    'String','EXIT (X)',...
    'Callback',@closeRequestFcn);

% Stopwatch Time Display
DISPLAY = uicontrol(hfig,'Style','text',...
    'Position',[10 45 330 55],...
    'BackgroundColor',[0.8 0.8 0.8],...
    'FontSize',35);

set(hfig,'HandleVisibility','off');


str = num2str(count);
set(DISPLAY,'String',str);

% Start the Timer
htimer = timer('TimerFcn',@timerFcn,'Period', (recordtime+500)/Fs,'ExecutionMode','FixedRate');
start(htimer);

    function timerFcn(varargin)
        if ~STOPPED
            y=wavrecord(1000,8000);
            y=y(50:end,1)-mean(y(50:end,1));
            power=sum(y.*y)
            if(power<lower)
             sel=1;
                else if(power > upper && sel==1)
                count=count+1;
                sel=0;
                str = num2str(count);
                set(DISPLAY,'String',str);
                if(PLAYSOUND)
                    wavplay(sound,Fs);
                end;
                    end;
            end;
        end
    end

    function startFcn(varargin)
        % Start the Stopwatch
        STOPPED = 0;
    end

    function resetFcn(varargin)
        % Reset the Stopwatch
        STOPPED = 1;
        count = 0;
        str = num2str(count);
        set(DISPLAY,'String',str);
    end

    function aboutFcn(varargin)
        msgbox({' Person Counter Using MATLAB',' GUI Version','',...
            ' by Karthikeyan.N  <karthi.amrita.cbe@gmail.com>'},'About');
    end

    function closeRequestFcn(varargin)
        % Stop the Timer
        try
            stop(htimer)
            delete(htimer)
        catch errmsg
            rethrow(errmsg);
        end
        % Close the Figure Window
        closereq;
    end
end