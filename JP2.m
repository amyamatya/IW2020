%% FLOAT #5906035
addpath('/Users/aamatya/Desktop/JP/5906035');
list = dir(char("/Users/aamatya/Desktop/JP/5906035"));

for j = 4:length(list)
    % get date and id from floatz
    pos_qc = ncread(list(j).name, 'POSITION_QC');
    lat = ncread(list(j).name, 'LATITUDE');
    lon = ncread(list(j).name, 'LONGITUDE');
    pres = ncread(list(j).name, 'PRES');
    nit = ncread(list(j).name, 'NITRATE');
    cdom = ncread(list(j).name, 'CDOM'); % cdom_qc = ncread(list(j).name, 'CDOM_ADJUSTED_QC');
    chl = ncread(list(j).name, 'CHLA');
    chl_qc = ncread(list(j).name, 'CHLA_ADJUSTED_QC');
    doxy = ncread(list(j).name, 'DOXY');
    doxy_qc = ncread(list(j).name, 'DOXY_ADJUSTED_QC');
    temp_doxy = ncread(list(j).name, 'TEMP_DOXY');
    temp_doxy_qc = ncread(list(j).name, 'TEMP_DOXY_QC');
   
    if str2num(pos_qc) > 2
        continue
    end
    
%     datos{j-3} = NaN(length(pres), 8);
    datos{j-3,1}(:,1) = repmat(lat(1), length(pres), 1);
    datos{j-3,1}(:,2) = repmat(lon(1), length(pres), 1);
    datos{j-3,1}(:,3) = pres(:,1); % pressure for doxy, cdom, chl
    datos{j-3,1}(:,4) = pres(:,2); % pressure for nit
    datos{j-3,1}(:,5) = nit(:,2);
    datos{j-3,1}(:,6) = cdom(:,1);
    datos{j-3,1}(:,7) = chl(:,1);
    datos{j-3,1}(find(str2num(chl_qc(:,1)) > 2),7) = NaN;
    datos{j-3,1}(:,8) = doxy(:,1);
    datos{j-3,1}(find(str2num(doxy_qc(:,1)) > 2), 8) = NaN;
    datos{j-3,1}(:,9) = temp_doxy(:,1);
    datos{j-3,1}(find(str2num(temp_doxy_qc(:,1)) > 2), 9) = NaN;
end

clear cdom chl chl_qc doxy doxy_qc first j lat lon nit pos_qc pres 
%% FLOAT #5904846

addpath('/Users/aamatya/Desktop/JP/5904846');
list = dir(char("/Users/aamatya/Desktop/JP/5904846"));

for j = 4:length(list)
    % get date and id from floatz
    pos_qc = ncread(list(j).name, 'POSITION_QC');
    lat = ncread(list(j).name, 'LATITUDE');
    lon = ncread(list(j).name, 'LONGITUDE');
    pres = ncread(list(j).name, 'PRES');
    nit = ncread(list(j).name, 'NITRATE');
    cdom = ncread(list(j).name, 'CDOM'); % cdom_qc = ncread(list(j).name, 'CDOM_ADJUSTED_QC');
    chl = ncread(list(j).name, 'CHLA');
    chl_qc = ncread(list(j).name, 'CHLA_ADJUSTED_QC');
    doxy = ncread(list(j).name, 'DOXY');
    doxy_qc = ncread(list(j).name, 'DOXY_ADJUSTED_QC');
    temp_doxy = ncread(list(j).name, 'TEMP_DOXY');
    temp_doxy_qc = ncread(list(j).name, 'TEMP_DOXY_QC');
   
    if str2num(pos_qc) > 2
        continue
    end
    
%     datos{j-3} = NaN(length(pres), 8);
    datos{j-3,2}(:,1) = repmat(lat(1), length(pres), 1);
    datos{j-3,2}(:,2) = repmat(lon(1), length(pres), 1);
    datos{j-3,2}(:,3) = pres(:,1); % pressure for doxy, cdom, chl
    datos{j-3,2}(:,4) = pres(:,2); % pressure for nit
    datos{j-3,2}(:,5) = nit(:,2);
    datos{j-3,2}(:,6) = cdom(:,1);
    datos{j-3,2}(:,7) = chl(:,1);
    datos{j-3,2}(find(str2num(chl_qc(:,1)) > 2),7) = NaN;
    datos{j-3,2}(:,8) = doxy(:,1);
    datos{j-3,2}(find(str2num(doxy_qc(:,1)) > 2), 8) = NaN;
    datos{j-3,2}(:,9) = temp_doxy(:,1);
    datos{j-3,2}(find(str2num(temp_doxy_qc(:,1)) > 2), 9) = NaN;
end

clear cdom chl chl_qc doxy doxy_qc first j lat lon nit pos_qc pres 


%% Vid 1: Chlorophyll video 
first = find(floatz(:,2) == "5906035"); 
first = first(1);

for i = 1:35
    fig(i) = figure(i);
    hold on
    plot(datos{i,1}(:,7), datos{i,1}(:,3), 'b');
    plot(datos{i,2}(14:end,7), datos{i,2}(14:end,3), 'r');
    axis ij
    xlim([0 4]);
    ylim([0 2000]);
    pbaspect([1 2 1])
    xlabel("Chlorophyll A (mg/m^{3})");
    ylabel("Pressure (decibar)");
    x = datetime(floatz(first,3), 'InputFormat','yyyyMMdd');
    title(datestr(x, 'mmmm yyyy'));
    first = first + 1;
    [~,hObj] = legend("South Africa", "Australia", "Location", "Southeast");
    hL=findobj(hObj,'type','line');  % get the lines, not text
    set(hL,'linewidth',4);
    hold off
    f(i) = getframe(fig(i));
end

v = VideoWriter('JPvid1.mp4', 'MPEG-4');
v.FrameRate = 3;
v.Quality = 100;
open(v)
for i = 1:35
    writeVideo(v, f(i));
end
close(v)
clear f;
close all
%% Vid 2: Nitrate video 
first = find(floatz(:,2) == "5906035");
first = first(1);

for i = 1:35
    fig(i) = figure(i);
    hold on
    plot(datos{i,1}(:,5), datos{i,1}(:,4), 'b');
    plot(datos{i,2}(14:end,5), datos{i,2}(14:end,4), 'r');
    axis ij
    xlim([0 50]);
    ylim([0 2000]);
    pbaspect([1 2 1])
    xlabel("Nitrate (\mumole/kg)");
    ylabel("Pressure (decibar)");
    x = datetime(floatz(first,3), 'InputFormat','yyyyMMdd');
    title(datestr(x, 'mmmm yyyy'));
    first = first + 1;
    [~,hObj] = legend("South Africa", "Australia", "Location", "Southwest");
    hL=findobj(hObj,'type','line');  % get the lines, not text
    set(hL,'linewidth',4);
    hold off
    f(i) = getframe(fig(i));
end

v = VideoWriter('JPvid2.mp4', 'MPEG-4');
v.FrameRate = 3;
v.Quality = 100;
open(v)
for i = 1:35
    writeVideo(v, f(i));
end
close(v)
clear f;
close all
%% Vid 3: Oxygen video 
first = find(floatz(:,2) == "5906035");
first = first(1);

for i = 1:35
    fig(i) = figure(i);
    figure
    hold on
    plot(datos{i,1}(:,8), datos{i,1}(:,3), 'b');
    plot(datos{i,2}(14:end,8), datos{i,2}(14:end,3), 'r');
    axis ij
    xlim([100 250]);
    ylim([0 2000]);
    pbaspect([1 2 1])
    xlabel("Oxygen (\mumole/kg)");
    ylabel("Pressure (decibar)");
    x = datetime(floatz(first,3), 'InputFormat','yyyyMMdd');
    title(datestr(x, 'mmmm yyyy'));
    first = first + 1;
    [~,hObj] = legend("South Africa", "Australia", "Location", "Southeast");
    hL=findobj(hObj,'type','line');  % get the lines, not text
    set(hL,'linewidth',4);
    hold off
    f(i) = getframe(fig(i));
end

v = VideoWriter('JPvid3.mp4', 'MPEG-4');
v.FrameRate = 3;
v.Quality = 100;
open(v)
for i = 1:35
    writeVideo(v, f(i));
end
close(v)
clear f;
close all
%% Vid 4: Temperature Video

first = find(floatz(:,2) == "5906035");
first = first(1);

for i = 1:35
    fig(i) = figure(i);
    figure
    hold on
    plot(datos{i,1}(:,9), datos{i,1}(:,3), 'b');
    plot(datos{i,2}(14:end,9), datos{i,2}(14:end,3), 'r');
    axis ij
    xlim([0 20]);
    ylim([0 2000]);
    pbaspect([1 2 1])
    xlabel("Temp (\circC)");
    ylabel("Pressure (decibar)");
    x = datetime(floatz(first,3), 'InputFormat','yyyyMMdd');
    title(datestr(x, 'mmmm yyyy'));
    first = first + 1;
    [~,hObj] = legend("South Africa", "Australia", "Location", "Southeast");
    hL=findobj(hObj,'type','line');  % get the lines, not text
    set(hL,'linewidth',4);
    hold off
    f(i) = getframe(fig(i));
end

v = VideoWriter('JPvid4.mp4', 'MPEG-4');
v.FrameRate = 3;
v.Quality = 100;
open(v)
for i = 1:35
    writeVideo(v, f(i));
end
close(v)
clear f;
close all








