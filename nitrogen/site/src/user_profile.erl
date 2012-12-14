%% -*- mode: nitrogen -*-
-module (user_profile).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Hello from user_profile.erl!".

body() -> 
    case wf:q(submit) of
        undefined -> form();
        _ -> form_results()
    end.

form() ->
    [
        #restful_form{action="/user/profile", method=get, body=[
            #label{text="Your Name"},
            #textbox{id=your_name},
            #p{},
            #label{text="Where do you live?"},
            #dropdown{id=planet_name, html_name=your_home, options=[    %% your_name will be the name of the field submitted
                    #option{text="Alpha Centuri"},
                    #option{text="Earth"},
                    #option{text="Mars"}
                    ]},
            #p{},
            #restful_submit{html_name=submit,text="Submit"},
            #restful_reset{text="Reset"}
            ]}
        ].

form_results() ->
    [Name,Home] = wf:mq([your_name,your_home]),
    FullResults = wf:params(),
    [
        #table{rows=[
            #tablerow{cells=[
                #tablecell{text="Name:"},
                #tablecell{text=Name}
                ]},
            #tablerow{cells=[
                #tablecell{text="Home:"},
                #tablecell{text=Home}
                ]},
            #tablerow{cells=[
                #tablecell{text="Full POST:"},
                #tablecell{body=#pre{text=wf:f("~p",[FullResults]),html_encode=whites}}
                ]}
            ]},
        #link{url="/user/profile", text="Back to the form"}
        ].

event(_) -> 
    ok.

