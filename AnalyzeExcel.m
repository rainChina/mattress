function AnalyzeExcel
[txt,raw] = xlsread('./20181124.xlsx');
rawtimes = raw(:,1);
rawdatas = raw(:,2);
txttimes = char(rawtimes);
txtdatas = char(rawdatas);
time=(datevec(txttimes));
txtdatas(:,1) = [];

count = size(rawtimes,1);


datas = repmat(0,count,32,64);

% close all;
fig = figure();


%for i = 1:count
%   txtdata = strtrim(char(txtdatas(i,:)));
%    txtdata(:,end) = [];
%   ss = strsplit(txtdata,',');
%   dd = [];
%   for j = 1:2048
%       dd(end+1)=str2num(ss{1,j});
%   end
%   dd = reshape(dd,32,[]);
   %contourf(dd);
   %caxis([0,256]);
   %imagesc(dd);
%   title(txttimes(i,:));
 %  pause(0.1);
%   datas(i,:,:) = dd;
%end

lastkey = 'space';
index = 1;
maxvalue = 256;
minvalue = 0;
changeMaxMinValue = 1;
colormap(jet);
set(fig,'windowkeypressfcn',{@keypressfcn});
    function keypressfcn(h,evt)
        changePic =0;
         if  strcmp('pageup',evt.Key) == 1
            minvalue  = minvalue+10;
            changeMaxMinValue = 1;
        end
        if  strcmp('pagedown',evt.Key) == 1
            minvalue  = minvalue-10;
            changeMaxMinValue = 1;
        end
        if  strcmp('uparrow',evt.Key) == 1
            maxvalue  = maxvalue+10;
            changeMaxMinValue = 1;
        end
        if  strcmp('downarrow',evt.Key) == 1
            maxvalue  = maxvalue-10;
            changeMaxMinValue = 1;
        end
        if  strcmp('rightarrow',evt.Key) == 1
            index = index+1;
            changePic = 1;
        end
        if  strcmp('leftarrow',evt.Key) == 1
            index = index-1;
            changePic = 1;
        end
        if changePic == 1
            if index <1
                index = 1;
            end
            if index >count
                index = count;
            end
            txtdata = strtrim(char(txtdatas(index,:)));
            txtdata(:,end) = [];
            ss = strsplit(txtdata,',');
            dd = [];
            for j = 1:2048
                dd(end+1)=str2num(ss{1,j});
            end
            ee = reshape(dd,32,[]);
            %imagesc(ee);
            %pcolor(ee);
            %contourf(ee,64);
            surf(ee);
            axis([0 64 0 32]);
            shading interp
            view(0,90);
            colorbar();
        end
        
        if changeMaxMinValue == 1
            if minvalue <0
                minvalue = 0;
            end
            if minvalue > 1000
                minvalue = 1000;
            end
            
            if maxvalue <50
                maxvalue = 50;
            end
            if maxvalue > 1000
                maxvalue = 1000;
            end;
            if minvalue > maxvalue - 64
                minvalue = maxvalue -64;
            end
        end
        caxis([minvalue,maxvalue]);
        title([txttimes(index,:),' index:',num2str(minvalue)]);
        changeMaxValue = 0;
    end


end