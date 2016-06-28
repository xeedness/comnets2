overAllRatio = 0;
overAllUserNr = 0;
overAllFile = '';

file = 'DSL/Simultaneous-0.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'DSL/Simultaneous-1.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'DSL/Simultaneous-2.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

file = 'DSL/Simultaneous-3.sca';
[maxRatio, userNr] = WorstDiscRatio(file)
if(maxRatio > overAllRatio)
    overAllRatio = maxRatio;
    overAllUserNr = userNr;
    overAllFile = file;
end

overAllRatio
overAllUserNr
overAllFile




