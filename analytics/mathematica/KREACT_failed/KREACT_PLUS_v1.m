(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[         0,          0]
NotebookDataLength[     21733,        595]
NotebookOptionsPosition[     21017,        567]
NotebookOutlinePosition[     21352,        582]
CellTagsIndexPosition[     21309,        579]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{
   "KT", " ", "and", " ", "diffusion", " ", "constant", " ", "are", " ", 
    "set", " ", "to", " ", "one"}], "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"KT", " ", "=", " ", "1"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"d", "=", "1"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"RSink", " ", "=", " ", "1"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"W", " ", "=", " ", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"-", "w12"}], ",", " ", "w21"}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"w12", ",", 
         RowBox[{"-", "w21"}]}], "}"}]}], "}"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"EvecWtmp", "=", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         FractionBox["w21", "w12"], ",", "1"}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"-", "1"}], ",", "1"}], "}"}]}], "}"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"stmp", " ", "=", " ", 
     RowBox[{"Transpose", "[", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"Normalize", "[", 
         RowBox[{"EvecWtmp", "[", 
          RowBox[{"[", "1", "]"}], "]"}], "]"}], ",", 
        RowBox[{"Normalize", "[", 
         RowBox[{"EvecWtmp", "[", 
          RowBox[{"[", "2", "]"}], "]"}], "]"}]}], "}"}], "]"}]}], " ", ";"}],
    "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"invstmp", " ", "=", " ", 
     RowBox[{"Simplify", "[", 
      RowBox[{"Assuming", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"w12", ">", "0"}], ",", " ", 
          RowBox[{"w21", ">", "0"}]}], "}"}], ",", 
        RowBox[{"Inverse", "[", "stmp", "]"}]}], "]"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"DiagW", " ", "=", " ", 
     RowBox[{"Simplify", "[", 
      RowBox[{"invstmp", ".", "W", ".", "stmp"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"BCu", " ", "=", " ", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"Exp", "[", 
          RowBox[{"u1", "/", "kt"}], "]"}], ",", "0"}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"0", ",", 
         RowBox[{"Exp", "[", 
          RowBox[{"u2", "/", "kt"}], "]"}]}], "}"}]}], "}"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
     RowBox[{
     "Time", " ", "scale", " ", "of", " ", "switching", " ", "is", " ", 
      "given", " ", "by", " ", "\[Alpha]"}], ",", " ", 
     RowBox[{
     "ratio", " ", "of", " ", "rates", " ", "is", " ", "given", " ", "by", 
      " ", "\[Beta]", " ", "to", " ", "simplify", " ", "system", " ", "of", 
      " ", "linear", " ", "equations"}]}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{"(*", " ", 
    RowBox[{
    "\[Alpha]", " ", "is", " ", "basically", " ", "the", " ", "sum", " ", 
     "of", " ", "the", " ", "eigenvalues", " ", "divided", " ", "by", " ", 
     "D"}], " ", "*)"}], "\[IndentingNewLine]", 
   RowBox[{"(*", " ", 
    RowBox[{
     RowBox[{
     "\[Beta]", " ", "is", " ", "the", " ", "ratio", " ", "between", " ", 
      "the", " ", "eigenvalues"}], " ", "-", 
     RowBox[{
     "does", " ", "not", " ", "matter", " ", "if", " ", "divided", " ", "by", 
      " ", "D", " ", "since", " ", "they", " ", "cancel", " ", 
      RowBox[{"out", "!"}]}]}], " ", "*)"}], "\[IndentingNewLine]", 
   RowBox[{"DiagW", " ", "=", " ", 
    RowBox[{"DiagW", "/.", 
     RowBox[{
      RowBox[{
       RowBox[{"-", "w12"}], "-", "w21"}], " ", "->", "\[Alpha]"}]}]}], 
   "\[IndentingNewLine]", 
   RowBox[{"EvecW", "=", 
    RowBox[{"EvecWtmp", "/.", 
     RowBox[{
      RowBox[{"w21", "/", "w12"}], " ", "->", "\[Beta]"}]}]}], 
   "\[IndentingNewLine]", 
   RowBox[{"s", " ", "=", " ", 
    RowBox[{"Transpose", "[", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Normalize", "[", 
        RowBox[{"EvecW", "[", 
         RowBox[{"[", "1", "]"}], "]"}], "]"}], ",", 
       RowBox[{"Normalize", "[", 
        RowBox[{"EvecW", "[", 
         RowBox[{"[", "2", "]"}], "]"}], "]"}]}], "}"}], "]"}]}], " ", 
   "\[IndentingNewLine]", 
   RowBox[{"invs", "=", 
    RowBox[{"Simplify", "[", 
     RowBox[{"Assuming", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"w12", ">", "0"}], ",", " ", 
         RowBox[{"w21", ">", "0"}]}], "}"}], ",", 
       RowBox[{"Inverse", "[", "s", "]"}]}], "]"}], "]"}]}], 
   "\[IndentingNewLine]"}]}]], "Input",
 CellChangeTimes->{{3.6064567931171627`*^9, 3.6064570859039707`*^9}, {
  3.606457116736288*^9, 3.606457136113597*^9}, {3.606457881303858*^9, 
  3.606457989961047*^9}, {3.6064580306985283`*^9, 3.606458042523238*^9}, {
  3.60645807693828*^9, 3.606458130540311*^9}, {3.606458197597232*^9, 
  3.606458299604578*^9}, {3.606458377631126*^9, 3.606458379232354*^9}, {
  3.6064584865287533`*^9, 3.60645853998449*^9}, {3.606458834867798*^9, 
  3.606458835122952*^9}, {3.606459209770474*^9, 3.606459213015712*^9}, {
  3.606468097603006*^9, 3.606468189938552*^9}, {3.606468221236903*^9, 
  3.606468221348486*^9}, {3.606468323302079*^9, 3.606468324887085*^9}, {
  3.606468357766643*^9, 3.6064683771908293`*^9}, {3.60647202067879*^9, 
  3.60647202234319*^9}, {3.606535313077724*^9, 3.606535383342869*^9}, {
  3.606713737122542*^9, 3.606713738060306*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"BCu", " ", "=", " ", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Exp", "[", 
        RowBox[{"u1", "/", "KT"}], "]"}], ",", "0"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", 
       RowBox[{"Exp", "[", 
        RowBox[{"u2", "/", "KT"}], "]"}]}], "}"}]}], "}"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.606458044825941*^9, 3.6064580532904787`*^9}, {
  3.6064583185874147`*^9, 3.606458339228231*^9}, {3.606460420849758*^9, 
  3.6064604259856577`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"rhodash", "[", "r_", "]"}], " ", "=", " ", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"1", ",", " ", 
       RowBox[{"1", "/", "r"}], ",", " ", "0", ",", " ", "0"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", " ", "0", ",", " ", 
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{
          RowBox[{"-", 
           RowBox[{"Sqrt", "[", 
            RowBox[{
             RowBox[{"Abs", "[", 
              RowBox[{"DiagW", "[", 
               RowBox[{"[", 
                RowBox[{"2", ",", "2"}], "]"}], "]"}], "]"}], "/", "d"}], 
            "]"}]}], "r"}], "]"}], "/", "r"}], ",", 
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{
          RowBox[{"Sqrt", "[", 
           RowBox[{
            RowBox[{"Abs", "[", 
             RowBox[{"DiagW", "[", 
              RowBox[{"[", 
               RowBox[{"2", ",", "2"}], "]"}], "]"}], "]"}], "/", "d"}], 
           "]"}], "r"}], "]"}], "/", "r"}]}], "}"}]}], "}"}]}], " ", 
  "\[IndentingNewLine]"}]], "Input",
 CellChangeTimes->{{3.6064572313619137`*^9, 3.606457233586137*^9}, {
   3.606457308979266*^9, 3.606457316354701*^9}, 3.606458346012766*^9, {
   3.606460331362509*^9, 3.606460342386265*^9}, {3.6064703870223637`*^9, 
   3.606470399567018*^9}, {3.606617653938347*^9, 3.6066176683696957`*^9}, {
   3.606617765172037*^9, 3.60661776583777*^9}, {3.606617813326068*^9, 
   3.606617813814189*^9}, 3.6066179873038397`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{
   "These", " ", "are", " ", "the", " ", "\"\<NEW\>\"", " ", "boundary", " ", 
    "conditions"}], " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"lgs1", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"4", "\[Pi]", " ", 
         RowBox[{"RSink", "^", "2"}], " ", 
         RowBox[{
          RowBox[{"rhodash", "'"}], "[", "RSink", "]"}]}], "-", 
        RowBox[{"kReact", " ", 
         RowBox[{"rhodash", "[", "RSink", "]"}]}]}], ",", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
          "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
           ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{
          "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
           ",", "0"}], "}"}]}], "}"}], ",", "2"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"(*", " ", 
    RowBox[{
    "This", " ", "was", " ", "the", " ", "old", " ", "boundary", " ", 
     "condition"}], " ", "*)"}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
     RowBox[{"lgs1", " ", "=", " ", 
      RowBox[{"Join", "[", 
       RowBox[{
        RowBox[{"rhodash", "[", "RSink", "]"}], ",", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
            ",", "0"}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{
           "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
            ",", "0"}], "}"}]}], "}"}], ",", "2"}], "]"}]}], ";"}], "*)"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"lgs2", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
       RowBox[{"rhodash", "[", "a", "]"}], ",", " ", 
       RowBox[{"-", 
        RowBox[{"invs", ".", "BCu", ".", "s", ".", 
         RowBox[{"rhodash", "[", "a", "]"}]}]}], ",", " ", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}]}], "}"}], ",", 
       "2"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"lgs3", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"rhodash", "'"}], "[", "a", "]"}], ",", 
       RowBox[{"-", 
        RowBox[{
         RowBox[{"rhodash", "'"}], "[", "a", "]"}]}], ",", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}]}], "}"}], ",", 
       "2"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"lgs4", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}]}], "}"}], ",", 
       RowBox[{"invs", ".", "BCu", ".", "s", ".", 
        RowBox[{"rhodash", "[", "b", "]"}]}], ",", 
       RowBox[{"-", 
        RowBox[{"rhodash", "[", "b", "]"}]}], ",", "2"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"lgs5", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "0"}], "}"}]}], "}"}], ",", 
       RowBox[{
        RowBox[{"rhodash", "'"}], "[", "b", "]"}], ",", 
       RowBox[{"-", 
        RowBox[{
         RowBox[{"rhodash", "'"}], "[", "b", "]"}]}], ",", "2"}], "]"}]}], 
    ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"lgs6", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
          "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
           ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{
          "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
           ",", "0"}], "}"}]}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"1", ",", "0", ",", "0", ",", "0"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"0", ",", "0", ",", "0", ",", "Infinity"}], "}"}]}], "}"}], 
       ",", "2"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"lgs", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{
      "lgs1", ",", " ", "lgs2", ",", " ", "lgs3", ",", " ", "lgs4", ",", 
       "lgs5", ",", "lgs6", ",", "1"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{"lgs", " ", "=", " ", 
    RowBox[{"lgs", "[", 
     RowBox[{"[", 
      RowBox[{
       RowBox[{"1", ";;", "11"}], ",", 
       RowBox[{"1", ";;", "11"}]}], "]"}], "]"}]}]}]}]], "Input",
 CellChangeTimes->{{3.6064571599710073`*^9, 3.606457222336639*^9}, {
   3.606457342146409*^9, 3.606457343768423*^9}, {3.606480324448662*^9, 
   3.6064803341076813`*^9}, {3.606481920252211*^9, 3.6064820128224783`*^9}, {
   3.6064820547804956`*^9, 3.606482055894988*^9}, {3.606482166880865*^9, 
   3.6064822430613527`*^9}, {3.606562077420212*^9, 3.606562100643714*^9}, 
   3.606617643493005*^9, {3.6066179925511713`*^9, 3.606617995094445*^9}, 
   3.606624910464027*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{"c", " ", "=", 
   RowBox[{"TimeConstrained", "[", 
    RowBox[{
     RowBox[{"Assuming", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"w12", ">", "0"}], "&&", " ", 
         RowBox[{"w21", ">", "0"}], "&&", 
         RowBox[{"d", ">", "0"}], "&&", 
         RowBox[{"KT", ">", "0"}], "&&", 
         RowBox[{"b", ">", "a", ">", "RSink", ">", "0"}], "&&", 
         RowBox[{"kReact", ">", "0"}]}], "}"}], ",", " ", 
       RowBox[{"LinearSolve", "[", 
        RowBox[{"lgs", ",", 
         RowBox[{"Transpose", "[", 
          RowBox[{"{", 
           RowBox[{"{", 
            RowBox[{
            "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", ",", "0", 
             ",", "0", ",", "0", ",", "0", ",", "1"}], "}"}], "}"}], "]"}]}], 
        "]"}]}], "]"}], ",", "Infinity"}], "]"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.606457356658214*^9, 3.606457373539262*^9}, {
   3.606457728213807*^9, 3.606457752394889*^9}, {3.6064820632857227`*^9, 
   3.6064820745553226`*^9}, 3.606625018768691*^9, 3.606625484434548*^9, {
   3.606625538300919*^9, 3.606625541551612*^9}, {3.606625701883819*^9, 
   3.606625776813659*^9}}],

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"c", " ", "=", " ", 
     RowBox[{"Join", "[", 
      RowBox[{"c", ",", 
       RowBox[{"{", 
        RowBox[{"{", "0", "}"}], "}"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rhodash1", "[", "r_", "]"}], " ", "=", " ", 
     RowBox[{
      RowBox[{"rhodash", "[", "r", "]"}], ".", 
      RowBox[{"c", "[", 
       RowBox[{"[", 
        RowBox[{"1", ";;", "4"}], "]"}], "]"}]}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rhodash2", "[", "r_", "]"}], " ", "=", " ", 
     RowBox[{
      RowBox[{"rhodash", "[", "r", "]"}], ".", 
      RowBox[{"c", "[", 
       RowBox[{"[", 
        RowBox[{"5", ";;", "8"}], "]"}], "]"}]}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rhodash3", "[", "r_", "]"}], " ", "=", " ", 
     RowBox[{"Simplify", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"rhodash", "[", "r", "]"}], ".", 
        RowBox[{"c", "[", 
         RowBox[{"[", 
          RowBox[{"9", ";;", "12"}], "]"}], "]"}]}], ",", 
       RowBox[{"TimeConstraint", "\[Rule]", "Infinity"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"n", " ", "=", " ", 
    RowBox[{"Limit", "[", 
     RowBox[{
      RowBox[{"Total", "[", 
       RowBox[{"Total", "[", 
        RowBox[{"s", ".", 
         RowBox[{"rhodash3", "[", "r", "]"}]}], "]"}], "]"}], ",", 
      RowBox[{"r", "\[Rule]", "Infinity"}]}], "]"}]}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{"Calculate", " ", "density", " ", "profiles"}], "*)"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rho1", "[", "r_", "]"}], " ", "=", " ", 
     RowBox[{
      RowBox[{"s", ".", 
       RowBox[{"rhodash1", "[", "r", "]"}]}], "/", "n"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rho2", "[", "r_", "]"}], " ", "=", " ", 
     RowBox[{
      RowBox[{"s", ".", 
       RowBox[{"rhodash2", "[", "r", "]"}]}], "/", "n"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rho3", "[", "r_", "]"}], " ", "=", " ", 
     RowBox[{
      RowBox[{"s", ".", 
       RowBox[{"rhodash3", "[", "r", "]"}]}], "/", "n"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{"Calculate", " ", "mean", " ", "density", " ", "profiles"}], 
    "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rhom1", "[", "r_", "]"}], " ", "=", 
     RowBox[{
      RowBox[{"Part", "[", 
       RowBox[{
        RowBox[{"rho1", "[", "r", "]"}], ",", "1"}], "]"}], "+", " ", 
      RowBox[{"Part", "[", 
       RowBox[{
        RowBox[{"rho1", "[", "r", "]"}], ",", "2"}], "]"}]}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rhom2", "[", "r_", "]"}], " ", "=", 
     RowBox[{
      RowBox[{"Part", "[", 
       RowBox[{
        RowBox[{"rho2", "[", "r", "]"}], ",", "1"}], "]"}], "+", " ", 
      RowBox[{"Part", "[", 
       RowBox[{
        RowBox[{"rho2", "[", "r", "]"}], ",", "2"}], "]"}]}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"rhom3", "[", "r_", "]"}], " ", "=", 
     RowBox[{"Simplify", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"Part", "[", 
         RowBox[{
          RowBox[{"rho3", "[", "r", "]"}], ",", "1"}], "]"}], "+", " ", 
        RowBox[{"Part", "[", 
         RowBox[{
          RowBox[{"rho3", "[", "r", "]"}], ",", "2"}], "]"}]}], ",", 
       RowBox[{"TimeConstraint", "\[Rule]", "Infinity"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"(*", " ", 
    RowBox[{
     RowBox[{"Calculate", " ", "absorption", " ", "rate"}], ",", 
     RowBox[{"this", " ", "is", " ", "just", " ", "kReact", " ", "x", " ", 
      RowBox[{"rho", "[", "RSink", "]"}], " ", "for", " ", "this", " ", 
      "problem"}], ",", " ", 
     RowBox[{"as", " ", "deduced", " ", "from", " ", 
      RowBox[{"B", ".", "C", "."}]}]}], " ", "*)"}]}]}]], "Input",
 CellChangeTimes->{{3.606458812300761*^9, 3.606458814480352*^9}, {
   3.6064589331380043`*^9, 3.606459055367022*^9}, {3.606459149717681*^9, 
   3.6064591505001907`*^9}, {3.606462913329714*^9, 3.606462930752222*^9}, {
   3.60646425928179*^9, 3.606464287391028*^9}, {3.606618033738287*^9, 
   3.606618037494866*^9}, {3.6066182142294292`*^9, 3.606618219091083*^9}, 
   3.60661825523755*^9, {3.606618300584173*^9, 3.606618339420101*^9}, {
   3.606618393589327*^9, 3.606618406835862*^9}, {3.606618460175828*^9, 
   3.60661846445356*^9}, {3.6067134042382727`*^9, 3.60671341019105*^9}, {
   3.60671344851145*^9, 3.6067134579514093`*^9}, {3.606714532378179*^9, 
   3.606714580908635*^9}, {3.606714793520726*^9, 3.60671479556601*^9}, {
   3.606714847422185*^9, 3.606714853312908*^9}}],

Cell[BoxData[
 RowBox[{"Directory", "[", "]"}]], "Input",
 CellChangeTimes->{{3.606647389672338*^9, 3.606647394711141*^9}}],

Cell[BoxData[{
 RowBox[{"Clear", "[", 
  RowBox[{
  "u1", ",", "u2", ",", "\[Alpha]", ",", " ", "\[Beta]", ",", " ", "a", ",", 
   " ", "b", ",", "kReact"}], "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ktmp", "=", "  ", 
   RowBox[{"Total", "[", 
    RowBox[{
     RowBox[{"rhom1", "'"}], "[", "RSink", "]"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Put", "[", 
  RowBox[{"ktmp", ",", "\"\<non_simplified_ratev1.tmp\>\""}], "]"}]}], "Input",
 CellChangeTimes->{
  3.606647143332561*^9, {3.60664718390373*^9, 3.606647215593351*^9}, {
   3.6066472476320972`*^9, 3.606647281741624*^9}, {3.606647312397649*^9, 
   3.606647314487102*^9}, {3.606653840166678*^9, 3.606653849624003*^9}, {
   3.6067135120612288`*^9, 3.606713512096733*^9}}],

Cell[BoxData[{
 RowBox[{"k", "=", 
  RowBox[{"Simplify", "[", 
   RowBox[{"ktmp", ",", 
    RowBox[{"TimeConstraint", "\[Rule]", "Infinity"}]}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"k", ">>", 
  "\"\<simplified_ratev1.tmp\>\""}], "\[IndentingNewLine]", "k"}], "Input",
 CellChangeTimes->{{3.606464370094795*^9, 3.6064643971685658`*^9}, {
   3.606618064790083*^9, 3.606618068325927*^9}, {3.606618356170597*^9, 
   3.606618379183752*^9}, {3.606618451038928*^9, 3.606618452602193*^9}, {
   3.606625826013835*^9, 3.606625830298158*^9}, {3.606644349786952*^9, 
   3.606644498084815*^9}, 3.606644555033164*^9, {3.606647068906842*^9, 
   3.606647076126079*^9}, {3.606713513868679*^9, 3.606713513915202*^9}, {
   3.6067136885613728`*^9, 3.6067136894225597`*^9}}]
},
WindowSize->{1022, 714},
WindowMargins->{{0, Automatic}, {Automatic, 0}},
FrontEndVersion->"9.0 for Linux x86 (64-bit) (February 7, 2013)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[400, 13, 5390, 142, 476, "Input"],
Cell[5793, 157, 536, 15, 32, "Input"],
Cell[6332, 174, 1485, 38, 77, "Input"],
Cell[7820, 214, 5552, 151, 275, "Input"],
Cell[13375, 367, 1191, 28, 55, "Input"],
Cell[14569, 397, 4796, 129, 385, "Input"],
Cell[19368, 528, 123, 2, 32, "Input"],
Cell[19494, 532, 752, 17, 77, "Input"],
Cell[20249, 551, 764, 14, 77, "Input"]
}
]
*)

