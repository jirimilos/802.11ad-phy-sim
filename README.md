# 802.11ad-phy-sim
This repository contains the MATLAB model of the IEEE802.11ad physical layer model in baseband. It only supports the Single Carrier Physical layer HY (SC PHY). The model is created in MATLAB 2017b using the Control System Toolbox, Signal Processing Toolbox, DSP System Toolbox and Communications System Toolbox. Mentioned MATLAB toolboxes are necessary to run this simulator.

All m- or mex- files are made entirely by authors, excepting the Soft-sphere decoder implementation which was originally developed at Vienna Univeristy of Technology within the LTE Link Level Simulator, see paper:

    @article{TUW-199104,
    author = {Mehlf{\"u}hrer, Christian and Colom Ikuno, Josep and Simko, Michal and Schwarz, Stefan and Wrulich, Martin and Rupp, Markus},
    title = {The Vienna LTE Simulators - Enabling Reproducibility in Wireless Communications Research},
    journal = {EURASIP Journal on Advances in Signal Processing},
    year = {2011},
    volume = {Vol. 2011},
    pages = {1--13},
    url = {http://publik.tuwien.ac.at/files/PubDat_199104.pdf},
    }

## Short description
Main blocks of the transmitting (TX) part are the follows:
#### Data
Generation of a random bit streams (bits)
#### Scrambler
Used to break up long sequences of ones and zeros. It is defined by generator polynomial: !Tex2Img_1571646154.jpg.
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
It allows either AWGN only simulation, fading channel model simulation using user-defined values or fading channel simulation using a measured indoor 60 GHz channel model (see the paper mentioned below).

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
