% Family Tree Program in Prolog
% Facts describe a small fictional family. Arguments use parent(Parent, Child).

male(john).
male(robert).
male(michael).
male(david).
male(james).

female(mary).
female(linda).
female(susan).
female(anna).
female(emily).
female(sophia).

parent(john, robert).
parent(mary, robert).
parent(john, linda).
parent(mary, linda).

parent(robert, michael).
parent(anna, michael).
parent(robert, emily).
parent(anna, emily).

parent(linda, david).
parent(james, david).
parent(linda, sophia).
parent(james, sophia).

% Derived relationships
grandparent(X, Z) :-
    parent(X, Y),
    parent(Y, Z).

sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% Avoid duplicate sibling answers when two parents are shared by using setof/3
% in queries, or use this predicate when unique sibling pairs are needed.
cousin(X, Y) :-
    parent(PX, X),
    parent(PY, Y),
    sibling(PX, PY),
    X \= Y.

% Recursive descendant relationship: X is an ancestor of Y if X is a parent
% of Y, or a parent of someone who is an ancestor of Y.
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

% Children of a person are queried directly through parent/2.
children(Person, Child) :-
    parent(Person, Child).

% Sample queries (run at the Prolog prompt; do not include ?- in source):
% ?- children(robert, Child).
% Expected: Child = michael ; Child = emily.
%
% ?- setof(S, sibling(robert, S), Siblings).
% Expected: Siblings = [linda].
%
% ?- grandparent(john, Grandchild).
% Expected: Grandchild = michael ; Grandchild = emily ; Grandchild = david ; Grandchild = sophia.
%
% ?- cousin(michael, david).
% Expected: true.
%
% ?- ancestor(john, Descendant).
% Expected: Descendant = robert ; Descendant = linda ; Descendant = michael ; Descendant = emily ; Descendant = david ; Descendant = sophia.
%
% ?- female(Person).
% Expected: Person = mary ; Person = linda ; Person = susan ; Person = anna ; Person = emily ; Person = sophia.
