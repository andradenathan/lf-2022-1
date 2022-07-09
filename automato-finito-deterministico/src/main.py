"""
    Disciplina de Linguagens Formais - IC/UFRJ
    Analisador Léxico de Tabela
    Autômato Finito Deterministico

    Autores: Nathan Andrade | Bruna Ribeiro | Milton Quillinan
"""

from sys import argv
from automaton import *

def format_states(states):
    """
    Formatação dos estados recebidos no txt para adequação no dicionário
    que servirá como a tabela para transicionar os estados do autômato.
    """
    data = []
    final_state = []
    
    for idx, line in enumerate(states):
        if "Final" in line:
            final_state.append(idx)
        line = str.replace(line, "->", ":")
        line = line.replace(" ", "")
        line = line.replace(f"Estado{idx}(Inicial):", '')
        line = line.replace(f"Estado{idx}(Final):", '')
        line = line.replace(f"Estado{idx}:", '')
        line = line.replace("\n", '')
        line_dict = line.split(",")
        dict_data = {}
        for elem in line_dict:
            elem = elem.split(':')
            dict_data[elem[0]] = int(elem[1])
        
        data.append(dict_data)

    return data, final_state

def main():
    if len(argv) != 3:
        print("Erro ao especificar a entrada do programa")
        print("Tente novamente com: main.py <arquivo> <palavra>")
        exit(1)
        
    file = open(argv[1], "r")
    states, final_state = format_states(file.readlines())
    automaton = Automaton(states, ['a', 'b', 'c'], 0, final_state)
    
    word = argv[2]
    current_state = 0

    for w in word:
        current_state = automaton.transition(current_state, w)
    
    print(automaton.clear_final_state())

main()