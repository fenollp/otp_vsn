# [otp_vsn](https://github.com/fenollp/otp_vsn) [![CircleCI](https://circleci.com/gh/fenollp/otp_vsn/tree/master.svg?style=svg)](https://circleci.com/gh/fenollp/otp_vsn/tree/master)

Macros defined per Erlang/OTP version so you don't have to.

Header-only, no dependencies. Supports releases from `R16B` to latest.
Note: no need to include `otp_vsn` in your apps or releases. This is should only be a compile-time dependency!

```erlang
{deps, [otp_vsn]}.
```

```erlang
...
-include_lib("otp_vsn/include/otp_vsn.hrl").
...
-ifdef(OTP_19_AND_ABOVE).
...
-endif.
...
```

## Macros

* `OTP_VSN`: OTP version string in `MAJOR.MINOR.PATCH` format
    * Zeros are added where needed (e.g. `"16.0.0"` for R16B)
* `OTP_VSN_MAJOR`: above `MAJOR` part as an integer
* `OTP_VSN_MINOR`: above `MINOR` part as an integer
* `OTP_VSN_PATCH`: above `PATCH` part as an integer
* `OTP_VSN_MAJOR_STRING`: `?OTP_VSN_MAJOR` as a string
* `OTP_VSN_MINOR_STRING`: `?OTP_VSN_MINOR` as a string
* `OTP_VSN_PATCH_STRING`: `?OTP_VSN_PATCH` as a string
* `OTP_{{MAJOR}}_AND_ABOVE`: defined & set to `true` for `?OTP_VSN` `MAJOR.0.0` and all version after that
    * e.g. for OTP 19.0 `?OTP_19_AND_ABOVE = true` but on OTP 18.3 it is not defined
* `OTP_{{MAJOR}}_AND_BELOW`: defined & set to `true` for `?OTP_VSN` `MAJOR._._` and all versions before that
    * e.g. for OTP 19.0 `?OTP_19_AND_BELOW = true` but on OTP 20.0 it is not defined

If you'd like to see more macros you are welcome to
* open an issue at https://github.com/fenollp/otp_vsn/issues
* open a pull request at https://github.com/fenollp/otp_vsn/pulls
