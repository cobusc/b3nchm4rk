ERL ?= erl
APP := b3nchm4rk

.PHONY: deps

all: deps ctags
	@./rebar compile

deps:
	@./rebar get-deps

clean:
	@./rebar clean

release: all
	@./rebar --force generate

ctags:
	- ctags -R

distclean: clean
	@./rebar delete-deps

docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'
