function [StringDate] = date2String(Month, Day)

switch Month
    case 1
        StringDate1 = 'Jan';
    case 2
        StringDate1 = 'Feb';
    case 3
        StringDate1 = 'Mar';
    case 4
        StringDate1 = 'Apr';
    case 5
        StringDate1 = 'May';
    case 6
        StringDate1 = 'Jun';
    case 7
        StringDate1 = 'Jul';
    case 8
        StringDate1 = 'Aug';
    case 9
        StringDate1 = 'Sep';
    case 10
        StringDate1 = 'Oct';
    case 11
        StringDate1 = 'Nov';
    case 12
        StringDate1 = 'Dec';
end

switch Day
    case 1
        StringDate2 = '01st';
    case 2
        StringDate2 = '02nd';
    case 3
        StringDate2 = '03rd';
    case 21
        StringDate2 = '21st';
    case 22
        StringDate2 = '22nd';
    case 23
        StringDate2 = '23rd';
    case 31
        StringDate2 = '31st';
    otherwise
        StringDate2 = [num2str(Day,'%02d'), 'th'];
end

StringDate = [StringDate1, '-', StringDate2];

end