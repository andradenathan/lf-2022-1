class Automaton:
    def __init__(self, states, alphabet, initial_state, final_states):
        self.states = states
        self.alphabet = alphabet
        self.initial_state = initial_state
        self.final_states = final_states
        self.lexem = ""
        self.current_state = initial_state
        self.stack = []

    def transition(self, state, character):
        self.lexem += character
        pointer = self.states[state].get(character)
        if pointer != -1:
            self.current_state = self.states[state].get(character, -1)
        else:
            pointer = self.states[state].get(character, -1)

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
            return "Valid"
        
        return "Rejected"