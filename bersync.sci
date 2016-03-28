function ber = bersync(EbNo, sigma, typen)

      //BERSYNC Bit error rate (BER) for imperfect synchronization.
      //   BER = BERSYNC(EbNo, TIMERR, 'timing') returns the BER of coherent BPSK
      //   modulation over an uncoded AWGN channel with timing error. The
      //   normalized timing error is assumed to be Gaussian distributed.
      //   EbNo -- bit energy to noise power spectral density ratio (in dB)
      //   TIMERR -- standard deviation of the timing error, normalized to the
      //             symbol interval
      //
      //   BER = BERSYNC(EbNo, PHASERR, 'carrier') returns the BER of BPSK
      //   modulation over an uncoded AWGN channel with a noisy phase reference.
      //   The phase error is assumed to be Gaussian distributed.
      //   PHASERR -- standard deviation of the reference carrier phase error
      //              (in rad)

      //   Author(s): Ashwini
      //   .

      //   References:
      //     [1] https://help.scilab.org

      [lhs,rhs] = argn(0)
      if (rhs<3)
            error("comm:bersync:numArgs")
      end
      if ~type(EbNo)==1 then
            error("comm:bersync:EbNo")
      end
      one=ones(1,length(EbNo))
      zero=zeros(1,length(EbNo))
      EbNoLin = 10.^(EbNo/10)
      ber = zeros(size(EbNo))
      if ~strcmp(typen,"timing")
            if sigma>0.5
                  error("comm:bersync:timerr")
            elseif sigma<%eps
                  ser = 1-cdfnor("PQ",sqrt(2.*EbNoLin),zero,one)
                  ber = ser;
            else
                  s = warning("MATLAB:quad:MaxFcnCount")
                  tol = 1e-4 ./ EbNoLin.^6
                  tol(tol>1e-4) = 1e-4
                  tol(tol<%eps) = %eps
                  for i = 1:length(EbNoLin)
                        ber(i)=sqrt(2) / (8*sqrt(%pi)*sigma)*integrate('erfc(sqrt(EbNoLin(i))*(1-2*abs(x)))*exp(-x^2/(2*(sigma)^2))','x',-10*sigma,10*sigma,tol(i),tol(i));
                  end
                  ber = ber + erfc(sqrt(EbNoLin)) / 4
            end
      elseif strcmp(typen,"carrier") then
            if (sigma<0) then
                  error("comm:bersync:phaserr")
            elseif sigma < %eps then
                  ser = 1-cdfnor("PQ",sqrt(2.*EbNoLin),zero,one)
                  ber = ser
            else
                  warning("MATLAB:quad:MaxFcnCount")
                  tol = 1e-4 ./ EbNoLin.^6
                  tol(tol>1e-4) = 1e-4
                  tol(tol<%eps) = %eps
            end
            for i = 1:length(EbNoLin)
                  ber(i)=integrate('erfc(sqrt(EbNoLin(i))*(cos(x))* exp(-x^2/(2*(sigma)^2))','x',0,10*sigma,tol(i),tol(i))/(sqrt(2*(%pi)) * sigma);
            end
      else
            error("comm:bersync:thirdArg")
      end




