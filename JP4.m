%% All Indian Ocean floats below 45S
filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1});
levels = [shorelines.Level];
land = (levels == 1);

figure(7)
hold on
worldmap([-75 35],[0 165]);
for i = 1:length(argo)
    scatterm(argo(i).float(1).lat, argo(i).float(1).lon, 10 ,'filled','ro');
end
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('All Float Locations in Indian Ocean');
hold off

print(figure(7), '/Users/aamatya/Desktop/JP Figs/JPfig7','-dpng','-r350');
%% Arabian and Bengal IDS

% 4 = oxy, 5 = nitrate, 6 = chl
arabianID = [];
for i = 1:length(argo)
    if argo(i).lat > 0 & argo(i).lon < 80
        arabianID = [arabianID i];
    end
end

bengalID = [];
for i = 1:length(argo)
    if argo(i).lat > 0 & argo(i).lon > 80
        bengalID = [bengalID i];
    end
end

figure(8)
hold on
worldmap([-75 35],[0 165]);
for i = 1:length(arabianID)
    s1 = scatterm(argo(arabianID(i)).float(1).lat, argo(arabianID(i)).float(1).lon, 10 ,'filled','ro');
end

for i = 1:length(bengalID)
    s2 = scatterm(argo(bengalID(i)).float(1).lat, argo(bengalID(i)).float(1).lon, 10 ,'filled','bo');
end
legend([s1 s2], 'Arabian Sea','Bay of Bengal');
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('All floats in Indian Ocean');
hold off
% print(figure(8), '/Users/aamatya/Desktop/JP Figs/JPfig8','-dpng');
%% Arabian Sea, Oxygen

% OXYGEN: all indices valid

months = {'201901','201902','201903','201904','201905','201906','201907','201908','201909','201910',...
    '201911','201912','202001','202002','202003','202004'};

for k = 1:16
    arab = [];
    for i = 1:length(arabianID)
        for j = 1:length(argo(arabianID(i)).float)
            if extractBetween(string(argo(arabianID(i)).float(j).date), 1, 6) == months(k) & ...
                    length(argo(arabianID(i)).float(j).doxy) == 300
                arab = [arab extractfield(argo(arabianID(i)).float(j), 'doxy')'];
            end
        end
    end
    
    arab(find(arab == Inf)) = NaN;
    
    for l = 1:length(arab)
            arabDat(l,k) = nanmean(arab(l,:));
    end
        
end

for k = 1:16
    bengal = [];
    for i = 1:length(bengalID)
        for j = 1:length(argo(bengalID(i)).float)
            if extractBetween(string(argo(bengalID(i)).float(j).date), 1, 6) == months(k) & ...
                    length(argo(bengalID(i)).float(j).doxy) == 300
                bengal = [bengal extractfield(argo(bengalID(i)).float(j), 'doxy')'];
                
            end
        end
    end
    
    bengal(find(bengal == Inf)) = NaN;
    
    for l = 1:length(bengal)
            bengalDat(l,k) = nanmean(bengal(l,:));
    end
        
end

%% Bengal v. Arabian Oxygen
figure,
% subplot(2,1,1)
surf(1:9, 1:5:300, bengalDat(1:60,1:9));
% surf(1:9, 1:5:900, arabDat(1:180,1:9));
% scatter(1:9, 1:5:1500, 10, bengalDat(:,1:9));
colormap(jet);
colorbar
title('Oxygen in Bay of Bengal')
view(0,90)
axis ij
shading interp
xlabel('Time');
ylabel('Depth');

%% Single points - Oxygen

addpath('/Users/aamatya/Desktop/SOCCOM/Open Source Functions/suplabel');
% Arabian - argo(4).float
% Bengal argo(30)

for i = 1:28
    dat1(:,i) = argo(4).float(i).doxy;
end

for i = 1:300
    dat1New(i,1) = nanmean(dat1(i, 1:3));
    dat1New(i,2) = nanmean(dat1(i, 4:6));
    dat1New(i,3) = nanmean(dat1(i, 7:9));
    dat1New(i,4) = nanmean(dat1(i, 10:12));
    dat1New(i,5) = nanmean(dat1(i, 13:15));
    dat1New(i,6) = nanmean(dat1(i, 16:18));
    dat1New(i,7) = nanmean(dat1(i, 19:22));
    dat1New(i,8) = nanmean(dat1(i, 23:25));
    dat1New(i,9) = nanmean(dat1(i, 26:28));
end


for i = 1:53
    dat2(:,i) = argo(30).float(i).doxy;
end

for i = 1:300
    dat2New(i,1) = nanmean(dat2(i, 1:6));
    dat2New(i,2) = nanmean(dat2(i, 7:11));
    dat2New(i,3) = nanmean(dat2(i, 12:17));
    dat2New(i,4) = nanmean(dat2(i, 18:23));
    dat2New(i,5) = nanmean(dat2(i, 24:30));
    dat2New(i,6) = nanmean(dat2(i, 31:36));
    dat2New(i,7) = nanmean(dat2(i, 37:42));
    dat2New(i,8) = nanmean(dat2(i, 43:48));
    dat2New(i,9) = nanmean(dat2(i, 49:53));
end

% figure,
% subplot(2,1,1)
% surf(1:9, 15:5:200, dat1New(3:40,:))
% view(0,90)
% colormap(jet)
% shading interp
% axis ij tight
% colorbar
% xlabel('Time');
% ylabel('Depth');
% title('Oxygen in the Arabian Sea');
% caxis([0 200])
% 
% subplot(2,1,2)
% surf(1:9, 1:5:200, dat2New(1:40,:))
% view(0,90)
% colormap(jet)
% shading interp
% axis ij tight
% colorbar
% xlabel('Time');
% ylabel('Depth');
% title('Oxygen in the Bay of Bengal');
% caxis([0 200])

figure(9)
subplot(4,1,1)
surf(1:28, 15:5:1200, dat1(3:240,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(a) \bf Arabian Sea, 0 - 1200m');
caxis([0 200])

subplot(4,1,2)
surf(1:53, 15:5:1200, dat2(3:240,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(b) \bf Bay of Bengal, 0 - 1200m');
caxis([0 200])

subplot(4,1,3)
surf(1:28, 15:5:150, dat1(3:30,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(c) \bf Arabian Sea, 0 - 150m');
caxis([0 200])

subplot(4,1,4)
surf(1:53, 15:5:150, dat2(3:30,:))
xticks(linspace(4,54,10));
xticklabels({'01/19','02/19','03/19','04/19','05/19','06/19','07/19','08/19','09/19'});
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(d) \bf Bay of Bengal, 0 - 150m');
caxis([0 200])

suptitle('Oxygen ({\mu}mol/L)');
suplabel('Depth (m)','y');

sl = suplabel('Time (mm/yy)','x');
slPos = get(sl, 'position');
slPos(2) = 0.09;
set(sl, 'position' , slPos);

% set(gcf,'papersize',[6 9])    

% print(figure(9),'/Users/aamatya/Desktop/JP Figs/JPfig9','-dpng','-r350');
clear dat1 dat2 dat1New dat2New
%% %% Single points - Chlorophyll

% Arabian - argo(5).float
% Bengal argo(30)

for i = 1:28
    dat1(:,i) = argo(5).float(i).chl;
end

for i = 1:300
    dat1New(i,1) = nanmean(dat1(i, 1:3));
    dat1New(i,2) = nanmean(dat1(i, 4:6));
    dat1New(i,3) = nanmean(dat1(i, 7:9));
    dat1New(i,4) = nanmean(dat1(i, 10:12));
    dat1New(i,5) = nanmean(dat1(i, 13:15));
    dat1New(i,6) = nanmean(dat1(i, 16:18));
    dat1New(i,7) = nanmean(dat1(i, 19:21));
    dat1New(i,8) = nanmean(dat1(i, 22:25));
    dat1New(i,9) = nanmean(dat1(i, 26:28));
end



for i = 1:53
    dat2(:,i) = argo(30).float(i).chl;
end

for i = 1:300
    dat2New(i,1) = nanmean(dat2(i, 1:6));
    dat2New(i,2) = nanmean(dat2(i, 7:11));
    dat2New(i,3) = nanmean(dat2(i, 12:17));
    dat2New(i,4) = nanmean(dat2(i, 18:23));
    dat2New(i,5) = nanmean(dat2(i, 24:30));
    dat2New(i,6) = nanmean(dat2(i, 31:36));
    dat2New(i,7) = nanmean(dat2(i, 37:42));
    dat2New(i,8) = nanmean(dat2(i, 43:48));
    dat2New(i,9) = nanmean(dat2(i, 49:53));
end


for i = 1:55
    dat3New(:,i) = argo(27).float(i).chl;
end

% figure,
% subplot(2,1,1)
% surf(1:9, 15:5:200, dat1New(3:40,:))
% view(0,90)
% colormap(jet)
% shading interp
% axis ij tight
% colorbar
% xlabel('Time');
% ylabel('Depth');
% title('Oxygen in the Arabian Sea');
% caxis([0 1.5])
% 
% subplot(2,1,2)
% surf(1:9, 1:5:200, dat2New(1:40,:))
% view(0,90)
% colormap(jet)
% shading interp
% axis ij tight
% colorbar
% xlabel('Time');
% ylabel('Depth');
% title('Oxygen in the Bay of Bengal');
% caxis([0 1.5])

figure(10)
subplot(3,1,1)
surf(1:28, 15:5:200, dat1(3:40,:))
set(gca,'XTick',[])
view(0,90)
colormap(viridis)
shading interp
axis ij tight
colorbar
title('\rm (a) \bf Chlorophyll (mg/m^{-3}), Arabian Sea');
caxis([0 1])

subplot(3,1,2)
surf(1:55, 15:5:200, dat3New(3:40,:))
set(gca,'XTick',[])
view(0,90)
colormap(viridis)
shading interp
axis ij tight
colorbar
title('\rm(b) \bf Chlorophyll (mg/m^{-3}), Tip of India');
caxis([0 1])

subplot(3,1,3)
surf(1:53, 1:5:200, dat2(1:40,:))
view(0,90)
colormap(viridis)
shading interp
axis ij tight
colorbar
xticks(linspace(4,54,10));
xticklabels({'01/19','02/19','03/19','04/19','05/19','06/19','07/19','08/19','09/19'});
title('\rm(c) \bf Chlorophyll (mg/m^{-3}), Bay of Bengal');
caxis([0 1])


suplabel('Depth (m)','y');
sl = suplabel('Time (mm/yy)','x');
slPos = get(sl, 'position');
slPos(2) = 0.09;
set(sl, 'position' , slPos);
% print(figure(10),'/Users/aamatya/Desktop/JP Figs/JPfig10','-dpng','-r350');
clear dat1 dat2 dat1New dat2New dat3New
%% Single points - Temp

% Arabian - argo(4).float
% Bengal argo(30)

for i = 1:28
    dat1(:,i) = argo(4).float(i).temp;
end

for i = 1:300
    dat1New(i,1) = nanmean(dat1(i, 1:3));
    dat1New(i,2) = nanmean(dat1(i, 4:6));
    dat1New(i,3) = nanmean(dat1(i, 5:9));
    dat1New(i,4) = nanmean(dat1(i, 10:12));
    dat1New(i,5) = nanmean(dat1(i, 13:15));
    dat1New(i,6) = nanmean(dat1(i, 16:18));
    dat1New(i,7) = nanmean(dat1(i, 19:22));
    dat1New(i,8) = nanmean(dat1(i, 23:25));
    dat1New(i,9) = nanmean(dat1(i, 26:27));
end


for i = 1:53
    dat2(:,i) = argo(30).float(i).temp;
end

for i = 1:300
    dat2New(i,1) = nanmean(dat2(i, 1:6));
    dat2New(i,2) = nanmean(dat2(i, 7:11));
    dat2New(i,3) = nanmean(dat2(i, 12:17));
    dat2New(i,4) = nanmean(dat2(i, 18:23));
    dat2New(i,5) = nanmean(dat2(i, 24:30));
    dat2New(i,6) = nanmean(dat2(i, 31:36));
    dat2New(i,7) = nanmean(dat2(i, 37:42));
    dat2New(i,8) = nanmean(dat2(i, 43:48));
    dat2New(i,9) = nanmean(dat2(i, 49:53));
end


for i = 1:55
    dat3New(:,i) = argo(27).float(i).temp;
end

% figure,
% subplot(2,1,1)
% surf(1:9, 15:5:200, dat1New(3:40,:))
% view(0,90)
% colormap(jet)
% shading interp
% axis ij tight
% colorbar
% xlabel('Time');
% ylabel('Depth');
% title('Oxygen in the Arabian Sea');
% caxis([26 30])
% 
% subplot(2,1,2)
% surf(1:9, 1:5:200, dat2New(1:40,:))
% view(0,90)
% colormap(jet)
% shading interp
% axis ij tight
% colorbar
% xlabel('Time');
% ylabel('Depth');
% title('Oxygen in the Bay of Bengal');
% caxis([26 30])


figure(11)
subplot(3,1,1)
surf(1:28, 15:5:200, dat1(3:40,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(a) \bf Temperature (^{\circ}C), Arabian Sea');
caxis([26 30])

subplot(3,1,2)
surf(1:55, 15:5:200, dat3New(3:40,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(b) \bf Temperature (^{\circ}C), Tip of India');
caxis([26 30])

subplot(3,1,3)
surf(1:53, 1:5:200, dat2(1:40,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('\rm(c)\bf Temperature (^{\circ}C), Bay of Bengal');
xticks(linspace(4,54,10));
xticklabels({'01/19','02/19','03/19','04/19','05/19','06/19','07/19','08/19','09/19'});
caxis([26 30])
suplabel('Depth (m)','y');

sl = suplabel('Time (mm/yy)','x');
slPos = get(sl, 'position');
slPos(2) = 0.09;
set(sl, 'position' , slPos);
% print(figure(11),'/Users/aamatya/Desktop/JP Figs/JPfig11','-dpng','-r350');


clear dat1 dat2 dat1New dat2New dat3New
