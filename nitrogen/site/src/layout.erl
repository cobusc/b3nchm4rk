%% -*- mode: nitrogen -*-
-module (layout).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

%% main() -> #template { file="./site/templates/bare.html" }.

%%title() -> "Hello from user_register.erl!".

header() -> 
    LogInOut =
    case wf:user() of
        undefined -> #button{ text="Log in", actions=[#event{type=click, delegate=layout, postback=login}]};
        _ -> #button{ text="Log out", actions=[#event{type=click, delegate=layout, postback=logout}]}
    end,
    [
        #panel { id=header, style="margin: 10px 100px;", body=[
            #span { text="Benchmark" },
            #p{},
            LogInOut,
            #p{}
        ]}
    ].

footer() ->
    [
        #h3 { id=footer, text="&copy Cobus Carstens" }
    ].

event(login) ->
    wf:redirect("/user/login");
event(logout) ->
    wf:redirect("/user/logout").
