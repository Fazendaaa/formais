%   Para  instalar  no  Linux  basta  procurar o pacote 'swi-prolog', e rodar no
%   terminal com o comando:
%
%                           swipl gramaticas.pl
%
%   obs:  mesmo  que  a  extensao seja a mesma de Perl, recomendo nao mudar para
%   .pro  para evitar conflito uma vez que na minha máquina o SWI nao reconheceu
%   tal  extensao  como  valida.  Alem  disso,  para  matar  o  programa deve-se
%   pressionar Ctrl + D -- no Windows nao sei como seria, provavelment Ctrl + Z.
%
%   Use  o  segundo  comando  na  sua interface SWI-Prolog para fazer o teste do
%   codigo:
%   
%                      gerar_interios([ 1, 2, 3 ], []).
%

%   caso  o usuario nao passe nenhuma cadeia valida para teste, se deve retornar
%   como teste invalido -- falso.
gerar_inteiros([], []) :-
    false.

%   retorna em X as possiveis cadeias.
gerar_inteiros("s --> b | [a], s.\nb --> [b], c.\nc --> [b].\n", []).

%   caso  o  usuario  passe  uma  cadeia e gostaria de verificar se ela formaria
%   numberos ou nao.
%
%   esse  primeiro  exemplo  serve  para caso a cadeia tenha apenas um elemento,
%   como o segundo exemplo nao pegaria  tal  cenario, o primeiro exemplo teve de
%   ser  criado, isso porque se fosse apenas um elemento o segundo caso trataria
%   a  cauda  como  um elemento vazio, passando assim um elemento vazio para ser
%   verificado como inteiro, o que retornaria falso.
gerar_inteiros([X], []) :-
    integer(X).

%   nesse  cenario  passou-se  uma  cadeia  para  verificar  a  existencia de um
%   possivel numero inteiro uma vez que se juntar os membros dessa cadeia.
gerar_inteiros([Head|Tail], []) :-
    gerar_inteiros(Tail, []),
    gerar_inteiros([Head], []).

%   as  proximas  declaracoes  sao  bem  analogas  as  anteriores, so que para o
%   conjunto dos numeros reais.
gerar_reais([], []) :-
    false.

gerar_reais(X, []) :-
    number(X).

gerar_reais([X], []) :-
    gerar_reais(X, []).

gerar_reais([Head|Tail], []) :-
    gerar_reais(Tail, []),
    gerar_reais(Head, []).

gerar_receita(X, []) :-
    true.
