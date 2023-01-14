%% South Africa v Australia

% 4 = oxy, 5 = nitrate, 6 = chl
afrID = [];
for i = 1:length(argo)
    if argo(i).lat > -40 & argo(i).lat < 0 & argo(i).lon < 60
        afrID = [afrID i];
    end
end


ausID = [];
for i = 1:length(argo)
    if argo(i).lat > -45 & argo(i).lat < 0 & argo(i).lon > 140
        ausID = [ausID i];
    end
end

figure(8)
hold on
worldmap([-75 35],[0 165]);
for i = 1:length(afrID)
    s1 = scatterm(argo(afrID(i)).float(1).lat, argo(afrID(i)).float(1).lon, 10 ,'filled','ro');
end

for i = 1:length(ausID)
    s2 = scatterm(argo(ausID(i)).float(1).lat, argo(ausID(i)).float(1).lon, 10 ,'filled','bo');
end
legend([s1 s2], 'Africa','Australia');
geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('All floats in Indian Ocean');
hold off

%% Single point - oxygen
% afr = 52, aus = 46, may 2019 to apr 2020


for i = 1:35
    dat1(:,i) = argo(52).float(i).doxy;
end

for i = 1:300
    dat1New(i,1) = nanmean(dat1(i, 1:3));
    dat1New(i,2) = nanmean(dat1(i, 4:6));
    dat1New(i,3) = nanmean(dat1(i, 7:9));
    dat1New(i,4) = nanmean(dat1(i, 10:11));
    dat1New(i,5) = nanmean(dat1(i, 12:14));
    dat1New(i,6) = nanmean(dat1(i, 15:17));
    dat1New(i,7) = nanmean(dat1(i, 18:20));
    dat1New(i,8) = nanmean(dat1(i, 21:23));
    dat1New(i,9) = nanmean(dat1(i, 24:26));
    dat1New(i,10) = nanmean(dat1(i, 27:29));
    dat1New(i,11) = nanmean(dat1(i, 30:32));
    dat1New(i,12) = nanmean(dat1(i, 33:35));
end


for i = 1:37
    dat2(:,i) = argo(46).float(i).doxy;
end

for i = 1:300
    dat2New(i,1) = nanmean(dat2(i, 13:15));
    dat2New(i,2) = nanmean(dat2(i, 16:18));
    dat2New(i,3) = nanmean(dat2(i, 19:21));
    dat2New(i,4) = nanmean(dat2(i, 22:25));
    dat2New(i,5) = nanmean(dat2(i, 26:28));
    dat2New(i,6) = nanmean(dat2(i, 29:31));
    dat2New(i,7) = nanmean(dat2(i, 32:34));
    dat2New(i,8) = nanmean(dat2(i, 35:37));
    dat2New(i,9) = nanmean(dat2(i, 38:40));
    dat2New(i,10) = nanmean(dat2(i, 41:43));
    dat2New(i,11) = nanmean(dat2(i, 44:46));
    dat2New(i,12) = nanmean(dat2(i, 47:49));
end

figure,
subplot(2,1,1)
surf(1:12, 10:5:1500, dat1New(2:300,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
xlabel('Time');
ylabel('Depth');
title('Oxygen in South Africa');
caxis([0 300])

subplot(2,1,2)
surf(1:12, 10:5:1500, dat2New(2:300,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
xlabel('Time');
ylabel('Depth');
title('Oxygen in Australia');
caxis([0 300])

clear dat1 dat2 dat1New dat2New
%% chlorophyll


for i = 1:35
    dat1(:,i) = argo(52).float(i).chl;
end

for i = 1:300
    dat1New(i,1) = nanmean(dat1(i, 1:3));
    dat1New(i,2) = nanmean(dat1(i, 4:6));
    dat1New(i,3) = nanmean(dat1(i, 7:9));
    dat1New(i,4) = nanmean(dat1(i, 10:11));
    dat1New(i,5) = nanmean(dat1(i, 12:14));
    dat1New(i,6) = nanmean(dat1(i, 15:17));
    dat1New(i,7) = nanmean(dat1(i, 18:20));
    dat1New(i,8) = nanmean(dat1(i, 21:23));
    dat1New(i,9) = nanmean(dat1(i, 24:26));
    dat1New(i,10) = nanmean(dat1(i, 27:29));
    dat1New(i,11) = nanmean(dat1(i, 30:32));
    dat1New(i,12) = nanmean(dat1(i, 33:35));
end


for i = 1:37
    dat2(:,i) = argo(46).float(i + 12).chl;
end

for i = 1:300
    dat2New(i,1) = nanmean(dat2(i, 13-12:15-12));
    dat2New(i,2) = nanmean(dat2(i, 16-12:18-12));
    dat2New(i,3) = nanmean(dat2(i, 19-12:21-12));
    dat2New(i,4) = nanmean(dat2(i, 22-12:25-12));
    dat2New(i,5) = nanmean(dat2(i, 26-12:28-12));
    dat2New(i,6) = nanmean(dat2(i, 29-12:31-12));
    dat2New(i,7) = nanmean(dat2(i, 32-12:34-12));
    dat2New(i,8) = nanmean(dat2(i, 35-12:37-12));
    dat2New(i,9) = nanmean(dat2(i, 38-12:40-12));
    dat2New(i,10) = nanmean(dat2(i, 41-12:43-12));
    dat2New(i,11) = nanmean(dat2(i, 44-12:46-12));
    dat2New(i,12) = nanmean(dat2(i, 47-12:49-12));
end

figure,
subplot(2,1,1)
surf(1:12, 10:5:200, dat1New(2:40,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
xlabel('Time');
ylabel('Depth');
title('Oxygen in South Africa');
caxis([0 1.3])

subplot(2,1,2)
surf(1:12, 10:5:200, dat2New(2:40,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
xlabel('Time');
ylabel('Depth');
title('Oxygen in Australia');
caxis([0 1.3])

clear dat1 dat2 dat1New dat2New

%% oxygen


for i = 1:35
    dat1(:,i) = argo(52).float(i).doxy;
end

for i = 1:300
    dat1New(i,1) = nanmean(dat1(i, 1:3));
    dat1New(i,2) = nanmean(dat1(i, 4:6));
    dat1New(i,3) = nanmean(dat1(i, 7:9));
    dat1New(i,4) = nanmean(dat1(i, 10:11));
    dat1New(i,5) = nanmean(dat1(i, 12:14));
    dat1New(i,6) = nanmean(dat1(i, 15:17));
    dat1New(i,7) = nanmean(dat1(i, 18:20));
    dat1New(i,8) = nanmean(dat1(i, 21:23));
    dat1New(i,9) = nanmean(dat1(i, 24:26));
    dat1New(i,10) = nanmean(dat1(i, 27:29));
    dat1New(i,11) = nanmean(dat1(i, 30:32));
    dat1New(i,12) = nanmean(dat1(i, 33:35));
end


for i = 1:37
    dat2(:,i) = argo(46).float(i + 12).doxy;
end

for i = 1:300
    dat2New(i,1) = nanmean(dat2(i, 13-12:15-12));
    dat2New(i,2) = nanmean(dat2(i, 16-12:18-12));
    dat2New(i,3) = nanmean(dat2(i, 19-12:21-12));
    dat2New(i,4) = nanmean(dat2(i, 22-12:25-12));
    dat2New(i,5) = nanmean(dat2(i, 26-12:28-12));
    dat2New(i,6) = nanmean(dat2(i, 29-12:31-12));
    dat2New(i,7) = nanmean(dat2(i, 32-12:34-12));
    dat2New(i,8) = nanmean(dat2(i, 35-12:37-12));
    dat2New(i,9) = nanmean(dat2(i, 38-12:40-12));
    dat2New(i,10) = nanmean(dat2(i, 41-12:43-12));
    dat2New(i,11) = nanmean(dat2(i, 44-12:46-12));
    dat2New(i,12) = nanmean(dat2(i, 47-12:49-12));
end

figure,
subplot(2,1,1)
surf(1:12, 10:5:200, dat1New(2:40,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
xlabel('Time');
ylabel('Depth');
title('South Africa');
caxis([150 265])

subplot(2,1,2)
surf(1:12, 10:5:200, dat2New(2:40,:))
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
xlabel('Time');
ylabel('Depth');
title('Australia');
caxis([150 265])

clear dat1 dat2 dat1New dat2New


