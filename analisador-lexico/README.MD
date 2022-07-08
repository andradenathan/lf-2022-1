Para utilizar o autômato é necessário inserir dentro de um arquivo a sua
tabela contendo as transições partindo de um estado para o outro. O estado
que for final, deve ser informado com (Final).

A representação da transição de um estado para outro deve ser com a setinha "->".

Exemplo de tabela:

Estado 0 (Inicial): a -> 1, b -> 1, c -> -1<br />
Estado 1: a -> 1, b -> 3, c -> 3<br />
Estado 2: a -> 1, b -> 3, c -> 3<br />
Estado 3: a -> 4, b -> 3, c -> 4<br />
Estado 4 (Final): a -> -1, b -> -1, c -> -1<br />

Para executar o programa, digite no terminal: main.py <nome_do_arquivo> <palavra>.
