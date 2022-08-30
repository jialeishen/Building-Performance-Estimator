function [PMV,PPD] = PMVPPD(CLO, MET, WME, TA, TR, VEL, RH)
% this function is used to calculate pmv and ppd
% INPUT     clothing        (clo)   CLO
% INPUT     metabolic rate  (met)   MET
% INPUT     external work   (met)   WME
% INPUT     air temperature (degC)  TA
% INPUT     MRT             (degC)  TR
% INPUT     air velocity    (m/s)   VEL
% INPUT     RH              (%)     RH
% OUTPUT    PMV             (-)     PMV
% OUTPUT    PPD             (%)     PPD
PA = RH.*10.*exp(16.6536 - 4030.183./(TA + 235));
ICL = .155.*CLO;
M = MET.*58.15;
W = WME.*58.15;
MW = M - W;
if ICL < .078
    FCL = 1 + 1.29.*ICL;
else
    FCL = 1.05 + .645.*ICL;
end
HCF = 12.1.*sqrt(VEL);
TAA = TA + 273;
TRA = TR + 273;
% calculate surface temperature of clothing by iteration
TCLA = TAA + (35.5 - TA)./(3.5.*(6.45.*ICL + .1));
P1 = ICL.*FCL;
P2 = P1.*3.96;
P3 = P1.*100;
P4 = P1.*TAA;
P5 = 308.7 - .028.*MW + P2.*(TRA./100).^4;
XN = TCLA./100;
XF = XN;
N = 0;
EPS = .00015;
ERROR = 0; % initial ERROR is 0
while 1
    XF = (XF + XN)./2;
    HCN = 2.38.*abs(100.*XF - TAA).^.25;
    if HCF > HCN 
        HC = HCF;
    else
        HC = HCN;
    end
    XN = (P5 + P4.*HC - P2.*XF.^4)./(100 + P3.*HC);
    N = N + 1;
    if abs(XN - XF) <= EPS | N > 150
        break;
    end
    if N > 150
        ERROR = 1; % pop up an error
        break;
    end
end
TCL = 100.*XN - 273;
% heat loss components
% heat loss diff. through skin
HL1 = 3.05.*.001.*(5733 - 6.99.*MW - PA);
% heat loss by sweating (comfort)
if MW > 58.15
    HL2 = .42.*(MW - 58.15);
else
    HL2 = 0;
end
% latent respiration heat loss
HL3 = 1.7.*.00001.*M.*(5867 - PA);
% dry respiration heat loss
HL4 = .0014.*M.*(34 - TA);
% heat loss by radiation
HL5 = 3.96.*FCL.*(XN.^4 - (TRA./100).^4);
% heat loss by convection
HL6 = FCL.*HC.*(TCL - TA);

% calculate PMV and PPD
% thermal sensation trans. coeff.
TS = .303.*exp(-0.036.*M) + .028;
% predicted mean vote
PMV = TS.*(MW - HL1 - HL2 - HL3 - HL4 - HL5 - HL6);
% predicted percentage dissat.
PPD = 100 - 95.*exp(-0.03353.*PMV.^4 - .2179.*PMV.^2);

if ERROR == 1
    PMV = 99999;
    PPD = -100;
    fprintf('Error iterating clothing syrface temperature: \nIteration number out of range!\n');
end

end

