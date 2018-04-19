%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-ifndef(_OTP_VSN_HRL).
-define(_OTP_VSN_HRL, true).

-ifdef(_otp_vsn_20_3_0).
-define(OTP_VSN, "20.3.0").
-define(OTP_VSN_MAJOR, 20).
-define(OTP_VSN_MINOR, 3).
-define(OTP_VSN_PATCH, 0).
-define(OTP_20_AND_BELOW, true).
-define(OTP_20_AND_ABOVE, true).
-define(OTP_19_AND_ABOVE, true).
-define(OTP_18_AND_ABOVE, true).
-define(OTP_17_AND_ABOVE, true).
-define(OTP_16_AND_ABOVE, true).
-endif.

-define(OTP_VSN_MAJOR_STRING, integer_to_list(?OTP_VSN_MAJOR)).
-define(OTP_VSN_MINOR_STRING, integer_to_list(?OTP_VSN_MINOR)).
-define(OTP_VSN_PATCH_STRING, integer_to_list(?OTP_VSN_PATCH)).

-endif.
