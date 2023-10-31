# This is a GPT UI-improved version of the MVP. 

import tkinter as tk

def button_click(row, column):
    # Toggle the button state
    button_states[row][column] = not button_states[row][column]
    update_button_state(row, column)

    # Update LEDSEL list
    if button_states[row][column]:
        LEDSEL.append((row, column))
    else:
        LEDSEL.remove((row, column))

def update_button_state(row, column):
    state = button_states[row][column]

    # Set the relief based on the state (depressed or not)
    relief = tk.SUNKEN if state else tk.RAISED
    buttons[row][column].config(relief=relief, bg='red' if state else 'dark grey')

def done_button_click():
    print("LEDSEL:", LEDSEL)
    display_ledsel_window()

def display_ledsel_window():
    # Cálculos y manejo de binarios:
    rowmat = [[] for _ in range(8)] ## Ahora para cada fila tiene los encendidos
    for i in range(0,8):
        for tupl in LEDSEL:
            if tupl[0] == i:
                rowmat[i].append(tupl)
            else:
                None
    print(rowmat)
            
    
    # Ahora convertir a binarios de 8'b dónde seleccionados = 1
    binmat = [[] for _ in range(8)]
    for i in range(8):
        parserow = rowmat[i]
        parserow = sorted(parserow, key=lambda x: x[1])  # Organize based on the second element
        if len(parserow) != 0:
            for j in range(8):
                found = False
                for tup in parserow:
                    if tup[1] == j:
                        binmat[i].append(1)
                        found = True
                        break  # Exit the inner loop once a match is found
                if not found:
                    binmat[i].append(0)
        else:
            binmat[i].extend([0] * 8)
    print(binmat)

    # Ahora generamos el código de salida:
    # (Generado por GPT)
    binary_strings = []
    for i, row in enumerate(binmat):
        binary_string = ''.join(map(str, row))
        binary_strings.append(f"DATA_FIXED_INITREGBACKG_{i}= 8b'{binary_string}'")

    # DISPLAY TK
    ledsel_window = tk.Toplevel(root)
    ledsel_window.title("LEDSEL Output")
    ledsel_window.configure(bg='black')

    # Create a Text widget for displaying the LEDSEL content
    ledsel_text = tk.Text(ledsel_window, font=('Arial', 12), wrap=tk.WORD, height=500, width=700, fg='white', bg='black')
    ledsel_text.pack(padx=20, pady=20)

    # Insert the binary strings into the Text widget
    for binary_str in binary_strings:
        ledsel_text.insert(tk.END, binary_str + '\n')

# Main window
root = tk.Tk()
root.geometry("800x400")
root.title("8-bit Register-Value generator for FPGA controlled 8^2 led screen")
root.configure(bg='black')

label = tk.Label(root, text="8-bit Register-Value generator for FPGA controlled 8^2 led screen", font=('Consolas', 15), fg='#4245f5', bg='black')

# Button Frame
buttonframe = tk.Frame(root, bg='black')

# Initialize button states
button_states = [[False] * 8 for _ in range(8)]

# Initialize LEDSEL list
LEDSEL = []

# Initialize buttons
buttons = []
for i in range(8):
    button_row = []
    for j in range(8):
        button = tk.Button(buttonframe, text=(str(i) + ' ' + str(j)), font=('Arial', 10), command=lambda row=i, col=j: button_click(row, col), bg='#242424', fg='white', relief=tk.RAISED)
        button.grid(row=i, column=j, sticky=(tk.W + tk.E))
        button_row.append(button)
    buttons.append(button_row)

# "Done" button
done_button = tk.Button(root, text="Done", command=done_button_click, font=('Arial', 12), bg='#4245f5', fg='#FFFFFF', relief=tk.RAISED)
done_button.place(x=500, y=100, width=150, height=150)

label.pack(pady=10)
buttonframe.pack(padx=20, pady=10, fill='x')
root.mainloop()
