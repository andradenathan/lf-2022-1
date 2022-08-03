# Linguagem LF

## Analisador léxico

Especificações
- Variáveis como palavras que não iniciam com número;
- Números inteiros e flutuantes;
- Palavras reservadas (while, if, else, int, float, bool, true e false);
- Comentários de linha e comentários aninhados;
- Chaves e parêntesis;
- Variáveis e constantes;
- Dois pontos e ponto e vírgula.


Observações

Os comentários não são salvos no arquivo de saída do programa, mas são ignorados totalmente pelo analisador léxico, quando aberto e fechado corretamente (para o caso de aninhamento de comentário).

Os números inteiros não podem ser começados com 0, se começado, a parte
correspondente ao 0 será lida e o número restante também 
será identificado como número inteiro.

## Analisador sintático
Os tokens estão seguindo de acordo com o solicitado do exercício, tokens para funções, variáveis, atribuição de variável, tipagem de variável e de retorno de função, um ou mais parâmetro com seu tipo separado por vírgula e palavras chaves como: if, while, fn, int, float, bool. 

## Compilar o programa
Para executar o programa é necessário um arquivo de entrada contendo o código da linguagem LF. Uma vez que o arquivo existir, basta rodar os seguintes comandos no terminal:
```
flex lex.l
bison -d parser.y
gcc -o out lex.yy.c parser.tab.c -lfl
./out <arquivo.txt>
```

### Autores
- Bruna Ribeiro - 118171816<br/>
- Milton Quillinan - 118144649<br/>
- Nathan Andrade - 120082390