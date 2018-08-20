%% student
y3_std = [1,2,4,5,6,8,9,10,11,12,13,14,15,16,17,19,20,21,22,23,24,25,26,...
      27,28,29,30,32,33,34,35,36,37,38,39,40,41,43,44,45,46,47,48,49,50,...
      51,52,53,54,55,56,57,59,60,61,62,63,64,65,66,67,68,70,71,72,73];
y4_std = [4,7,8,10,23,35,39,44,56,62,68,69,71,75];

y3_score = NaN(1,66);
y4_score = NaN(1,14);

%% read file
y3_file = dir('HW1_3');
y4_file = dir('HW1_4');

%% extract file and scored
y3_dir = y3_file(1).folder;
y4_dir = y4_file(1).folder;
cur_dir = cd;

goto_y3_dir = cd(y3_dir);
for i = 3:length(y3_file)
    name = y3_file(i).name;
    prog = unzip(name);
    score = test_case(@def_int);
    for ind = 1:numel(y3_std)
        if y3_std(ind) == str2num(name(6:7))
            y3_score(ind) = score;
        end
    end
    delete def_int.m
end    

goto_y4_dir = cd(y4_dir);

for i = 3:length(y4_file)
    name = y4_file(i).name;
    prog = unzip(name);
    score = test_case(@def_int);
    for ind = 1:numel(y4_std)
        if y4_std(ind) == str2num(name(6:7))
            y4_score(ind) = score;
        end
    end
    delete def_int.m
end   

goto_current_dir = cd(cur_dir);
y3_table = table(y3_std',y3_score');
y4_table = table(y4_std',y4_score');


%% Solution and test case
function score = test_case(fun)
    eps = 0.00001;
    boolean = [0,0,0];
    myfun = {@(x)x^2, @(x)x^3+2*x+1,@(x)cos(x)};
    
    for k = 1:numel(myfun)
        if abs(fun(myfun{k},1,10,3)-solution(myfun{k},1,10,3)) < eps; boolean(k) = 1; end
    end
    
    score = all(boolean);
    
end

function out = solution(f,a,b,n)
    dx = (b-a)/n;
    out = f(a)+f(b);
    for i = a+dx:dx:b-dx
        out = out+2*f(i);
    end
    out = dx/2*out;
end
    