# Lab #1 - Introduction to VHDL

- VHDL is case-insensitive

### MUX model

entity:

```vhdl
ENTITY mux2 IS

PORT ( IN1,IN2,SEl: IN std_logic;
OUT1 : OUT std_logic);

END ENTITY mux2;
```

in a another way:

```vhdl
ENTITY mux2 IS
PORT (
in1  : IN  std_logic;
in2  : IN  std_logic;
sel  : IN  std_logic;
out1 : OUT std_logic  -- no ; in last line in port
);
END mux2;
```

archeticture:

```vhdl
ARCHITECTURE arch1 OF mux2 IS
BEGIN

out1 <= (in1 and (not Sel))
or
(in2 and Sel);

END arch1;
```

### MUX 4x1

entity:

```vhdl
ENTITY mux4 IS

PORT( in0,in1,in2,in3: IN std_logic;
sel : IN std_logic_vector (1 DOWNTO 0);
out1: OUT std_logic);

END mux4;
```

Data flow architecture:

```vhdl
ARCHITECTURE arch1 OF mux4 IS
BEGIN

 out1 <= in0 WHEN sel(0) = ‘0’ AND sel(1) =‘0’
 ELSE in1 WHEN sel(0) = ‘0’ AND sel(1) =‘1’
 ELSE in2 WHEN sel(0) = ‘1’ AND sel(1) =‘0’
 ELSE in3;   -- one statement

END arch1;
```

### Making Mux 4x1 from Mux 2x1 ( structural )

```vhdl
ARCHITECTURE struct OF mux8 IS
**COMPONENT** mux2 IS

PORT (IN1,IN2,SEl: IN std_logic;
OUT1 : OUT std_logic);

END **COMPONENT** ;
SIGNAL x1,x2 : std_logic;   -- defining before BEGIN

BEGIN
-- Label to identify component with while tracing
u0: mux2 PORT MAP (in0,in1,s(0),x1);
u1: mux2 PORT MAP (in2,in3,s(0),x2);
u2: mux2 PORT MAP (x1,x2,s(1),out1);
END struct;
```

### Types of modeling

- Dataflow
• Describes the flow of data within a component/system.
- Structural
• Describes the component by the interconnection of lower level components/primitives
- Behavioral
• Describes the functionality of a component/system usually using a process
- Mixed of the above ways

### Data Type (STD_LOGIC)

- Include
• Library ieee;
• Use ieee.std_logic_1164.all
- Std_logic Possible values
• 1 or 0
• X → for conflict
• Z → high impedance (remember tristate buffer?)
• U → undefined
• others

### Data Type(STD_LOGIC_VECTOR)

- a,b : in std_logic_vector(2 downto 0)
- Can be accessed like b(2) , b(1)
- To access all vector
• a <= b;
- To access a range of the vector
• b(1 downto 0) <= a(2 downto 1)
- ‘&’ operator to concatenate two vectors or vector and single element
• b(1 downto 0 ) <= a(2) & ‘0’
