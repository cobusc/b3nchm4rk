%% -*- mode: nitrogen -*-
-module (user_login).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Hello from user_login.erl!".

body() ->
    case wf:user() of
        undefined -> 
            wf:wire(loginButton, userTextBox, #validate { validators=[
                        #is_required { text="Required" }
                        ]}),
            wf:wire(loginButton, passwordTextBox, #validate { validators=[
                        #is_required { text="Required" }
                        ]}),
            [
                #p{},
                "Enter your username and password to log in.",
                #label { text="Username" },
                #textbox { id=userTextBox, next=passTextBox },
                #p{},
                #label { text="Password" },
                #password { id=passwordTextBox, next=loginButton },
                #p{},
                #button { id=loginButton, text="Login", postback=login }
            ];

        Other -> 
            [
                #p{},
                "You are already logged in, "++Other
            ] 
    end.
	
event(login) ->
    User = wf:q(userTextBox),
    % Password = wf:q(passwordTextBox),
    %% @todo Validate username/password here
    wf:user(User),
    wf:redirect_from_login("/").

