%   Para  instalar  no  Linux  basta  procurar o pacote 'swi-prolog', e rodar no
%   terminal com o comando:
%
%                          $ swipl gramaticas.pl
%
%   obs:  mesmo  que  a  extensao seja a mesma de Perl, recomendo nao mudar para
%   .pro  para evitar conflito uma vez que na minha máquina o SWI nao reconheceu
%   tal  extensao  como  valida.  Alem  disso,  para  matar  o  programa deve-se
%   pressionar Ctrl + D -- no Windows nao sei como seria, provavelment Ctrl + Z.
%
%   Use  o  segundo  comando  na  sua interface SWI-Prolog para fazer o teste do
%   codigo:
%   
%                 $ gramatica_interios([ 1, 2, 3 ], []).
%                 $ gramatica_reais([ 1.2, 2, 3.4 ], []).
%                 $ gramatica_receita([ fever, ovos ], []).
%

%   ------------------------------- INTEIROS -----------------------------------

%   caso  o usuario nao passe nenhuma cadeia valida para teste, se deve retornar
%   como teste invalido -- falso.
gramatica_inteiros([], []) :-
    false.

%   retorna em X as possiveis cadeias.
%   'd' é a representação para dígito, como números inteiros podem ser formaodos
%   apenas  pelos  digitos  0,  1,  2,  3,  4, 5, 6, 7, 8, 9 e seus equivalentes
%   negativados,  por  facilidade  de  epresentacao  foi  escolido  o  'd'  para
%   representar tal conjunto.
gramatica_inteiros("d --> d | [d]", []).

%   caso  o  usuario  passe  uma  cadeia e gostaria de verificar se ela formaria
%   numberos ou nao.
%
%   esse  primeiro  exemplo  serve  para caso a cadeia tenha apenas um elemento,
%   como o segundo exemplo nao pegaria  tal  cenario, o primeiro exemplo teve de
%   ser  criado, isso porque se fosse apenas um elemento o segundo caso trataria
%   a  cauda  como  um elemento vazio, passando assim um elemento vazio para ser
%   verificado como inteiro, o que retornaria falso.
gramatica_inteiros([X], []) :-
    integer(X).

%   nesse  cenario  passou-se  uma  cadeia  para  verificar  a  existencia de um
%   possivel numero inteiro uma vez que se juntar os membros dessa cadeia.
gramatica_inteiros([Head|Tail], []) :-
    gramatica_inteiros(Tail, []),
    gramatica_inteiros([Head], []).

%   --------------------------------- REAIS ------------------------------------

%   as  proximas  declaracoes  sao  bem  analogas  as  anteriores, so que para o
%   conjunto dos numeros reais.
gramatica_reais([], []) :-
    false.

%   sendo  o  'd'  a  representacao de digitos ja apresentada anteriormente, 'p'
%   simboliza  o  '.' que mostra a delimitação da parte inteira de um numero, ou
%   seja,  o  que  vier  depois dele sera a parte fracionaria; e o 'i' simboliza
%   caso o número seja complexo.
gramatica_reais("d --> d | [p]
p --> [d] | i", []).

gramatica_reais(X, []) :-
    number(X).

gramatica_reais([X], []) :-
    gramatica_reais(X, []).

gramatica_reais([Head|Tail], []) :-
    gramatica_reais(Tail, []),
    gramatica_reais(Head, []).

%   -------------------------------- RECEITA -----------------------------------

%   V == Verbo.
v(submerja).
v(tampe).

%   ART == Artigo.
art(os).
art(a).

%   N.
n(ovos).
n(acrescente).
n(sal).
n(panela).
n(deixe).

%   A.
a(ferver).

%   verifica a cada qual tipo pertence.
gramatica_receita(X, R) :-
    %   caso seja v
    v(X),
    R = "S";
    %   caso seja art
    art(X),
    R = "ART";
    %   caso seja n
    n(X),
    R = "N";
    %   caso seja a
    a(X),
    R = "A".

%   verificacao de seguranca.
gramatica_receita([], []) :-
    false.


%   retorna as regras da gramatica.
gramatica_receita("s --> [vp] | [np]
vp --> v | [np]
np --> [n_linha] | art | n
n_linha --> n | a", []).

%   retorna os argumentos que equivalem a gramatica apresentada.
gramatica_receita([X], R) :-
    gramatica_receita(X, R).

%   reconhece o tipo de gramatica e a retorna.
gramatica_receita([Head|Tail], [A|B]) :-
    gramatica_receita(Head, A),
    gramatica_receita(Tail, B).
