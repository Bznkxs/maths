function dvdt=rocket315(t,v)

if t<60
    dvdt=(32000-0.4*v.^2)./(1400-18*t)-9.8;     
else
    dvdt=-0.4*v.^2/320-9.8;
end

end