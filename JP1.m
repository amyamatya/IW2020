%% Fig 1: All float locations

% useful function: extractBetween()

cd('/Users/aamatya/Desktop/JP Figs');
addpath('/Users/aamatya/Desktop');
[bio_name bio_param] = xlsread('argo_idx.xlsx');
bio_param = bio_param(2:end,:);

filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1});
levels = [shorelines.Level];
land = (levels == 1);

worldmap([-75 35],[0 165]);
scatterm(bio_name(:,2), bio_name(:,3),7 ,'filled','ro');
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('Total Indian Ocean Argo Biogeochemical Float Coverage, 01/19 - 05/20');
print(figure(1), '/Users/aamatya/Desktop/JP Figs/JPfig1','-dpng');
% close Figure 1
clear i lg1 fig1 
%% Save the float idxs as one file

floats = string(bio_param(:,1));
for i = 1:length(floats)
    floatz(i,1:4) = strsplit(floats(i), '/');
    x = num2str(bio_name(i));
    x2 = x(1:8);
    floatz(i,3) = str2num(x2);
    floatz(i,5) = bio_name(i,2); % latitude
    floatz(i,6) = bio_name(i,3); % longitude
    floatz(i,7) = bio_param(i,8);
    floatz(i,8) = bio_param(i,9);
end
clear floats x x2 i bio_param bio_name
%% Which floats have which bio parameters?

floatListz = unique(floatz(:,2));
for i = 1:length(floatListz)
    fNum = find(floatz(:,2) == floatListz(i));
    fNum= fNum(1);
    
    if str2double(floatz(fNum, 5)) <= -45
        continue
    end
    
    floatList(i,1) = floatListz(i);
    floatList(i,2) = floatz(fNum, 5);
    floatList(i,3) = floatz(fNum, 6);
    
    if contains(floatz(fNum,7), "OXY")
        floatList(i,4) = 1;
    else
        floatList(i,4) = 0;
    end
    if contains(floatz(fNum,7), "NITRATE")
        floatList(i,5) = 1;
    else
        floatList(i,5) = 0;
    end
    if contains(floatz(fNum,7), "CHLA")
        floatList(i,6) = 1;
    else
        floatList(i,6) = 0;
    end
end
floatList = rmmissing(floatList);
floatList = str2double(floatList);


clear i fNum x y z floatListz
length(find(floatList(:,4) == "1")) % Number of floats with oxygen = 79
length(find(floatList(:,5) == "1"))  % Number of floats with nitrate = 29
length(find(floatList(:,6) == "1"))  % Number of floats with chlorophyll = 62

% All Indian Ocean floats below 45S
worldmap([-75 35],[0 165]);
scatterm(floatList(:,2), floatList(:,3), 10 ,'filled','ro');
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('Sample Points: Coastal East and West Indian Ocean');
%% Extract files with biogeochemical floats

extrac = [];

for i = 1:length(floatList)
% extrac = find(floatz(:,2) == floatList(i));
extrac = [extrac find(floatz(:,2) == floatList(i))'];
end
trash = floatz(extrac,:);
clear i extrac
%% Where are the floats with with biogeochemical parameters? 

% Oxygen, October
figure(3)
ids = find(floatList(:,4) == "1");
hold on
worldmap([-75 35],[0 165]);
oxCount = 0;
for i = 1:length(ids) %finding in October
    ix = find(floatz(:,2) == floatList(ids(i), 1));
    ix = find((floatz(:,2) == floatList(ids(i), 1)) & (extractBetween(floatz(:,3), 1, 6) == "201910"));
    if isempty(ix)
        continue
    else
    scatterm(str2double(floatz(ix(1),5)), str2double(floatz(ix(1),6)), 12, 'filled','ro');
    oxCount = oxCount + 1;
    end
end
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title(['Unique Oxygen-Recording Floats in October, n = ', num2str(oxCount)]);
hold off
print(figure(3), '/Users/aamatya/Desktop/JP Figs/JPfig3','-dpng');
clear id i y h
close Figure 3

% Nitrate, October
figure(4)
ids = find(floatList(:,5) == "1");
hold on
worldmap([-75 35],[0 165]);
nitCount = 0;
for i = 1:length(ids) %finding in October
    ix = find(floatz(:,2) == floatList(ids(i), 1));
    ix = find((floatz(:,2) == floatList(ids(i), 1)) & (extractBetween(floatz(:,3), 1, 6) == "201910"));
    if isempty(ix)
        continue
    else 
    scatterm(str2double(floatz(ix(1),5)), str2double(floatz(ix(1),6)), 12, 'filled','ro');
    nitCount = nitCount + 1;
    end
end
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title(['Unique Nitrate-Recording Floats in October, n = ', num2str(nitCount)]);
hold off
print(figure(4), '/Users/aamatya/Desktop/JP Figs/JPfig4','-dpng');
clear id i y h
close Figure 4


% Chlorophyll, October
figure(5)
ids = find(floatList(:,6) == "1");
hold on
worldmap([-75 35],[0 165]);
chlCount = 0;
for i = 1:length(ids) %finding in October
    ix = find(floatz(:,2) == floatList(ids(i), 1));
    ix = find((floatz(:,2) == floatList(ids(i), 1)) & (extractBetween(floatz(:,3), 1, 6) == "201910"));
    if isempty(ix)
        continue
    else 
    scatterm(str2double(floatz(ix(1),5)), str2double(floatz(ix(1),6)), 12, 'filled','ro');
    chlCount = chlCount + 1;
    end
end
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title(['Unique Chlorophyll-Recording Floats in October, n = ', num2str(chlCount)]);
hold off
print(figure(5), '/Users/aamatya/Desktop/JP Figs/JPfig5','-dpng');
clear id i y h
close Figure 5

%% TESTING WHERE FLOATS ARE

figure(6)
worldmap([-75 35],[0 165]);
scatterm(str2double(floatList(64,2)), str2double(floatList(64,3)), 100 ,'filled','ro');
scatterm(str2double(floatList(97,2)), str2double(floatList(97,3)), 100 ,'filled','bo');
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('Sample Points: Coastal East and West Indian Ocean');
print(figure(6), '/Users/aamatya/Desktop/JP Figs/JPfig6','-dpng');







