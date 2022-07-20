# Linguagem LF

## Analisador léxico

Especificações
- Variáveis como palavras que não iniciam com número;
- Números inteiros e flutuantes;
- Palavras reservadas (for, while, if, else, int, float, bool, true e false);
- Comentários de linha e comentários aninhados;
- Chaves e parêntesis;
- Variáveis e constantes;
- Dois pontos e ponto e vírgula.

Para executar o programa é necessário um arquivo de entrada contendo o código da linguagem LF. Uma vez que o arquivo existir, basta rodar os seguintes comandos no terminal:

```
flex main.l
gcc lex.yy.c
./a.out <arquivo>
```

<br/>

Observações

Os comentários não são salvos no arquivo de saída do programa, mas são ignorados totalmente pelo analisador léxico, quando aberto e fechado corretamente (para o caso de aninhamento de comentário).

Os números inteiros não podem ser começados com 0, se começado, a parte
correspondente ao 0 será lida e o número restante também 
será identificado como número inteiro.