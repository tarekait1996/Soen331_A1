%% =============================================================================
%%
%%  CONCORDIA UNIVERSITY
%%  Department of Computer Science and Software Engineering
%%  SOEN 331-W:  Assingment 1
%%  Winter term, 2019
%%  Date submitted: February 11, 2019
%%
%%  Authors:
%%
%%  name1, id1, email1
%%  name2, id2, email2
%%  ...
%%
%% =============================================================================

%% =============================================================================
%%
%%  Facts
%%
%% =============================================================================

%% Top-level states
state(idle).
state('warming up').
state(configuration).
state(exit).

%% States under active state
state(input).
state(add).
state(override).

%%Initial states
initial_state(idle, null).
initial_state('warming up', null).
initial_state(configuration, input).

%%Superstates
superstates(configuration, 'warming up').
superstates(configuration, add).
superstates(configuration, override).

%%Transitions within the top-level STRUCTURE IS TRANSITION(STATE1, STATE2, EVENT, GUARD, ACTION).

transition(idle,idle,'every two minutes','current is greater or equal than desired temperature', null).
transition(idle, 'warming up','every two minutes', 'current is less or equal desired temperature minus 1', 'furnace on; fan off' ).
transition(idle, exit, 'shut off', null, null).
transition(idle, configuration, 'setup', null, null).

transition('warming up', 'warming up', 'every three minutes', 'furnace temperature less than desired temperatue plus 1', null).
transition('warming up', idle, null, 'furnace temperature greater or equal than desired temp plus 1', 'fan on; furnace off; click sound produced').
transition('warming up', configuration, interrupt, null, 'furnace off').

transition(configuration, idle, cancel, null, 'prolonged beep sound').
transition(configuration, idle, 'after 1 minute inactive', null, null).
transition(configuration, idle, complete, null, 'double beep sound').

%%Transitions within active state
transition(input, add, register, 'tiplet does not exist in list', 'add it to list').
transition(input, override, register, 'tiplet does exist in list', 'override triplet inside list').
transition(add, input, repeat, null, null).
transition(override, input, repeat, null, null).

%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================

ancestor(A,B):- transition(A,B,_,_).
ancestor(A,B):- transition(A,X,_,_), ancestor(X,B,_,_).

get_all_transitions(L):- findall((A, B, C, D, E), (transition(A,B,C,D,E), \+ transition(A,B,C,null,D),\+ transition(A,B,C,D,null)), L).

get_all_transitions(L,S):-findall((A, B, C, D, E), (state(A), state(B), superstate(A,S), transition(A,B,C,D,E)), L).


%% eof.
