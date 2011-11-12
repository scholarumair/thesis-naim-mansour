function [result,missingSamples] = CSMain(signal, method, fs)
%CSMain - Main function of the CS Declipping program.
%   signal: The input audio signal.
%   fs:     Sample rate in Hz. If not specified, 44.1kHz is chosen.
%   method: Type 1 for classical y=Ax constraints, 2 for y=Ax+Beconstraints
%Naim Mansour

%If no sample frequency specified
tic;
if nargin<3
    fs=44.1*10^3;
end
%Some checks to make sure the input has the correct dimensions.
[rs cs]=size(signal);
if ~(rs==1 || cs==1)
    disp('Input signal needs to be a vector.')
    return;
end
if rs<cs
    signal=signal';
end
[rs cs]=size(signal);
fs=44000; %Artificial - testing purposes
%Parameter selection
frameLength=20; %in milliseconds
if mod(fs*frameLength,1000)~=0
    disp('Infeasible sampling frequency, using default')
    fs=44.1*10^3;
end
frameOverlap=50; %percentage -- FOR NOW, USE ONLY 50%, OTHERWISE BARTLETT DOESN'T WORK
numberOfSamples=fs*frameLength/1000 %also minimal signal length

%Rough approach, to be changed later
if rs<numberOfSamples
    disp('Signal too short')
    return;
end

%To avoid rounding issues, and synthesis frame issues
if mod(numberOfSamples*(frameOverlap/100),1)~=0
    disp('Illegal overlap ratio')
    return;
end

%Keep only the part of the signal divisible into subframes
signal(end-(mod(rs,numberOfSamples)-2):end,:)=[];
[rs cs]=size(signal);

%Used to be able to calculate SNRm
Miss=[];
MaxS=max(signal);
MinS=min(signal);

for t=1:rs %border values possibly added to the clipped values -OK NOW
    if (signal(t,1)>=MaxS || signal(t,1)<=MinS)...
        && (((t==1 && signal(t+1,1)-signal(t,1)==0)  || (t==cs && signal(t,1)-signal(t-1,1)==0))... 
        || ((t~=1 && t~=cs) && signal(t-1,1)-signal(t+1,1))==0)
        Miss=[Miss t];
    end
end

%Division into frames
disp('Dividing into frames...')
T=[];
T(:,1)=signal(1:numberOfSamples+1,1);
position=(1-(frameOverlap/100))*numberOfSamples+1;
i=2;
while position+(numberOfSamples)<=rs
    T(:,i)=signal(position:position+numberOfSamples,1);
    position=position+(1-(frameOverlap/100))*numberOfSamples;
    i=i+1;
end


U=[];
[rst cst]=size(T);
% Could be combined with previous for-loop
% Apply the declipping to each frame
disp('Declipping...')
for j=1:cst
    disp(['Now declipping frame ' int2str(j) ' out of ' int2str(cst)])
    if(method==1)
        [dummy U(:,j)]=CSDeclip(T(:,j));
    else
        U(:,j)=CSDeclipAlternate(T(:,j));
    end
    subplot(2,1,1);plot(U(:,j),'-');
    subplot(2,1,2);plot(T(:,j),'-');
end

disp('Reconstructing...')
%Reconstruction (should work for any overlap ratio and compatible window)
window=hann(numberOfSamples+1); %Hann window (with 50% overlap)
shiftAmount=(1-(frameOverlap/100))*numberOfSamples+1; %=442 in typical case
%If only 1 frame
if cst==1
    result=U';
else
    %Condition on first frame
    result=[U(1:shiftAmount-1,1)' (window(shiftAmount:end,1).*U(shiftAmount:end,1))'];
end
position=shiftAmount;
for k=2:cst
    if k==cst
        %Condition on last frame
        currentBlock=[(window(1:shiftAmount,1).*U(1:shiftAmount,k))' U(shiftAmount+1:end,k)'];
    else
        currentBlock=(window.*U(:,k))';
    end
    unalteredPart=result(1,1:position-1);
    summedPart=result(1,position:end)+currentBlock(1,1:shiftAmount);
    unalteredBlockPart=currentBlock(1,shiftAmount+1:end);
    result=[unalteredPart summedPart unalteredBlockPart];
    position=position+shiftAmount-1;
end
toc;

result=result';

missingSamples=[];
for u=Miss
    try
        missingSamples=[missingSamples result(u,1)];
    catch ME
        disp('Missing sample skipped');
    end
end

subplot(3,1,1);plot(signal);
title('Clipped signal')
subplot(3,1,2);plot(result);
title('Reconstructed signal')
% subplot(3,1,3);plot(abs(signal-result));
subplot(3,1,3);plot(missingSamples);
title('Reconstructed missing samples');
end