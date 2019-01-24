function AnalyzeExcel
%[txt,raw] = xlsread('./20181124.xlsx');
[txt,raw] = xlsread('./40001.xlsx');
rawtimes = raw(:,1);
rawdatas = raw(:,2);
txttimes = char(rawtimes);
txtdatas = char(rawdatas);
time=(datevec(txttimes));
txtdatas(:,1) = [];

count = size(rawtimes,1);


% datas = repmat(0,count,32,64);

close all;
% fig = figure();

% maxvalue = 256;
% minvalue = 0;
% hValue=[]
cnt=1;
start_num = 126;
% colormap(jet);
for i = 1:count
  if(i<start_num)
      continue;
  end
  txtdata = strtrim(char(txtdatas(i,:)));
  txtdata(:,end) = [];
  ss = strsplit(txtdata,',');
  dd = [];
  for j = 1:2048
      dd(end+1)=str2num(ss{1,j});
  end
    
%   idex_Max = dd>1500;
%   dd(idex_Max)  = 1500;
%   inde_Min = dd<20;
%   dd(inde_Min)=0;
%  
%   vm = max(dd);
%  dd = dd/vm;
% dd = tanh(dd*2);
   %idx = dd < 66;
    %dd(idx) = 0;
  
  vm = max(dd)
  idx = dd > (0.6*vm);
  dd(idx) = 6;

    
  dd = dd - 49;
  dd = reshape(dd,32,[]);
  dd1 = dd;
%  dd1 = 128*dd;
%   dd = flipud(dd);
  
%   if(i~=1)
%     tmp = abs(hValue-dd);
%     vv = sum(tmp(:))/(32*64);
%     if(vv<0.02)
%       continue;
%     end
%   end
 
%  hValue = dd;
  %dd1 = 800*dd;
%   dd1 = 222*dd;
%   sIndex = dd1>366;
%   dd1(sIndex)=88;
  
  [origin_x,origin_y] = meshgrid(0:63,0:31);
  [aim_x,aim_y]=meshgrid((0:0.05:63),0:0.05:31);
  aimData = interp2(origin_x,origin_y,dd1,aim_x,aim_y,'cubic');
%   rgb = ind2rgb(aimData,jet(256))
%   imshow(aimData);
%   colormap(jet(256));
%   surf(aim_x,aim_y,aimData);
%    imshow(aimData)
  name  = sprintf('./images/img%d.png',cnt+start_num);
  imwrite(aimData,jet(256),name);
  cnt=cnt+1
  
%    if(i>622+start_num)
%       break;
%    end
%   h=surf(dd);
%   caxis([minvalue,maxvalue]);
%   shading interp
%   view(0,90);
%   colorbar();
%   pause(0.1);
%   datas(i,:,:) = dd;
%   name  = sprintf('img%d.png',i);
%   saveas(gcf,name);  
%   close;
end


end