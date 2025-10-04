# Lab #2 - Intro to VHDL

## With…Select

```vhdl
ARCHITECTURE b_mux OF mux
BEGIN
with sel select
out1 <=

in0 when "00",
in1 when "01",
in2 when "10",
in3 when "11";
-- No latches can be formed since 'with...select' can't
-- accept any missed cases
END b_mux;
```

## OTHERS

Use it when you want to:

- Set a bus to several zeros or several 1s but you don’t want to write it.

```vhdl
F <= “00000000000000000000000000000000”;
F <= x“00000000”; -- hexdecimal
F<= (Others => ‘0’);
```

- Set a certain bit to value and others zero.

```vhdl
F<= (7=>‘1’, Others => ‘0’);
```

- Generic Case in Switch Cases.

```vhdl
With S select
F <= a when “0010”,
b when others;
```

## Generic Entities

### 4 Bit-full Adder

```vhdl
ENTITY my_nadder IS

PORT (a, b : IN std_logic_vector(3 DOWNTO 0) ;

cin : IN std_logic;
s : OUT std_logic_vector(3 DOWNTO 0);
cout : OUT std_logic);

END my_nadder;

ARCHITECTURE a_my_nadder OF my_nadder IS
COMPONENT my_adder IS
PORT( a,b,cin : IN std_logic; s,cout : OUT std_logic);
END COMPONENT;
SIGNAL temp : std_logic_vector(4 DOWNTO 0);
BEGIN
Temp(0) <= cin;
f0: my_adder PORT MAP(a(0),b(0),temp(0),s(0),temp(1));
f1: my_adder PORT MAP(a(1),b(1),temp(1),s(1),temp(2));
f2: my_adder PORT MAP(a(2),b(2), temp(2),s(2),temp(3));
f3: my_adder PORT MAP(a(3),b(3), temp(3),s(3),temp(4));
Cout <= temp(4);
END a_my_nadder;
```

### From Specific to Generic

```vhdl
ENTITY my_nadder IS
GENERIC (n : integer := 8);
PORT (a, b : IN std_logic_vector(n-1 DOWNTO 0) ;

cin : IN std_logic;
s : OUT std_logic_vector(n-1 DOWNTO 0);
cout : OUT std_logic);

END my_nadder;

--Integer is another data type
--8 is default value and could be override while instantiation
--Notice the use of ‘n’ here But where did we define “n”
--Add generic input

ARCHITECTURE a_my_nadder OF my_nadder IS
COMPONENT my_adder IS
PORT( a,b,cin : IN std_logic; s,cout : OUT std_logic);
END COMPONENT;
SIGNAL temp : std_logic_vector(n DOWNTO 0); -- Change size of signal
BEGIN
temp(0) <= cin;
**loop1: FOR i IN 0 TO n-1 GENERATE**
**fx: my_adder PORT MAP(a(i),b(i),temp(i),s(i),temp(i+1));**
END GENERATE;
Cout <= temp(n);
END a_my_nadder;
--i is not visible outside the for generate
```

- We use FOR GENERATE when we want to generate more than one component of the same type.
- The (for ...generate) is not a Software Sequential loop .. It is like writing this line n times and
they execute concurrently. Generates N hardware
- So after I made my entity generic when I instantiate I do the following

```vhdl
u0: my_nadder GENERIC MAP (16) PORT MAP (......)
--I indicate here the value of the generic data
--Generic could be more than one parameter like generic
--Even could be with different type
```

- In simulation

```
vsim my_nadder –g<genericName>=<value>
```
