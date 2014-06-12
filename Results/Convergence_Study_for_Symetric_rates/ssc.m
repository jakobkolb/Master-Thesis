Clear["Global`*"]

fk[a_, b_, u1_, 
  u2_, \[Alpha]_, \[Beta]_] := (a b Sqrt[
     1 + Abs[\[Beta]]^2] (-2 E^((1 + a) Sqrt[\[Alpha]]) (E^u1 - 
         E^u2) \[Beta] ((-1 + a) E^(u1 + 2 a Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) + (-1 + 
            a) E^(u1 + 2 b Sqrt[\[Alpha]]) (1 + a Sqrt[\[Alpha]]) (1 +
             b Sqrt[\[Alpha]]) - 
         2 (-1 + a) b E^(u1 + (a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] + (-1 + 
            a) E^(u2 + 2 a Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + (-1 + 
            a) E^(u2 + 2 b Sqrt[\[Alpha]]) (1 + a Sqrt[\[Alpha]]) (1 +
             b Sqrt[\[Alpha]]) \[Beta] - 
         2 (-1 + a) b E^(u2 + (a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + (-1 + 
            a) E^(2 b Sqrt[\[Alpha]]) (1 + a Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) - (-1 + 
            a) E^(2 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         2 (a - b) E^(u1 + u2 + (a + b) Sqrt[\[Alpha]]) (1 + 
            
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] (1 + \[Beta])) Sqrt[\
\[Alpha]/(1 + Abs[\[Beta]]^2)] + 
      1/(Sqrt[1 + 
           Abs[\[Beta]]^2]) (E^(2 u1 + 4 a Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
         E^(2 u2 + 4 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] - 
         E^(2 (u1 + (1 + a) Sqrt[\[Alpha]])) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
         E^(2 (u2 + (1 + a) Sqrt[\[Alpha]])) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
         E^(2 (u1 + (1 + b) Sqrt[\[Alpha]])) (1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
         E^(2 (u2 + (1 + b) Sqrt[\[Alpha]])) (1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
         E^(2 (u1 + (a + b) Sqrt[\[Alpha]])) (1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
         E^(2 (u2 + (a + b) Sqrt[\[Alpha]])) (1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
         2 b E^(2 u1 + (2 + a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         4 b E^(u1 + u2 + (2 + a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
         2 b E^(2 u2 + (2 + a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         2 b E^(2 u1 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
         4 b E^(u1 + u2 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         2 b E^(2 u2 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         E^(u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (-1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (-1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
         E^(u2 + 4 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
         E^(2 u1 + u2 + 4 a Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(u2 + 2 (1 + a) Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(2 u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
         E^(2 u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(2 u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
         E^(u1 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
         E^(u1 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
         E^(u1 + 2 (u2 + (a + b) Sqrt[\[Alpha]])) (-1 + 
            a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - 
         E^(u1 + 4 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - 
         E^(u1 + 2 u2 + 4 a Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
         E^(u1 + 2 (1 + a) Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - 
         E^(u1 + 2 (u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
         E^(u1 + 2 (u2 + (1 + b) Sqrt[\[Alpha]])) (1 + 
            a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
         2 E^(u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
            a Sqrt[\[Alpha]]) (-1 + (-1 + 
               b Sqrt[\[Alpha]]) \[Beta] - \[Beta]^2) + 
         2 E^(u1 + u2 + 4 a Sqrt[\[Alpha]]) (-1 + 
            a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta] + \[Beta]^2) + 
         2 E^(u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta] + 
            a Sqrt[\[Alpha]] \[Beta] + \[Beta]^2) + 
         2 E^(u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + \[Beta] - 
            b Sqrt[\[Alpha]] \[Beta] + \[Beta]^2 + 
            a (-Sqrt[\[Alpha]] \[Beta] + 
               b \[Alpha] (1 + \[Beta] + \[Beta]^2)))) + \[Beta] (2 \
E^((1 + a) Sqrt[\[Alpha]]) (E^u1 - 
            E^u2) ((-1 + a) E^(u1 + 2 a Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) + (-1 + 
               a) E^(u1 + 2 b Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) - 
            2 (-1 + a) b E^(u1 + (a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] + (-1 + 
               a) E^(u2 + 2 a Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] + (-1 + 
               a) E^(u2 + 2 b Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
            2 (-1 + a) b E^(u2 + (a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + (-1 + 
               a) E^(2 b Sqrt[\[Alpha]]) (1 + a Sqrt[\[Alpha]]) (-1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) - (-1 + 
               a) E^(2 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
            2 (a - b) E^(u1 + u2 + (a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] (1 + \[Beta])) Sqrt[\
\[Alpha]/(1 + Abs[\[Beta]]^2)] + 
         1/(Sqrt[1 + 
              Abs[\[Beta]]^2]) (E^(2 u1 + 4 a Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
            E^(2 u2 + 4 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 +
                b Sqrt[\[Alpha]]) \[Beta] - 
            E^(2 (u1 + (1 + a) Sqrt[\[Alpha]])) (-1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
            E^(2 (u2 + (1 + a) Sqrt[\[Alpha]])) (-1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
            E^(2 (u1 + (1 + b) Sqrt[\[Alpha]])) (1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] - 
            E^(2 (u2 + (1 + b) Sqrt[\[Alpha]])) (1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
            E^(2 (u1 + (a + b) Sqrt[\[Alpha]])) (1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
            E^(2 (u2 + (a + b) Sqrt[\[Alpha]])) (1 + 
               a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
            2 b E^(2 u1 + (2 + a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
            4 b E^(u1 + u2 + (2 + a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
            2 b E^(2 u2 + (2 + a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
            2 b E^(2 u1 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
            4 b E^(u1 + u2 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
            2 b E^(2 u2 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
            E^(u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (-1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
            E^(u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (-1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
            E^(u2 + 4 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
            E^(2 u1 + u2 + 4 a Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
            E^(u2 + 2 (1 + a) Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
            E^(2 u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
            E^(2 u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
            
            E^(2 u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
            E^(u1 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (-1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
            E^(u1 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (-1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
            E^(u1 + 2 (u2 + (a + b) Sqrt[\[Alpha]])) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - 
            E^(u1 + 4 a Sqrt[\[Alpha]]) (-1 + a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - 
            E^(u1 + 2 u2 + 4 a Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
            E^(u1 + 2 (1 + a) Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - 
            E^(u1 + 2 (u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
            E^(u1 + 2 (u2 + (1 + b) Sqrt[\[Alpha]])) (1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
            2 E^(u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
               a Sqrt[\[Alpha]]) (-1 + (-1 + 
                  b Sqrt[\[Alpha]]) \[Beta] - \[Beta]^2) + 
            2 E^(u1 + u2 + 4 a Sqrt[\[Alpha]]) (-1 + 
               a Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta] + \[Beta]^2) + 
            2 E^(u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
               b Sqrt[\[Alpha]]) (1 + \[Beta] + 
               a Sqrt[\[Alpha]] \[Beta] + \[Beta]^2) + 
            2 E^(u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + \[Beta] - 
               b Sqrt[\[Alpha]] \[Beta] + \[Beta]^2 + 
               a (-Sqrt[\[Alpha]] \[Beta] + 
                  b \[Alpha] (1 + \[Beta] + \[Beta]^2)))))))/((1 + \
\[Beta]) (-2 a^3 b (E^u1 - E^u2)^2 (E^((2 + a + b) Sqrt[\[Alpha]]) + 
         E^((3 a + b) Sqrt[\[Alpha]])) \[Alpha] \[Beta] + 
      b (-1 + E^u1) (-1 + 
         E^u2) (1 + \[Beta]) (E^(u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 - 
            b Sqrt[\[Alpha]]) + 
         E^(u2 + 2 (1 + b) Sqrt[\[Alpha]]) (-1 + b Sqrt[\[Alpha]]) - 
         E^(u2 + 4 a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) + 
         E^(u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) + 
         E^(u1 + 2 (1 + b) Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) \[Beta] - 
         E^(u1 + 4 a Sqrt[\[Alpha]]) (1 + b Sqrt[\[Alpha]]) \[Beta] + 
         E^(u1 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] + 
         E^(u1 + u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
         E^(u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) - 
         E^(u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(u1 + 2 (a + b) Sqrt[\[Alpha]]) (\[Beta] - 
            b Sqrt[\[Alpha]] \[Beta])) + 
      a^2 Sqrt[\[Alpha]] (2 b E^(2 u1 + (2 + a + 
                b) Sqrt[\[Alpha]]) (-1 + Sqrt[\[Alpha]]) \[Beta] - 
         4 b E^(u1 + u2 + (2 + a + b) Sqrt[\[Alpha]]) (-1 + 
            Sqrt[\[Alpha]]) \[Beta] + 
         2 b E^(2 u2 + (2 + a + b) Sqrt[\[Alpha]]) (-1 + 
            Sqrt[\[Alpha]]) \[Beta] + 
         2 b E^(2 u1 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
            Sqrt[\[Alpha]]) \[Beta] - 
         4 b E^(u1 + u2 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
            Sqrt[\[Alpha]]) \[Beta] + 
         2 b E^(2 u2 + (3 a + b) Sqrt[\[Alpha]]) (1 + 
            Sqrt[\[Alpha]]) \[Beta] - 
         2 b E^(u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] + 
         E^(2 (u1 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (-1 + b - \[Beta]) \[Beta] + 
         E^(2 (u1 + (1 + b) Sqrt[\[Alpha]])) (-1 + 
            b^2 Sqrt[\[Alpha]] + 
            b (-1 + 
               Sqrt[\[Alpha]] (-1 + \[Beta])) - \[Beta]) \[Beta] - 
         E^(2 (u1 + (a + b) Sqrt[\[Alpha]])) (-1 - 
            b^2 Sqrt[\[Alpha]] + 
            b (1 + Sqrt[\[Alpha]] (-1 + \[Beta])) - \[Beta]) \[Beta] \
- (1 + b) E^(u2 + 2 (1 + b) Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) + (1 + 
            b) E^(u2 + 2 (a + b) Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) - (1 + 
            b) E^(u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) + (1 + 
            b) E^(u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) - (1 + 
            b) E^(2 u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) + 
         E^(2 u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
            b^2 Sqrt[\[Alpha]] + 
            b (1 + Sqrt[\[Alpha]] (1 - 
                  2 \[Beta]))) (1 + \[Beta]) - (1 + 
            b) E^(u1 + 2 (1 + b) Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + (1 + 
            b) E^(u1 + 2 (a + b) Sqrt[\[Alpha]]) (-1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - (1 + 
            b) E^(u1 + 2 (u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) - (1 + 
            b) E^(u1 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + (1 + 
            b) E^(u1 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta]) + 
         E^(2 (u1 + u2 + 2 a Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta])^2 + 
         E^(2 (u1 + u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta])^2 - 
         E^(2 (u1 + u2 + (1 + b) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta])^2 - 
         E^(2 (u1 + u2 + (a + b) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta])^2 + 
         E^(2 u1 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + b + \[Beta]) - 
         E^(2 u1 + u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (1 + b + 2 \[Beta]) + 
         E^(2 u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + \[Beta]) (1 + 
            b + b Sqrt[\[Alpha]] + b^2 Sqrt[\[Alpha]] + 2 \[Beta]) + 
         E^(2 (u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (-1 + (-1 + b) \[Beta]) + 
         E^(2 u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta] + b \[Beta]) - 
         E^(u1 + 2 u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (2 + \[Beta] + 
            b \[Beta]) + 
         E^(u1 + 2 (u2 + (1 + 
                   b) Sqrt[\[Alpha]])) (1 + \[Beta]) (2 + (1 + b) (1 +
                b Sqrt[\[Alpha]]) \[Beta]) + 
         E^(2 (u2 + (a + b) Sqrt[\[Alpha]])) (1 + 
            b (Sqrt[\[Alpha]] (-1 + \[Beta]) - \[Beta]) + \[Beta] + 
            b^2 Sqrt[\[Alpha]] \[Beta]) + 
         E^(u1 + 2 (u2 + (a + 
                   b) Sqrt[\[Alpha]])) (1 + \[Beta]) (\[Beta] + 
            b^2 Sqrt[\[Alpha]] \[Beta] + 
            b (Sqrt[\[Alpha]] (-2 + \[Beta]) + \[Beta])) + 
         E^(2 (u2 + (1 + b) Sqrt[\[Alpha]])) (-1 - \[Beta] + 
            b^2 Sqrt[\[Alpha]] \[Beta] - 
            b (Sqrt[\[Alpha]] (-1 + \[Beta]) + \[Beta])) + 
         2 E^(u1 + u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) ((1 + \[Beta])^2 + 
            b (1 + \[Beta] + \[Beta]^2)) - 
         2 E^(u1 + u2 + 
             2 (1 + b) Sqrt[\[Alpha]]) (b^2 Sqrt[\[Alpha]] \[Beta] + \
(1 + \[Beta])^2 + 
            b (1 + \[Beta] - 2 Sqrt[\[Alpha]] \[Beta] + \[Beta]^2)) + 
         2 b E^(u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (\[Beta] + 
            Sqrt[\[Alpha]] (1 + \[Beta]^2 + 
               b (1 + \[Beta] + \[Beta]^2)))) - 
      a (E^(2 (u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (-1 + 
            b (Sqrt[\[Alpha]] (-1 + \[Beta]) - \[Beta]) - \[Beta]) - 
         2 b E^(2 u1 + (2 + a + b) Sqrt[\[Alpha]]) (2 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
         4 b E^(u1 + u2 + (2 + a + b) Sqrt[\[Alpha]]) (2 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         2 b E^(2 u2 + (2 + a + b) Sqrt[\[Alpha]]) (2 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
         2 b E^(2 u1 + (3 a + b) Sqrt[\[Alpha]]) (2 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         4 b E^(u1 + u2 + (3 a + b) Sqrt[\[Alpha]]) (2 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] + 
         2 b E^(2 u2 + (3 a + b) Sqrt[\[Alpha]]) (2 + 
            b Sqrt[\[Alpha]]) Sqrt[\[Alpha]] \[Beta] - 
         E^(u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + b - 
            2 b Sqrt[\[Alpha]] + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha])) (1 + \[Beta]) + 
         E^(u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + b - 
            2 b Sqrt[\[Alpha]] + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha])) (1 + \[Beta]) - 
         E^(u2 + 4 a Sqrt[\[Alpha]]) (1 + b + 2 b Sqrt[\[Alpha]] + 
            b^2 (Sqrt[\[Alpha]] + \[Alpha])) (1 + \[Beta]) + 
         E^(u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + b + 
            2 b Sqrt[\[Alpha]] + 
            b^2 (Sqrt[\[Alpha]] + \[Alpha])) (1 + \[Beta]) - 
         E^(u1 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + b - 
            2 b Sqrt[\[Alpha]] + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha])) \[Beta] (1 + \[Beta]) + 
         E^(u1 + 2 (a + b) Sqrt[\[Alpha]]) (1 + b - 
            2 b Sqrt[\[Alpha]] + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha])) \[Beta] (1 + \[Beta]) - 
         E^(u1 + 4 a Sqrt[\[Alpha]]) (1 + b + 2 b Sqrt[\[Alpha]] + 
            b^2 (Sqrt[\[Alpha]] + \[Alpha])) \[Beta] (1 + \[Beta]) + 
         E^(u1 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + b + 
            2 b Sqrt[\[Alpha]] + 
            b^2 (Sqrt[\[Alpha]] + \[Alpha])) \[Beta] (1 + \[Beta]) + 
         E^(2 (u1 + u2 + 2 a Sqrt[\[Alpha]])) (1 + 
             b Sqrt[\[Alpha]])^2 (1 + \[Beta])^2 - 
         E^(2 (u1 + u2 + (a + b) Sqrt[\[Alpha]])) (1 + 
             b Sqrt[\[Alpha]])^2 (1 + \[Beta])^2 + 
         E^(2 (u1 + u2 + (1 + a) Sqrt[\[Alpha]])) (-1 + 
            b^2 \[Alpha]) (1 + \[Beta])^2 - 
         E^(2 (u1 + u2 + (1 + b) Sqrt[\[Alpha]])) (-1 + 
            b^2 \[Alpha]) (1 + \[Beta])^2 - 
         E^(2 (u1 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + 
            b (1 + Sqrt[\[Alpha]] (-1 + \[Beta])) + \[Beta]) - 
         E^(2 (u1 + (a + b) Sqrt[\[Alpha]])) \[Beta] (1 + 
            b (1 - 2 Sqrt[\[Alpha]] (-1 + \[Beta])) + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha] (-1 + \[Beta])) + \
\[Beta]) + 
         E^(2 u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (1 + b - 
            b Sqrt[\[Alpha]] + 2 \[Beta]) - 
         E^(u1 + 2 (u2 + (1 + a) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (-2 + (-1 + 
               b (-1 + Sqrt[\[Alpha]])) \[Beta]) + 
         E^(u1 + 2 (u2 + (1 + b) Sqrt[\[Alpha]])) (1 + \[Beta]) (-2 + 
            b (2 Sqrt[\[Alpha]] - \[Beta]) - \[Beta] + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha]) \[Beta]) + 
         E^(u1 + 2 (u2 + (a + b) Sqrt[\[Alpha]])) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (2 + \[Beta] + 
            b (Sqrt[\[Alpha]] (-2 + \[Beta]) + \[Beta])) + 
         E^(2 (u2 + (a + b) Sqrt[\[Alpha]])) (-1 - \[Beta] - 
            b (2 Sqrt[\[Alpha]] (-1 + \[Beta]) + \[Beta]) + 
            b^2 (\[Alpha] (-1 + \[Beta]) + Sqrt[\[Alpha]] \[Beta])) + 
         E^(2 u1 + u2 + 2 (1 + b) Sqrt[\[Alpha]]) (1 + \[Beta]) (-1 + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha]) - 2 \[Beta] + 
            b (-1 + 2 Sqrt[\[Alpha]] \[Beta])) + 
         E^(2 (u1 + (1 + b) Sqrt[\[Alpha]])) \[Beta] (1 + 
            b + \[Beta] - 2 b Sqrt[\[Alpha]] \[Beta] + 
            b^2 (-Sqrt[\[Alpha]] + \[Alpha] + \[Alpha] \[Beta])) + 
         E^(2 (u2 + (1 + b) Sqrt[\[Alpha]])) (1 + \[Beta] + 
            b (-2 Sqrt[\[Alpha]] + \[Beta]) + 
            b^2 (\[Alpha] - 
               Sqrt[\[Alpha]] \[Beta] + \[Alpha] \[Beta])) - 
         2 E^(u1 + u2 + 2 (1 + a) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) ((1 + \[Beta])^2 + 
            b (1 + \[Beta] + 2 Sqrt[\[Alpha]] \[Beta] + \[Beta]^2)) + 
         2 E^(u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (-(1 + \[Beta])^2 - 
            b (1 + \[Beta] - 4 Sqrt[\[Alpha]] \[Beta] + \[Beta]^2) + 
            b^2 (\[Alpha] - 
               Sqrt[\[Alpha]] \[Beta] + \[Alpha] \[Beta]^2)) + 
         E^(2 u1 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) \[Beta] (1 + \[Beta] + 
            b (1 + Sqrt[\[Alpha]] (1 + \[Beta]))) + 
         E^(2 u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta] + 
            b (\[Beta] + Sqrt[\[Alpha]] (1 + \[Beta]))) + 
         2 E^(u1 + u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) ((1 + \[Beta])^2 + 
            b (1 + \[Beta] + \[Beta]^2 + 
               Sqrt[\[Alpha]] (1 + \[Beta])^2)) - 
         E^(u1 + 2 u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (2 + \[Beta] + 
            b (\[Beta] + Sqrt[\[Alpha]] (2 + \[Beta]))) - 
         E^(2 u1 + u2 + 2 (a + b) Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (-1 - 2 \[Beta] + 
            b (-1 + Sqrt[\[Alpha]] (-1 + 2 \[Beta]))) - 
         E^(2 u1 + u2 + 4 a Sqrt[\[Alpha]]) (1 + 
            b Sqrt[\[Alpha]]) (1 + \[Beta]) (1 + 2 \[Beta] + 
            b (1 + Sqrt[\[Alpha]] (1 + 2 \[Beta]))) + 
         2 E^(u1 + u2 + 
             2 (1 + b) Sqrt[\[Alpha]]) (b^2 Sqrt[\[Alpha]] \[Beta] + \
(1 + \[Beta])^2 + 
            b (1 + \[Beta] + \[Beta]^2 - 
               Sqrt[\[Alpha]] (1 + 4 \[Beta] + \[Beta]^2))))))

d = 1;
U01 = 3;
U02 = 0;
a = 8.5;
b = 2.5;
at = a - b;
bt = a + b;
nmin = 4;
nmax = 7;
npoints = nmax - nmin + 1
Rsink = 1;
Rmax = 30;
t0 = 0;
t1 = 1000;
rdmin = -4;
rdmax = 2;
datapoints = 24;
u1[r_] := U01 Exp[-((r - a)/b)^n];
u2[r_] := U02 Exp[-((r - a)/b)^n];
pde = {D[\[Rho]1[r, t], t] == 
    2/r \[Rho]1[r, t] u1'[r] + 
     D[\[Rho]1[r, t], r] u1'[r] + \[Rho]1[r, t] u1''[r] + 
     d 2/r D[\[Rho]1[r, t], r] + d D[\[Rho]1[r, t], r, r] - 
     w12 \[Rho]1[r, t] + w21 \[Rho]2[r, t],
   D[\[Rho]2[r, t], t] == 
    2/r \[Rho]2[r, t] u2'[r] + 
     D[\[Rho]2[r, t], r] u2'[r] + \[Rho]2[r, t] u2''[r] + 
     d 2/r D[\[Rho]2[r, t], r] + d D[\[Rho]2[r, t], r, r] - 
     w21 \[Rho]2[r, t] + w12 \[Rho]1[r, t]
   };
bc = {
   \[Rho]1[Rsink, t] == 0,
   \[Rho]2[Rsink, t] == 0,
   \[Rho]1[Rmax, t] == w21/(w12 + w21),
   \[Rho]2[Rmax, t] == w12/(w12 + w21)
   };
ic = {
   \[Rho]1[r, t0] == w21/(w12 + w21)*(1 - 1/r),
   \[Rho]2[r, t0] == w12/(w12 + w21)*(1 - 1/r)
   };


Densities = 
  Table[0, {k, 1, 3}, {i, 1, datapoints + 1}, {j, 1, npoints + 1}];
ReactionRate = 
  Table[0, {k, 1, 2}, {i, 1, datapoints + 1}, {j, 1, npoints + 1}];

For[j = 0, j <= npoints, j++,
 n = 2^(nmin + j);
 For[i = 0, i <= datapoints, i++,
  rd = 10^(rdmin + i*(rdmax - rdmin)/datapoints);
  w21 = d/(2*rd^2);
  w12 = w21;
  sol = NDSolve[{pde, bc, ic}, {\[Rho]1, \[Rho]2}, {t, t1, t1}, {r, 
     Rsink, Rmax}, MaxSteps -> Infinity, MaxStepFraction -> 0.002, 
    AccuracyGoal -> 15, StartingStepSize -> 0.001, 
    WorkingPrecision -> MachinePrecision, 
    Method -> {"MethodOfLines", 
      "SpatialDiscretization" -> {"TensorProductGrid", 
        "MinPoints" -> 24000}}];
  Print["Done", "n=", n, "i=", i, "w12=", N[w12]];
  \[Rho]1eq[r_] = \[Rho]1[r, t1] /. sol;
  \[Rho]2eq[r_] = \[Rho]2[r, t1] /. sol;
  \[Rho]tot[r_] = (\[Rho]1[r, t1] + \[Rho]2[r, t1]) /. sol;
  
  Densities[[1, i + 1, j + 1]] = \[Rho]1eq[r];
  Densities[[2, i + 1, j + 1]] = \[Rho]2eq[r];
  Densities[[3, i + 1, j + 1]] = \[Rho]tot[r];
  ReactionRate[[1, i + 1, j + 1]] = rd;
  ReactionRate[[2, i + 1, j + 1]] = D[\[Rho]tot[r], r] /. r -> 1;
  ]]

b = Table[0, {i, 1, npoints + 1}];
b[[1]] = N[ReactionRate[[1, All, 1]]];
For[j = 1, j <= npoints, j++,
 b[[j + 1]] = N[0.94382*Flatten[ReactionRate[[2, All, j]]]];
 ]
Export["numeric_rates.csv", Transpose[b]];

resolution = 100
c = Table[{N[10^rd], 
    fk[at, bt, U01, U02, d/(10^rd)^2, 1]}, {rd, rdmin, 
    rdmax, (rdmax - rdmin)/resolution}];
Export["analytic_rates.csv", N[c]]
