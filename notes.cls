\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2018/08/28 Article class with some note-taking optimizations]

\LoadClass{article}

\RequirePackage{geometry}
\RequirePackage{algpseudocode}
\RequirePackage{marginnote}
\RequirePackage{float}
\RequirePackage{amsmath,amsthm,amssymb,mathtools}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tabularx}
\RequirePackage{kvoptions}
\RequirePackage{ifthen}
\RequirePackage{multicol}
\RequirePackage{listings}
\RequirePackage{lstautogobble}
\RequirePackage{enumitem}
\RequirePackage{tikz}
\RequirePackage[lighttt]{lmodern}
\RequirePackage{array,multirow,enumitem}
\RequirePackage{color}
\RequirePackage[utf8]{inputenc}
\RequirePackage{CJK}
\RequirePackage[backend=bibtex,style=ieee]{biblatex}
\RequirePackage[toc,page]{appendix}
\RequirePackage[american]{babel}
\RequirePackage[american,orig]{isodate}
\usepackage{xparse}

\usetikzlibrary{patterns}
\usetikzlibrary{calc}
\usetikzlibrary{cd}
\usetikzlibrary{graphs}
\usetikzlibrary{matrix}

\DeclareStringOption[0.5in]{margin}
\DeclareStringOption[1in]{rmargin}
\DeclareStringOption[]{numbering}
\ProcessKeyvalOptions*\relax

\ifthenelse{\lengthtest{\notes@rmargin < \notes@margin}}{\renewcommand{\notes@rmargin}{\notes@margin}}{}
\DeclareOption{nomlabel}{\renewcommand{\notes@rmargin}{\notes@margin}}
\DeclareOption{smalltitle}{
	\let\oldtitle\title
	\renewcommand{\title}[1]{\oldtitle{\vspace*{-2em}#1}}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\RequirePackage[\notes@numbering]{algorithm}

\geometry{margin=\notes@margin, rmargin=\notes@rmargin}

%\setlength\itemsep{10em}
\newenvironment{ul}{\begin{itemize}}{\end{itemize}}
\newenvironment{ol}{\begin{enumerate}}{\end{enumerate}}
\newcommand{\li}{\item}

\newenvironment{alg}[1]{\begin{minipage}{\linewidth}\begin{algorithm}[H]\caption{#1} \begin{algorithmic}[1]}{\end{algorithmic}\end{algorithm}\end{minipage}}

\newenvironment{ctab}{\begin{center}\begin{tabular}}{\end{tabular}\end{center}}

\newenvironment{tab}[2]{\begin{minipage}{\linewidth}\begin{table}[H]\caption{#2}\begin{ctab}{#1}}{\end{ctab}\end{table}\end{minipage}}


\newcommand{\email}[1]{\href{mailto:#1}{#1}}

\newcommand{\mlabel}[1]{\phantomsection\marginnote{\textnormal{#1}} \addcontentsline{toc}{subsubsection}{\textbullet~#1}}

\newcommand{\code}{\lstinline}

\floatstyle{ruled}
\ifthenelse{\equal{\notes@numbering}{}}{
	\newfloat{innerdiagram}{H}{diag}
	\newcounter{codeblock}
	\newtheorem{theorem}{Theorem}
	\newtheorem{lemma}{Lemma}
	
	\renewcommand{\thecodeblock}{\arabic{codeblock}}
}{
	\newfloat{innerdiagram}{H}{diag}[section]
	\newcounter{codeblock}[\notes@numbering]
	\newtheorem{theorem}{Theorem}[\notes@numbering]
	\newtheorem{lemma}{Lemma}[\notes@numbering]
	
	\renewcommand{\thecodeblock}{\arabic{\notes@numbering}.\arabic{codeblock}}
}
\floatname{innerdiagram}{Diagram}

\newenvironment{diagram}[2][tikz]{
	\newcommand{\diagramenv}{#1}
	\hfill\allowbreak
	\par\noindent\begin{minipage}{\linewidth}
	\begin{innerdiagram}[H]
	\caption{#2 \diagramenv}
	\begin{equation*}
	\begin{\diagramenv}
}{
	\end{\diagramenv}
	\end{equation*}
	\end{innerdiagram}
	\end{minipage}
}

\def\defaultlang{}
\newcommand{\setlang}[1]{\def\defaultlang{#1}}

\newcommand{\codeblockname}{Code Block}
\newcommand{\lstnumbername}{\@gobble}
\lstset{
	basicstyle=\ttfamily,
	keywordstyle=\bfseries,
    commentstyle=\slshape,
	breaklines=true,
	showstringspaces=false,
    tabsize=4,
	autogobble=true
}
\lstnewenvironment{codeblock}[2][\defaultlang]{
	\hfill\allowbreak
	\minipage{\linewidth}
	\rule{\textwidth}{1.2pt}
	\refstepcounter{codeblock}
	\textbf{Code Block \thecodeblock}: \textit{#2}
	\vspace{3pt}\hrule
	\lstset{language={#1}, escapeinside={{@<}{>@}}}
}{
	\hrule
	\endminipage
	\hfill\allowbreak
}

\newcommand{\commandfactory}[2]{\expandafter\def\csname #1#2\endcsname}
%\def\counters{%
%	{section,sec},
%	{subsection,subsec},
%	{subsubsection,subsubsec},
%	{enumi,i},
%	{enumii,ii},
%	{enumiii,iii}}
%\foreach \x in \counters {
%	\StrCut{\x}{,}{\fullname}{\shortname}
%	`\fullname' `\shortname' \par
%	\commandfactory{set}{\shortname}{\setcounter{\fullname}}
%}
% TODO Work in progress
%\commandfactory{set}{iii}{\setcounter{enumiii}}
%\setiii{9}

\newcommand{\setnext}[2]{\setcounter{#1}{\numexpr#2-1\relax}}

\newcommand{\stepsec}{\stepcounter{section}}
\newcommand{\setsec}{\setcounter{section}}
\newcommand{\setsubsec}{\setcounter{subsection}}
\newcommand{\seti}{\setcounter{enumi}}
\newcommand{\setii}{\setcounter{enumii}}

\newcommand{\tand}{\textrm{ and }}
\newcommand{\tor}{\textrm{ or }}

\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Q}{\mathbb{Q}}

\renewcommand{\triangle}{\vartriangle}
\newcommand{\contradict}{\ensuremath{\Rightarrow\!\Leftarrow}}

\newcommand{\textTODO}{\textcolor{red}{TODO}}
\newcommand{\TODO}{\ifmmode\text{\textTODO}\else\textTODO\fi}

\newcommand{\True}{\textsc{True}}
\newcommand{\False}{\textsc{False}}
\newcommand{\len}{\mathrm{len}}

\newcommand{\pmat}[1]{\ensuremath{\begin{pmatrix}#1\end{pmatrix}}}
\newcommand{\inv}{\ensuremath{^{-1}}}
\newcommand{\Pset}{\mathcal{P}}

\newcommand{\subgroup}{\leqslant}
\newcommand{\nsubgroup}{\nleqslant}
\newcommand{\supgroup}{\geqslant}
\newcommand{\nsupgroup}{\ngeqslant}