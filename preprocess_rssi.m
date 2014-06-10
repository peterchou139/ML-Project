load rssi.txt
load distance.txt

%% remove the large number ahead for convenience
rssi(:,1) = rssi(:,1) - 1396258300*ones(size(rssi(:,1)),1);
distance(:,1) = distance(:,1) - 1396258300*ones(size(distance(:,1)),1);

%% filter the ID with $i
rssi1 = [];
rssi2 = [];
rssi3 = [];
rssi4 = [];
rssi5 = [];

for i = 1:size(rssi,1)
	switch rssi(i, 2)
		case 1
			rssi1 = [rssi1; rssi(i,:)];
		case 2
			rssi2 = [rssi2; rssi(i,:)];
		case 3
			rssi3 = [rssi3; rssi(i,:)];
		case 4
			rssi4 = [rssi4; rssi(i,:)];
		case 5
			rssi5 = [rssi5; rssi(i,:)];
	end
end

% plot the graph of distance corresponding to rssi
figure(1);
clf;
subplot(2,1,1);
plot(rssi1(:,1), rssi1(:,3));
xlabel('timestamp(ms)');
ylabel('RSSI(dbm)');
title('ID1 with distance=3M');

subplot(2,1,2);
plot(rssi2(:,1), rssi2(:,3));
xlabel('timestamp(ms)');
ylabel('RSSI(dbm)');
title('ID2 with distance=2M');
print 'timestamp-rssi12.pdf';

figure(2);
clf;
subplot(2,1,1);
plot(rssi3(:,1), rssi3(:,3));
xlabel('timestamp(ms)');
ylabel('RSSI(dbm)');
title('ID3 with distance=3M');

subplot(2,1,2);
plot(rssi4(:,1), rssi4(:,3));
xlabel('timestamp(ms)');
ylabel('RSSI(dbm)');
title('ID4 with distance=1M');
print 'timestamp-rssi34.pdf';

figure(3);
clf;
subplot(2,1,1);
plot(rssi5(:,1), rssi5(:,3));
xlabel('timestamp(ms)');
ylabel('RSSI(dbm)');
title('ID5 with varied distance');

subplot(2,1,2);
rssi5_detail = [];
for i = 1:size(rssi5,1)
	if((rssi5(i,1)>860) && (rssi5(i,1)<1200))
		rssi5_detail=[rssi5_detail; rssi5(i,:)];
	end
end

distance_fixed = distance(distance(:, 2) <= 5000, :);
distance_detail = [];
for i = 1:size(distance_fixed, 1)
	if((distance_fixed(i,1)>860) && (distance_fixed(i,1)<1200))
		distance_detail=[distance_detail; distance_fixed(i,:)];
	end
end
[ax, h1, h2] = plotyy (rssi5_detail(:,1), rssi5_detail(:,3), distance_detail(:,1), distance_detail(:,2), @plot, @semilogy); 
xlabel('timestamp(ms)');
ylabel(ax(1), 'RSSI(dbm)');
ylabel(ax(2), 'Log distance(mm)');
set(h1,'LineStyle','-') 
set(h2,'LineStyle','--') 
legend([h1, h2], 'rssi', 'distance')
#plot(rssi5_detail(:,1), rssi5_detail(:,3));
#xlabel('timestamp(ms)');
#ylabel('RSSI(dbm)');
#title('ID5 with varied distance-detail');
print 'timestamp-rssi5.pdf';
