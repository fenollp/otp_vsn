%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(types_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

-type t001() :: ?OTP_VSN_T_DICT_DICT().
-type t002() :: ?OTP_VSN_T_DIGRAPH_GRAPH().
-type t003() :: ?OTP_VSN_T_SETS_SET().
-export_types([t001/0, t002/0, t003/0
              ]).

if_compiled_then_passed_test() -> ?assert(true).
