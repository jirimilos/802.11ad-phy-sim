# 802.11ad-phy-sim
This repository contains the MATLAB model of the IEEE802.11ad physical layer model in baseband. The model is created in MATLAB 2017b. It only supports the Single Carrier Physical layer HY (SC PHY).

## Short description
Main blocks of the transmitting (TX) part are the follows:
#### Data
Generation of a random bit streams (bits)
#### Scrambler
Used to break up long sequences of ones and zeros. It is defined by generator polynomial: $x^7+x^4+1$.
#### LDPC Encoder
Forward error correction (FEC) scheme for SC PHY can use 5 code rates: 1/2, 5/8, 3/4, 13/16 and 7/8.
#### Bit Interleaver
Interleaving of the encoded message (on a bit level).
#### Modulation
pi/2-shifted BPSK, QPSK, 16QAM and 64QAM constellations.
#### Symbol Blocking
The data are transmitted block-wise at 448 symbols per block.
#### Guard Interval (GI)
Another 64 symbols are inserted between the individual blocks. The GI consists of a Golay sequence, marked as Ga64, modulated with pi/2-BPSK. Finally, the complete IEEE 802.11ad frame is created.
#### Channel
Contains either user-defined fading channel model or measured indoor 60 GHz channel model (see the paper mentioned below).

### Note: 
An accurate channel estimation is crucial for signal reception in wideband communication systems. For this purpose, IEEE 802.11ad emloys a Channel Estimation Field (CEF) in each packet, composed from Golay sequences of length 128 samples (Ga128, Gb128). At the receiving side (RX), the channel characteristics is estimated using a correlation computation.


## Please Cite Our Paper
If you use the 802.11ad simulator or measured indoor channel characteristics at 60 GHz, please, cite:

    @INPROCEEDINGS{BlumensteinNorCAS2019,
    author  = {Blumenstein, J. and Milos, J. and Polak, L. and Mecklenbräuker, Ch.},
    title   = {{IEEE} 802.11ad {SC}-{PHY} {Layer} {Simulator}: {Performance} in {Real}-world 60 {GHz} {Indoor} {Channels}},
    booktitle = {2019 IEEE Nordic Circuits and Systems Conference},
    year    = {2019},
    publisher = {IEEE},
    pages   = {1--4},
    month   = {Oct}
    }
