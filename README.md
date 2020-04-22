ARCHIVED: since it is not possible to auto publish new versions to hex.pm (with CI) I am no longer maintaining this project.
If you want to continue it on: contact me for the publishing rights.

# [otp_vsn](https://github.com/fenollp/otp_vsn) [![CircleCI](https://circleci.com/gh/fenollp/otp_vsn/tree/master.svg?style=svg)](https://circleci.com/gh/fenollp/otp_vsn/tree/master) [![TravisCI build status](https://travis-ci.org/fenollp/otp_vsn.svg?branch=master)](https://travis-ci.org/fenollp/otp_vsn) [![Hex pm](http://img.shields.io/hexpm/v/otp_vsn.svg?style=flat)](https://hex.pm/packages/otp_vsn)

Macros defined per Erlang/OTP version so you don't have to.

This saves you the copy/pasting/tweaking of [`erl_opts`'s `platform_define`](https://www.rebar3.org/docs/configuration#section-compilation).

Header-only, no dependencies. Supports releases from `R16B01` to latest.

Note: no need to include `otp_vsn` in your apps or releases. This should only be a compile-time dependency!

```erlang
{deps, [{otp_vsn, "~>1.0"}]}.
```

```erlang
...
-include_lib("otp_vsn/include/otp_vsn.hrl").
...
-ifdef(OTP_VSN_HAS_MAPS).
-ifndef(OTP_VSN_19_AND_ABOVE).
... something using maps and specific to OTP 17 or 18 but not 19 nor above ...
-endif.
-endif.
...
```

## Macros

Note: all macros introduced by `otp_vsn` are prefixed with `OTP_VSN` and in full caps.

* **`?OTP_VSN`**: OTP version string in `MAJOR.MINOR.PATCH` format
    * Zeros are added where needed (e.g. `"16.1.0"` for R16B01)
    * Note on release candidates: 21.0-rc1 is expressed as `"21.0.0"`, same for 21.0-rc2
* `?OTP_VSN_MAJOR`: above `MAJOR` part as an integer
* `?OTP_VSN_MINOR`: above `MINOR` part as an integer
* `?OTP_VSN_PATCH`: above `PATCH` part as an integer
* `?OTP_VSN_MAJOR_STRING`: `?OTP_VSN_MAJOR` as a string
* `?OTP_VSN_MINOR_STRING`: `?OTP_VSN_MINOR` as a string
* `?OTP_VSN_PATCH_STRING`: `?OTP_VSN_PATCH` as a string
* **`?OTP_VSN_{{MAJOR}}_AND_ABOVE`**: defined & set to `true` for `?OTP_VSN = "MAJOR.0.0"` and all later versions
    * e.g. for OTP 19.0 `?OTP_VSN_19_AND_ABOVE = true`
        * but on OTP 18.3 it is not defined
        * but on OTP 20.3 it is defined as well as `OTP_VSN_20_AND_ABOVE`
* **`?OTP_VSN_HAS_MAPS`**: defined for releases which have maps (i.e. all since OTP 17.0)
* **`?OTP_VSN_STACKTRACE`**, **`?OTP_VSN_HAS_ST_MATCHING`**, **`?OTP_VSN_IF_HAS_ST_MATCHING`**: see [stacktrace matching macros](#on-st-matching)

If you'd like to see more macros you are welcome to
* open an issue at https://github.com/fenollp/otp_vsn/issues
* open a pull request at https://github.com/fenollp/otp_vsn/pulls


### On ST matching

Since OTP 21 calls to `erlang:get_stacktrace/0` (`ST`) generate a compilation warning
and `try...end` blocks have a new syntax to extract the same information:

```erlang
try ...
catch E:T:ST -> ...
end
```

In order to compile without these warnings and be backwards compatible we introduce a couple macros:
* **`?OTP_VSN_STACKTRACE(T,E,ST)`**: defined for all releases. The least annoying workaround by far IMO.
* **`?OTP_VSN_IF_HAS_ST_MATCHING(Y)`**, **`?OTP_VSN_IF_HAS_ST_MATCHING(Y,N)`**: see below and [`test/has_st_matching_tests.erl`](/test/has_st_matching_tests.erl)
* **`?OTP_VSN_HAS_ST_MATCHING`**: defined for releases which have that syntax (i.e. all since OTP 21.0)

```erlang
    catch
     %% Probably the one macro you're interested in:
        ?OTP_VSN_STACKTRACE(error, _, ST)
            begin f(ST), X end;
     %%  Its equivalent:
     %% ?OTP_VSN_IF_HAS_ST_MATCHING(
     %%    error:_:ST -> begin f(ST), X end;
     %%   ,error:_ -> begin f(erlang:get_stacktrace()), X end;
     %%   )
        ?OTP_VSN_IF_HAS_ST_MATCHING(throw:only_matching:ST -> f(X,ST);)
        ?OTP_VSN_IF_HAS_ST_MATCHING(throw:b:ST -> f(X,ST);, throw:b -> f(X,erlang:get_stacktrace());)
        ?OTP_VSN_IF_HAS_ST_MATCHING(_:_:ST -> f(X, ST),
                                    _:_    -> f(X, erlang:get_stacktrace()))
    end
```
