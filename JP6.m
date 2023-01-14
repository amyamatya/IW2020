%% Tip of India

filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1});
levels = [shorelines.Level];
land = (levels == 1);


% 4 = oxy, 5 = nitrate, 6 = chl
indID = [];
for i = 1:length(argo)
    if argo(i).lat > -15 & argo(i).lon < 82 & argo(i).lon > 70 & argo(i).lat < 10
        indID = [indID i];
    end
end

figure,
hold on
worldmap([-75 35],[0 165]);
for i = 1:length(indID)
    s1 = scatterm(argo(indID(7)).float(1).lat, argo(indID(7)).float(1).lon, 10 ,'filled','ro');
end


geoshow(shorelines(land),  'FaceColor', [0.9 0.9 0.9]);
title('All floats in Indian Ocean');
hold off



%% ID 27 temp


for i = 1:length(argo(27).float)
    dat1(:,i) = argo(27).float(i).temp;
    dat2(:,i) = argo(27).float(i).chl;
end

figure(15)
subplot(2,1,1)
surf(1:98, 10:5:200, dat1(2:40,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('Oxygen ({\mu}mol/L), Tip of   ');
caxis([20 30])

subplot(2,1,2)
surf(1:98, 10:5:200, dat2(2:40,:))
set(gca,'XTick',[])
view(0,90)
colormap(jet)
shading interp
axis ij tight
colorbar
title('Chlorophyll (mg/m^{-3}),  South Africa');
caxis([0 1])

xticks(linspace(1.5,13.5,14));
xticklabels({'01/19','03/19','05/19','07/19','09/19','11/19','01/20','12/19','01/20','02/20',...
    '03/20','04/20'});


sl = suplabel('Time','x');
slPos = get(sl, 'position');
slPos(2) = 0.09;
set(sl, 'position' , slPos);
suplabel('Depth (m)','y');

    
