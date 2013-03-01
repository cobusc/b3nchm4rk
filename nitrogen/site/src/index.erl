%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Welcome to Nitrogen".

body() ->
    #container_12 { body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() }
    ]}.

inner_body() ->
    {ok, {_, AssetCategories, LiabilityCategories}} = fixtures_server:get_fixtures(), 
    [
        #h1 { text="Welcome to Nitrogen" },
        #p{},
        "
        If you can see this page, then your Nitrogen server is up and
        running. Click the button below to test postbacks.
        ",
        #p{}, 	
        #button { id=button, text="Click me!", postback=click },
		#p{},
        "
        Run <b>./bin/dev help</b> to see some useful developer commands.
        ",
	#p{},
	"
	<b>Want to see the ",#link{text="Sample Nitrogen jQuery Mobile Page",url="/mobile"},"?</b>
	",

        #dropdown { id=dropdown1, html_encode=true, options=[ #option{text=binary_to_list(Display), value=integer_to_list(Id)} || {Id, Display, _} <- AssetCategories ] },
        #dropdown { id=dropdown2, html_encode=true, options=[ #option{text=binary_to_list(Display), value=integer_to_list(Id)} || {Id, Display, _} <- LiabilityCategories ] }
    ].
	
event(click) ->
    wf:replace(button, #panel { 
        body="You clicked the button!", 
        actions=#effect { effect=highlight }
    }).
