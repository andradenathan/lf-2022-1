"""
    Disciplina de Linguagens Formais - IC/UFRJ
    Analisador Léxico de Tabela
    Autômato Finito Deterministico

    Autores: Nathan Andrade | Bruna Ribeiro | Milton Quillinan
"""

from sys import argv
from automaton import *

def main():
    states = [
        {'a': 1, 'b': 1, 'c': -1},
        {'a': 1, 'b': 3, 'c': 3},
        {'a': -1, 'b': 3, 'c': 3},
        {'a': 4, 'b': 3, 'c': 4},
        {'a': -1, 'b': -1, 'c': -1}
    ]

    automaton = Automaton(states, ['a', 'b', 'c'], 0, [4])
    word = "acbbbaagg"
    current_state = 0

    for w in word:
        current_state = automaton.transition(current_state, w)
        
    print(automaton.clear_final_state())

main()
