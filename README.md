# ScilabComm
function ber = bersync(EbNo, sigma, type)
BERSYNC Bit error rate (BER) for imperfect synchronization.    BER = BERSYNC(EbNo, TIMERR, 'timing') returns the BER of coherent BPSK
   modulation over an uncoded AWGN channel with timing error. The    normalized timing error is assumed to be Gaussian distributed.
   EbNo -- bit energy to noise power spectral density ratio (in dB)    TIMERR -- standard deviation of the timing error, normalized to      the symbol interval
   BER = BERSYNC(EbNo, PHASERR, 'carrier') returns the BER of BPSK modulation over an uncoded AWGN channel with a noisy phase reference.
   The phase error is assumed to be Gaussian distributed. PHASERR -- standard deviation of the reference carrier phase error(in rad)
   
   Sample input:
   EbNo = [4 8 12];
   timerr = [0.2 0.07 0];
   ber = zeros(length(timerr), length(EbNo));
   for ii = 1:length(timerr)
        ber(ii,:) = bersync(EbNo, timerr(ii),'timing');
   end
   
   Output:
   ber =
   5.2073e-002  2.0536e-002  1.1160e-002
   1.8948e-002  7.9757e-004  4.9008e-006
   1.2501e-002  1.9091e-004  9.0060e-009
   
   
   function out = compand(in, param, V, method)
COMPAND Source code mu-law or A-law compressor or expander.
   OUT = COMPAND(IN, PARAM, V) computes mu-law compressor with mu given in PARAM and the peak magnitude given in V.

   OUT = COMPAND(IN, PARAM, V, METHOD) computes mu-law or A-law compressor or expander computation with the computation method given
   in METHOD. PARAM provides the mu or A value. V provides the input signal peak magnitude. METHOD can be chosen as one of the following:
   METHOD = 'mu/compressor' mu-law compressor.
   METHOD = 'mu/expander'   mu-law expander.
   METHOD = 'A/compressor'  A-law compressor.
   METHOD = 'A/expander'    A-law expander.

   The prevailing values used in practice are mu=255 and A=87.6.
   
   Sample input1:
   data = 2:2:12
   compressed = compand(data,255,max(data),'mu/compressor')
   Output
   compressed =

    8.1644    9.6394   10.5084   11.1268   11.6071   12.0000
    Sample input2:
    compressed = compand(data,255,max(data),'mu/compressor')
    
    expanded = compand(compressed,255,max(data),'mu/expander')
    output:
    expanded =

    2.0000    4.0000    6.0000    8.0000   10.0000   12.0000
    Input3:
    data = 1:5
    compressed = compand(data,87.6,max(data),'a/compressor')
    Output
    compressed =

    3.5296    4.1629    4.5333    4.7961    5.0000
    Input4:Output
    expanded =

    1.0000    2.0000    3.0000    4.0000    5.0000

  

   
   
   
  
  
