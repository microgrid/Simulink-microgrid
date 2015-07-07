function [delta,Vref,Ipv_prev_out,Vpv_prev_out] = IncCond(Ipv,Iprevious,Vpv,Vprevious,Vref_previous)

% REFERENCE PAPERS:
% Trishan Esram, Patrick L. Chapman, "Comparison of Photovoltaic Array
% Maximum Power Tracking Techniques", IEEE Transactions on Energy
% COnversion, vol. 22, issue 2, June 2007.
%
% M. Lokanadham, K. Vijaya Bhaskar, "Incremental Conductance Based Maximum
% Power Point Tracking (MPPT) for Photovoltaic System" International
% Journal of Engineering Research and Applications (IJERA), vol. 2, issue
% 2, March-April 2012.


% The followoing code is an algorithm for a Maximum Power Point Tracking
% (MPPT) technique Incremental COnductance

Vbus = 500;

dI=Ipv-Iprevious;
dV=Vpv-Vprevious;

if (dV==0)
    if (dI==0)
        Vref=Vref_previous;
    else
        if (Ipv>0)
            Vref= Vpv+dV;
        else
            Vref= Vpv-dV;
        end
    end
else
    if ((dI/dV)==(-Ipv/Vpv))
        Vref=Vref_previous;
    else
        if ((dI/dV)>(-Ipv/Vpv))
            Vref= Vpv+dV;
        else
            Vref= Vpv-dV;
        end
    end
end
Ipv_prev_out=Ipv;
Vpv_prev_out=Vpv;

delta=1-Vref/Vbus;

end
