function [E,H] = W_charact_function(B)
%W_CHARACT_FUNCTION ������� ����� ����� ������������������� ��������� ���
% ��������� W-����

global V l e1 e2 e3 c % �������� ���� ���������� ������ ���� �������� ����� ������� ���������� ��������� ����������

% V - ��������������� ������� ���������
% l - ������������ ����� 
% e1 - ��������������� ������������� ����
% e2 - ��������������� ������������� ������� ��������
% e3 - ��������������� ������������� ������� ��������
% c - ��������� �������� ������� ������� �������� � ����������� (������� ������������ ����) 

% ����� ������� ������������� ���������� 
    gamma   = (e3-e2)/(e1-e3);
    delta   = e3/(e1-e3);
    ksita   = e2/(e1-e3);

    sqB     = sqrt(B);
    sq_B    = sqrt(1-B);
    sqBg    = sqrt(B+gamma);

    ua      = V.*sq_B;
    wa      = V.*sqBg;
    wb      = V.*c.*sqBg;
    vb      = V.*c.*sqB;

    Jlua    = besselj(l,ua);
    J_lua   = besselj(l+1,ua);

    Klwa    = besselk(l,wa);
    K_lwa   = besselk(l+1,wa);  
    Ilwa    = besseli(l,wa);   
    I_lwa   = besseli(l+1,wa);  
    Klwb    = besselk(l,wb);
    K_lwb   = besselk(l+1,wb);  
    Ilwb    = besseli(l,wb);   
    I_lwb   = besseli(l+1,wb);  

    Z       = besselk(l+1,vb)./besselk(l,vb); 

    alfa1   = (K_lwa./Klwb-I_lwa./Ilwb)./(Klwa./Klwb-Ilwa./Ilwb);
    alfa2   = (K_lwb./Klwb-I_lwb./Ilwb)./(Klwa./Klwb-Ilwa./Ilwb);
    beta1   = (I_lwa./Ilwa-K_lwa./Klwa)./(Ilwb./Ilwa-Klwb./Klwa);
    beta2   = (I_lwb./Ilwa-K_lwb./Klwa)./(Ilwb./Ilwa-Klwb./Klwa);

    clear Klwa K_lwa Klwb K_lwb Ilwa I_lwa Ilwb I_lwb;

    p       = e2.*B.*sqBg.*beta2-e3.*(B+gamma).*sqB.*Z;
    r       = B.*sqBg.*beta2-(B+gamma).*sqB.*Z;
    h       = e2.*(1-B).*sqBg.*Jlua.*alfa1+e1.*(B+gamma).*sq_B.*J_lua;
    g       = (1-B).*sqBg.*Jlua.*alfa1+(B+gamma).*sq_B.*J_lua;

    clear Z;

    K1      = V.*c.*p.*r+l.*((e3-e2).*(B+delta).*r+gamma.*p);
    JikB1   = Jlua.*alfa2.*beta1.*B.*(1-B).*(B+gamma);

    qb      = JikB1.*(e1-e3)./K1;
    qc      = (c.*(V.*JikB1.*e2).^2)./K1;
    d1      = (l.*gamma+r.*c.*V).*V.*e2.^2./(e1-e3);
    d2      = (l.*gamma.*(B+delta)+p.*c.*V./(e1-e3)).*V;
    f1      = Jlua.*l.*((e1-e2).*B+(e1-e2).*delta);
    f2      = Jlua.*l.*(gamma+1);
    dhg     = Jlua.*(1-B).*sqBg.*alfa1.*(e1-e2);
    A       = Jlua.*l.*(gamma+1).*(l.*(e3-e2).*((B+delta+ksita).^2)+V.*c.*((B+delta).*p+r.*ksita.*e2));

    aa      = V.*e1;
    bb      = -(dhg.*V + f1 + qb.*d1 + e1.*( f2 + qb.*d2));
    cc      = qc + qb.*A + dhg.*(f2 + qb.*d2);

    Det     = bb.^2-4.*aa.*cc;
    
    % ���������� ������� ��������
    H       = g - (-bb + sqrt(Det))./(2.*aa);
    E       = g - (-bb - sqrt(Det))./(2.*aa);

end