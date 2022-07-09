class Automaton:
    def __init__(self, states, alphabet, initial_state, final_states):
        self.states = states
        self.alphabet = alphabet
        self.initial_state = initial_state
        self.final_states = final_states
        self.lexem = "" # Lexema a ser utilizado na identificação da palavra processada
        self.current_state = initial_state # Estado atual do autômato, auxiliar para ajudar na transição
        self.stack = [] # Pilha de estados para processar cada transição de caracter da palavra 

    def transition(self, state, character):
        self.lexem += character

        # Ponteiro para checar se o caracter que estamos recebendo pertence ao alfabeto
        pointer = self.states[state].get(character)

        # Se o ponteiro cair em um estado de "error", representado por -1
        # então andamos com o ponteiro para o próximo ponteiro com erro
        # Do contrário, o estado atual passa a ser o estado que a transição andou 

        if pointer != -1:
            self.current_state = self.states[state].get(character, -1)
        else:
            pointer = self.states[state].get(character, -1)

        # Apenas uma organização para adicionar em ordem de estados que foram
        # passados para pilha. Dessa forma, evitamos que não tenha um estado de erro
        # e depois um estado válido ou algo do tipo.

        if self.current_state in self.final_states and pointer == -1:
            self.stack.append(-1)
        else:
            self.stack.append(self.current_state)

        return self.current_state
    
    def clear_final_state(self):
        while len(self.stack) != 0 and self.current_state in self.final_states:
            self.stack = self.stack[:-1]
            self.lexem = self.lexem[:-1]
        
        if self.current_state in self.final_states:
            return "Accepted"
        
        return "Rejected"