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
%%  Tarek Ait Hamouda, 40044119, tarekaithamouda@gmail.com
%%  Ethel Narra Pangan, 40061530, narra_pangan@hotmail.com
%%  Abhijit Gupta, 40066502, abhijit.gupta1122@gmail.com
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

%% States under configuration state
state(input).
state(add).
state(override).

%%Initial states
initial_state(idle, null).
initial_state('warming up', null).
initial_state(configuration, input).

%%Superstates
superstate(configuration, input).
superstate(configuration, add).
superstate(configuration, override).

%%Transitions within the top-level STRUCTURE IS TRANSITION(STATE1, STATE2, EVENT, GUARD, ACTION).

transition(idle,idle,'every two minutes','current is greater or equal than desired temperature', null).
transition(idle, 'warming up','every two minutes', 'current is less or equal desired temperature minus 1', 'furnace on; fan off' ).
transition(idle, exit, 'shut off', null, null).
transition(idle, configuration, 'setup', null, null).

transition('warming up', 'warming up', 'every three minutes', 'furnace temperature less than desired temperature plus 1', null).
transition('warming up', idle, null, 'furnace temperature equal to desired temp plus 1', 'fan on; furnace off; click sound produced').
transition('warming up', configuration, interrupt, null, 'furnace off').

transition(configuration, idle, cancel, null, 'prolonged beep sound').
transition(configuration, idle, 'after 1 minute inactive', null, null).
transition(configuration, idle, complete, null, 'double beep sound').

%%Transitions within configuration state
transition(input, add, register, 'triplet does not exist in list', null).
transition(input, override, register, 'triplet does exist in list', null).
transition(add, input, repeat, null, null).
transition(override, input, repeat, null, null).

%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================

ancestor(A,B):- superstate(A,B).
ancestor(A,B):- superstate(A,X), ancestor(X,B).

get_all_transitions(L):- findall((A, B, C, D, E), (transition(A,B,C,D,E), \+ transition(A,B,null,D,E),\+ transition(A,B,C,null,E)), L).

get_inherited_transitions(L,S):- findall((A, B, C, D, E), (state(A), state(B), superstate(A,S), transition(A,B,C,D,E)), L).


%% eof.
