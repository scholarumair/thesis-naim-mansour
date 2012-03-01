function tomXtract(fun, dir)
% tomXtract - Extract a minimal set of files and run mcc.
%
% TOMXTRACT(FUN,DIR) makes a copy of all tomlab files that are 
% used by the function FUN to a new directory DIR, and then
% uses mcc to compile them into an executable.
%
% FUN must be the name of a .m file (without the extension).
% DIR must a valid directory name.

% Written by Per Rutquist, Tomlab Optimization AB.

global xnargin_cache

clear mex

key = 'tomlab'; % The string that determines wheter a file should be copied.

pwd0 = pwd(); % Store original dir

dirpath = fullfile(pwd, dir);
mkdir(dirpath);

xnargin_cache = struct();

disp('Test run of code...');
profile on
eval([fun ';']);
s = profile('info');
disp('Done.');

disp('Copying files...');
t = s.FunctionTable;
flist = {};
nf = 0;
n = 0;
fstruct = struct();
for i=1:length(t)
    src = t(i).FileName;
    [pth, name, ext, ver] = fileparts(src); %#ok
    if(~isempty(strfind(src,key)) && ~isfield(fstruct,name))
        fstruct.(name) = 1;
        n = n+1;
        if(strcmp(ext,'.dll'))
            ext = '.mexw32';
        end
        if(~strcmp(name, fun))
            nf = nf+1;
            flist{nf} = [name ext];
        end
        dst = fullfile(dirpath, [name ext]);
        disp([src ' -> ' dst]);
        if(strcmp(name,'xnargin'))
            % Create a substitute xnargin
            h = fopen(dst, 'w');
            fprintf(h, 'function n = xnargin(S)\n');
            fprintf(h, '%% XNARGIN - AUTOGENERATED FILE FOR MEX COMPILATION\n');
            fprintf(h, '\nif(isa(S, ''function_handle''))\n  S=func2str(S);\nend\n');
            fprintf(h, '\nswitch(S)\n');
            lst = fields(xnargin_cache);
            for i=1:length(lst)
                fprintf(h, '  case(''%s'')\n    n=%d;\n', lst{i}, xnargin_cache.(lst{i}));
            end
            fprintf(h, '  otherwise\n    n=abs(nargin(S));\nend');
            fclose(h);
        else
            copyfile(src,dst);
        end
    end
end

% Remove tomlab from path
p0 = path;
p1 = '';
si = [0 find(p0==pathsep) length(p0)+1];
for i=2:length(si);
    p = p0(si(i-1)+1:si(i)-1);
    if(isempty(strfind(p,key)))
         p1 = [p1 pathsep p];
    end
end

try
    cd(dirpath);
    path(p1(2:end));

    % Run mcc
    cmd = ['mcc -m ' fun '.m'];
    for i=1:length(flist);
        cmd = [cmd ' ' flist{i}];
    end
    disp('Calling mcc');
    disp(cmd);
    eval(cmd);
catch
    path(p0);
    cd(pwd0);
    rethrow(lasterror);
end

% Restore path
path(p0);
cd(pwd0);



        
    
    