% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 696.631370276213829 ; 688.430910512066930 ];

%-- Principal point:
cc = [ 343.774440187973596 ; 304.051147293626400 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.149506890618806 ; -0.134985431149357 ; 0.018618054219488 ; 0.010746052973075 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 15.725999194293914 ; 14.471156319614902 ];

%-- Principal point uncertainty:
cc_error = [ 3.642793958863586 ; 10.804647079537190 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.010579890763361 ; 0.083231835513640 ; 0.002815706244953 ; 0.001785652311305 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 70;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_1  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_1 = [ 3.190799e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_1  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #2:
omc_2 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_2  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_2 = [ 3.190798e-03 ; 4.306602e-03 ; 1.182346e-02 ];
Tc_error_2  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #3:
omc_3 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486349e-01 ];
Tc_3  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_3 = [ 3.190800e-03 ; 4.306606e-03 ; 1.182346e-02 ];
Tc_error_3  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #4:
omc_4 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_4  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_4 = [ 3.190798e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_4  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #5:
omc_5 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_5  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_5 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_5  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #6:
omc_6 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_6  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_6 = [ 3.190798e-03 ; 4.306602e-03 ; 1.182346e-02 ];
Tc_error_6  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #7:
omc_7 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_7  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_7 = [ 3.190798e-03 ; 4.306602e-03 ; 1.182346e-02 ];
Tc_error_7  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #8:
omc_8 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_8  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_8 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_8  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #9:
omc_9 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_9  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_9 = [ 3.190798e-03 ; 4.306602e-03 ; 1.182346e-02 ];
Tc_error_9  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #10:
omc_10 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486348e-01 ];
Tc_10  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_10 = [ 3.190799e-03 ; 4.306605e-03 ; 1.182346e-02 ];
Tc_error_10  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #11:
omc_11 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_11  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_11 = [ 3.190799e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_11  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #12:
omc_12 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_12  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_12 = [ 3.190798e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_12  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #13:
omc_13 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_13  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_13 = [ 3.190799e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_13  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #14:
omc_14 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486349e-01 ];
Tc_14  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_14 = [ 3.190800e-03 ; 4.306606e-03 ; 1.182346e-02 ];
Tc_error_14  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #15:
omc_15 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_15  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_15 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_15  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #16:
omc_16 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486348e-01 ];
Tc_16  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_16 = [ 3.190799e-03 ; 4.306605e-03 ; 1.182346e-02 ];
Tc_error_16  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #17:
omc_17 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_17  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_17 = [ 3.190798e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_17  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #18:
omc_18 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_18  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_18 = [ 3.190799e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_18  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #19:
omc_19 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_19  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_19 = [ 3.190799e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_19  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #20:
omc_20 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_20  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_20 = [ 3.190798e-03 ; 4.306602e-03 ; 1.182346e-02 ];
Tc_error_20  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #21:
omc_21 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486348e-01 ];
Tc_21  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_21 = [ 3.190799e-03 ; 4.306605e-03 ; 1.182346e-02 ];
Tc_error_21  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #22:
omc_22 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_22  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_22 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_22  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #23:
omc_23 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_23  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_23 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_23  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #24:
omc_24 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486349e-01 ];
Tc_24  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_24 = [ 3.190800e-03 ; 4.306606e-03 ; 1.182346e-02 ];
Tc_error_24  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #25:
omc_25 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_25  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_25 = [ 3.190798e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_25  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #26:
omc_26 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_26  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_26 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_26  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #27:
omc_27 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486347e-01 ];
Tc_27  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_27 = [ 3.190799e-03 ; 4.306603e-03 ; 1.182346e-02 ];
Tc_error_27  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #28:
omc_28 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486348e-01 ];
Tc_28  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270486e+02 ];
omc_error_28 = [ 3.190799e-03 ; 4.306604e-03 ; 1.182346e-02 ];
Tc_error_28  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #29:
omc_29 = [ -2.229298e+00 ; -2.018496e+00 ; -4.486346e-01 ];
Tc_29  = [ -1.658698e+02 ; -1.063456e+02 ; 6.270487e+02 ];
omc_error_29 = [ 3.190798e-03 ; 4.306601e-03 ; 1.182346e-02 ];
Tc_error_29  = [ 3.368968e+00 ; 1.019381e+01 ; 1.345677e+01 ];

%-- Image #30:
omc_30 = [ -2.027281e+00 ; -1.785437e+00 ; -6.233235e-01 ];
Tc_30  = [ -1.425601e+02 ; -1.547996e+02 ; 5.629556e+02 ];
omc_error_30 = [ 6.859560e-03 ; 6.620684e-03 ; 1.053575e-02 ];
Tc_error_30  = [ 3.039478e+00 ; 9.435789e+00 ; 1.263286e+01 ];

%-- Image #31:
omc_31 = [ NaN ; NaN ; NaN ];
Tc_31  = [ NaN ; NaN ; NaN ];
omc_error_31 = [ NaN ; NaN ; NaN ];
Tc_error_31  = [ NaN ; NaN ; NaN ];

%-- Image #32:
omc_32 = [ NaN ; NaN ; NaN ];
Tc_32  = [ NaN ; NaN ; NaN ];
omc_error_32 = [ NaN ; NaN ; NaN ];
Tc_error_32  = [ NaN ; NaN ; NaN ];

%-- Image #33:
omc_33 = [ NaN ; NaN ; NaN ];
Tc_33  = [ NaN ; NaN ; NaN ];
omc_error_33 = [ NaN ; NaN ; NaN ];
Tc_error_33  = [ NaN ; NaN ; NaN ];

%-- Image #34:
omc_34 = [ NaN ; NaN ; NaN ];
Tc_34  = [ NaN ; NaN ; NaN ];
omc_error_34 = [ NaN ; NaN ; NaN ];
Tc_error_34  = [ NaN ; NaN ; NaN ];

%-- Image #35:
omc_35 = [ NaN ; NaN ; NaN ];
Tc_35  = [ NaN ; NaN ; NaN ];
omc_error_35 = [ NaN ; NaN ; NaN ];
Tc_error_35  = [ NaN ; NaN ; NaN ];

%-- Image #36:
omc_36 = [ NaN ; NaN ; NaN ];
Tc_36  = [ NaN ; NaN ; NaN ];
omc_error_36 = [ NaN ; NaN ; NaN ];
Tc_error_36  = [ NaN ; NaN ; NaN ];

%-- Image #37:
omc_37 = [ NaN ; NaN ; NaN ];
Tc_37  = [ NaN ; NaN ; NaN ];
omc_error_37 = [ NaN ; NaN ; NaN ];
Tc_error_37  = [ NaN ; NaN ; NaN ];

%-- Image #38:
omc_38 = [ NaN ; NaN ; NaN ];
Tc_38  = [ NaN ; NaN ; NaN ];
omc_error_38 = [ NaN ; NaN ; NaN ];
Tc_error_38  = [ NaN ; NaN ; NaN ];

%-- Image #39:
omc_39 = [ NaN ; NaN ; NaN ];
Tc_39  = [ NaN ; NaN ; NaN ];
omc_error_39 = [ NaN ; NaN ; NaN ];
Tc_error_39  = [ NaN ; NaN ; NaN ];

%-- Image #40:
omc_40 = [ NaN ; NaN ; NaN ];
Tc_40  = [ NaN ; NaN ; NaN ];
omc_error_40 = [ NaN ; NaN ; NaN ];
Tc_error_40  = [ NaN ; NaN ; NaN ];

%-- Image #41:
omc_41 = [ NaN ; NaN ; NaN ];
Tc_41  = [ NaN ; NaN ; NaN ];
omc_error_41 = [ NaN ; NaN ; NaN ];
Tc_error_41  = [ NaN ; NaN ; NaN ];

%-- Image #42:
omc_42 = [ NaN ; NaN ; NaN ];
Tc_42  = [ NaN ; NaN ; NaN ];
omc_error_42 = [ NaN ; NaN ; NaN ];
Tc_error_42  = [ NaN ; NaN ; NaN ];

%-- Image #43:
omc_43 = [ NaN ; NaN ; NaN ];
Tc_43  = [ NaN ; NaN ; NaN ];
omc_error_43 = [ NaN ; NaN ; NaN ];
Tc_error_43  = [ NaN ; NaN ; NaN ];

%-- Image #44:
omc_44 = [ NaN ; NaN ; NaN ];
Tc_44  = [ NaN ; NaN ; NaN ];
omc_error_44 = [ NaN ; NaN ; NaN ];
Tc_error_44  = [ NaN ; NaN ; NaN ];

%-- Image #45:
omc_45 = [ NaN ; NaN ; NaN ];
Tc_45  = [ NaN ; NaN ; NaN ];
omc_error_45 = [ NaN ; NaN ; NaN ];
Tc_error_45  = [ NaN ; NaN ; NaN ];

%-- Image #46:
omc_46 = [ NaN ; NaN ; NaN ];
Tc_46  = [ NaN ; NaN ; NaN ];
omc_error_46 = [ NaN ; NaN ; NaN ];
Tc_error_46  = [ NaN ; NaN ; NaN ];

%-- Image #47:
omc_47 = [ NaN ; NaN ; NaN ];
Tc_47  = [ NaN ; NaN ; NaN ];
omc_error_47 = [ NaN ; NaN ; NaN ];
Tc_error_47  = [ NaN ; NaN ; NaN ];

%-- Image #48:
omc_48 = [ NaN ; NaN ; NaN ];
Tc_48  = [ NaN ; NaN ; NaN ];
omc_error_48 = [ NaN ; NaN ; NaN ];
Tc_error_48  = [ NaN ; NaN ; NaN ];

%-- Image #49:
omc_49 = [ NaN ; NaN ; NaN ];
Tc_49  = [ NaN ; NaN ; NaN ];
omc_error_49 = [ NaN ; NaN ; NaN ];
Tc_error_49  = [ NaN ; NaN ; NaN ];

%-- Image #50:
omc_50 = [ NaN ; NaN ; NaN ];
Tc_50  = [ NaN ; NaN ; NaN ];
omc_error_50 = [ NaN ; NaN ; NaN ];
Tc_error_50  = [ NaN ; NaN ; NaN ];

%-- Image #51:
omc_51 = [ NaN ; NaN ; NaN ];
Tc_51  = [ NaN ; NaN ; NaN ];
omc_error_51 = [ NaN ; NaN ; NaN ];
Tc_error_51  = [ NaN ; NaN ; NaN ];

%-- Image #52:
omc_52 = [ NaN ; NaN ; NaN ];
Tc_52  = [ NaN ; NaN ; NaN ];
omc_error_52 = [ NaN ; NaN ; NaN ];
Tc_error_52  = [ NaN ; NaN ; NaN ];

%-- Image #53:
omc_53 = [ NaN ; NaN ; NaN ];
Tc_53  = [ NaN ; NaN ; NaN ];
omc_error_53 = [ NaN ; NaN ; NaN ];
Tc_error_53  = [ NaN ; NaN ; NaN ];

%-- Image #54:
omc_54 = [ NaN ; NaN ; NaN ];
Tc_54  = [ NaN ; NaN ; NaN ];
omc_error_54 = [ NaN ; NaN ; NaN ];
Tc_error_54  = [ NaN ; NaN ; NaN ];

%-- Image #55:
omc_55 = [ NaN ; NaN ; NaN ];
Tc_55  = [ NaN ; NaN ; NaN ];
omc_error_55 = [ NaN ; NaN ; NaN ];
Tc_error_55  = [ NaN ; NaN ; NaN ];

%-- Image #56:
omc_56 = [ NaN ; NaN ; NaN ];
Tc_56  = [ NaN ; NaN ; NaN ];
omc_error_56 = [ NaN ; NaN ; NaN ];
Tc_error_56  = [ NaN ; NaN ; NaN ];

%-- Image #57:
omc_57 = [ NaN ; NaN ; NaN ];
Tc_57  = [ NaN ; NaN ; NaN ];
omc_error_57 = [ NaN ; NaN ; NaN ];
Tc_error_57  = [ NaN ; NaN ; NaN ];

%-- Image #58:
omc_58 = [ NaN ; NaN ; NaN ];
Tc_58  = [ NaN ; NaN ; NaN ];
omc_error_58 = [ NaN ; NaN ; NaN ];
Tc_error_58  = [ NaN ; NaN ; NaN ];

%-- Image #59:
omc_59 = [ NaN ; NaN ; NaN ];
Tc_59  = [ NaN ; NaN ; NaN ];
omc_error_59 = [ NaN ; NaN ; NaN ];
Tc_error_59  = [ NaN ; NaN ; NaN ];

%-- Image #60:
omc_60 = [ NaN ; NaN ; NaN ];
Tc_60  = [ NaN ; NaN ; NaN ];
omc_error_60 = [ NaN ; NaN ; NaN ];
Tc_error_60  = [ NaN ; NaN ; NaN ];

%-- Image #61:
omc_61 = [ NaN ; NaN ; NaN ];
Tc_61  = [ NaN ; NaN ; NaN ];
omc_error_61 = [ NaN ; NaN ; NaN ];
Tc_error_61  = [ NaN ; NaN ; NaN ];

%-- Image #62:
omc_62 = [ NaN ; NaN ; NaN ];
Tc_62  = [ NaN ; NaN ; NaN ];
omc_error_62 = [ NaN ; NaN ; NaN ];
Tc_error_62  = [ NaN ; NaN ; NaN ];

%-- Image #63:
omc_63 = [ NaN ; NaN ; NaN ];
Tc_63  = [ NaN ; NaN ; NaN ];
omc_error_63 = [ NaN ; NaN ; NaN ];
Tc_error_63  = [ NaN ; NaN ; NaN ];

%-- Image #64:
omc_64 = [ NaN ; NaN ; NaN ];
Tc_64  = [ NaN ; NaN ; NaN ];
omc_error_64 = [ NaN ; NaN ; NaN ];
Tc_error_64  = [ NaN ; NaN ; NaN ];

%-- Image #65:
omc_65 = [ NaN ; NaN ; NaN ];
Tc_65  = [ NaN ; NaN ; NaN ];
omc_error_65 = [ NaN ; NaN ; NaN ];
Tc_error_65  = [ NaN ; NaN ; NaN ];

%-- Image #66:
omc_66 = [ NaN ; NaN ; NaN ];
Tc_66  = [ NaN ; NaN ; NaN ];
omc_error_66 = [ NaN ; NaN ; NaN ];
Tc_error_66  = [ NaN ; NaN ; NaN ];

%-- Image #67:
omc_67 = [ NaN ; NaN ; NaN ];
Tc_67  = [ NaN ; NaN ; NaN ];
omc_error_67 = [ NaN ; NaN ; NaN ];
Tc_error_67  = [ NaN ; NaN ; NaN ];

%-- Image #68:
omc_68 = [ NaN ; NaN ; NaN ];
Tc_68  = [ NaN ; NaN ; NaN ];
omc_error_68 = [ NaN ; NaN ; NaN ];
Tc_error_68  = [ NaN ; NaN ; NaN ];

%-- Image #69:
omc_69 = [ NaN ; NaN ; NaN ];
Tc_69  = [ NaN ; NaN ; NaN ];
omc_error_69 = [ NaN ; NaN ; NaN ];
Tc_error_69  = [ NaN ; NaN ; NaN ];

%-- Image #70:
omc_70 = [ NaN ; NaN ; NaN ];
Tc_70  = [ NaN ; NaN ; NaN ];
omc_error_70 = [ NaN ; NaN ; NaN ];
Tc_error_70  = [ NaN ; NaN ; NaN ];

