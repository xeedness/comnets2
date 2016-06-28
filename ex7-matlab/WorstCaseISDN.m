overAllRatio = 0;
overAllUserNr = 0;
overAllFile = '';

file = 'ISDN/Simultaneous-0.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-1.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-2.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-3.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-4.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-5.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-6.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'ISDN/Simultaneous-7.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

overAllRatio
overAllUserNr
overAllFile




