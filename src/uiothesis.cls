% UiO LaTeX Thesis Class
\ProvidesClass{uiothesis}
\NeedsTeXFormat{LaTeX2e}

% Based on the memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions
\LoadClass{memoir}


%%
%% Variables
%%

% Internal variables
\newcommand{\@subtitle}{}
\newcommand{\@scm}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\scm}[1]{\renewcommand{\@scm}{#1}}


%%
%% Global setup
%%

% Font setup
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{MinionPro}
\renewcommand{\scdefault}{ssc}
\newfont{\chapnum}{eurb10 scaled 8000}

% Creates an fourier ornament. Args: fontsize, lineheight, char
\RequirePackage{fourier-orns}
\newcommand*{\fourierOrnament}[3]{{%
  \fontencoding{U}\fontfamily{futs}\fontsize{#1}{#2}\selectfont\char#3}}

% Laying out the page
\settypeblocksize{*}{28pc}{2}
\setlrmargins{*}{*}{3}
\setulmargins{*}{*}{2}
\setmarginnotes{2pc}{12pc}{\baselineskip}
\checkandfixthelayout

% Coloring
\RequirePackage{color}
\definecolor{chapnum}{gray}{0.55}
\definecolor{ornament}{gray}{0.85}

% No orphans
\clubpenalty = 10000
\widowpenalty = 10000


%%
%% Division styles
%%

% Chapter style
\makechapterstyle{uio}{%
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \marginpar{%
      \vspace{80pt}
      \color{chapnum}\chapnum \thechapter
      \vspace{20pt}
    }%
  }%
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \raggedright\huge\scshape ##1
  }%
}

% Section style
\setsecheadstyle{\raggedright\Large}
\setsubsecheadstyle{\raggedright\large}
\setsubsubsecheadstyle{\raggedright\itshape}


%%
%% Tops and tails
%%

% Page style
\makepagestyle{uio}
\makeevenfoot{uio}{\thepage}{}{}
\makeoddfoot{uio}{}{}{\thepage}

% Plain headers and footers
\makeevenfoot{plain}{\thepage}{}{}
\makeoddfoot{plain}{}{}{\thepage}

%%
%% Lists
%%

% Table of Contents
\maxtocdepth{subsection}

\renewcommand{\cftchapterfont}{\scshape}
\renewcommand{\cftchapterpagefont}{\scshape}
\renewcommand{\cftchapterpresnum}{\hspace*{-1.5em}}
\cftsetindents{chapter}{1.5em}{0em}
\renewcommand{\cftchapterleader}{}
\renewcommand{\cftchapterafterpnum}{\cftparfillskip}

\renewcommand{\cftsectionfont}{\small}
\renewcommand{\cftsectionpagefont}{\small}
\cftsetindents{section}{1.5em}{2.3em}
\renewcommand{\cftsectionleader}{}
\renewcommand{\cftsectionafterpnum}{\cftparfillskip}

\renewcommand{\cftsubsectionfont}{\small}
\renewcommand{\cftsubsectionpagefont}{\small}
\cftsetindents{subsection}{3.8em}{2.8em}
\renewcommand{\cftsubsectionleader}{}
\renewcommand{\cftsubsectionafterpnum}{\cftparfillskip}

% List of Figures/Tables
\renewcommand{\cftfigureleader}{ }
\renewcommand{\cftfigureafterpnum}{\cftparfillskip}

\renewcommand{\cfttableleader}{ }
\renewcommand{\cfttableafterpnum}{\cftparfillskip}

% Enumeratable list
\newenvironment{enum}{%
  \begin{list}{\arabic{enumi}}{%
    \setlength{\topsep}{\onelineskip}
    \setlength{\partopsep}{0pt}
    \setlength{\parsep}{\parskip}
    \setlength{\itemsep}{\parskip}
    \setlength{\leftmargin}{0pt}
    \setlength{\itemindent}{0pt}
    \usecounter{enumi}
  }
}{\end{list}}

% Itemized list
\newenvironment{items}{%
  \begin{list}{\textbullet}{%
    \setlength{\topsep}{\onelineskip}
    \setlength{\partopsep}{0pt}
    \setlength{\parsep}{\parskip}
    \setlength{\itemsep}{\parskip}
    \setlength{\leftmargin}{0pt}
    \setlength{\itemindent}{0pt}
  }
}{\end{list}}

% Definitions in lists
\newcommand{\iterm}[1]{\item \term{#1}}


%%
%% Fixes to marginpar
%%

\RequirePackage{afterpage}
\RequirePackage{mparhack}

\global\newif\if@firstrun \@firstruntrue

\ifx\@currbox\@undefined
  \newbox\@currbox
\fi

\def\marginparP#1#2{%
  % pass two arguments:
  %  1) a label name for the marginpar (enter regular text without
  %     spaces or numbers or funny chars)
  %  2) the content of the marginpar
  %
  % This assumes that the new marginpar command (\marginparP, the
  % "P" is for "penalty") is placed as the first item
  % in the new paragraph and is glued
  % to the front of the first word in the paragraph.
  %
  % The approach was to wrap the marginpar command in another macro
  % and let latex compile the first time with no margin pars.  I also
  % set a label so that I can tell on the next pass if the block went
  % to the next page.  If so, I save a code that says to send the
  % marginpar to the next page, else I save a different code that
  % says to leave the marginpar alone. All subsequent compiles will
  % use the selected placement for the marginpar.
  %

  % save some page numbers
  \edef\MPPhere{\thepage}%
  \edef\MPPlabel{\pageref{#1}}%
  %
  % Write a code to the aux file that will process in the
  % next compile and tell me that I'm no longer in the
  % "first run" (not in the first compile of the LaTeX
  % document):
  \protected@write\@auxout{}{%
      \string\gdef\string\secondrun{1}}%
  \@ifundefined{secondrun}{%
    \typeout{*********** first run}%
    % I am printing a character to leave vertical mode.
    % When this happens, the label will stick to the text while
    % the call to \marginparP will remain on the old page because
    % latex is still collecting info for the prior paragraph until
    % it hits a character or a \leavevmode command (or something
    % like that.
    %{.}\label{#1}%
    \leavevmode\label{#1}%
  }%
  {% after first run:
    \@firstrunfalse
    \typeout{*** beyond first run}%
    % this is the second run or beyond
    \@ifundefined{thirdrun}{%
      % this is exactly the second run, so run it exactly once:
      \ifnum\MPPhere=\MPPlabel
        \typeout{**** the par stayed on the original page}%
        \marginpar{#2}%
        \protected@write\@auxout{}{%
        \string\gdef\string\thirdrun{1}}%code 1 for "old page"
      \else
        % push the margin par to the next page by redefining the macro
        % that was defined after the first word of the line
        \typeout{**** the par moved to the next page}%
        \afterpage{\protect\marginpar{#2}}%
        \protected@write\@auxout{}{%
        \string\gdef\string\thirdrun{2}}%code 2 for "next page"
      \fi
   }%
   {% else we are on the third run or beyond
     % use the saved value in "thirdrun" to determine how to
     % place the float
     \typeout{*** third run or more}%
     \ifnum2=\thirdrun
       \afterpage{\protect\marginpar{#2}}%
     \else
       \marginpar{#2}
     \fi
     \protected@write\@auxout{}{%
       \string\gdef\string\thirdrun{\thirdrun}}%save the code
    }
  }
  % note that "\string{" writes a left parenthesis, and the "{"
  % does not open a argument for the \string macro:
} 


%%
%% Side notes/tables/figures
%%

% Captions
\RequirePackage{caption}
\captionsetup[figure]{font={footnotesize,sf},%
                      justification=RaggedRight,%
                      singlelinecheck=false}
\captionsetup[table]{font={footnotesize,sf},%
                     justification=RaggedRight,%
                     singlelinecheck=false,%
                     position=bottom}

% The mark on the sidenote
\newcommand{\sidemark}[1]{#1.{\:}}

% Automatic aligned sidenote
\DeclareRobustCommand{\sidenote}[2][0em]{%
  \strictpagechecktrue
  \ifodd\c@page
    \oddsidenote[#1]{#2}
  \else
    \evensidenote[#1]{#2}
  \fi
}%

% Forced right or left aligned sidenote
\DeclareRobustCommand{\oddsidenote}[2][0em]{%
  \footnotemark%
  \marginpar{%
    \vspace*{#1}
    \RaggedRight \footnotesize
    \sidemark{\thefootnote}\ignorespaces#2
  }%
}%
\DeclareRobustCommand{\evensidenote}[2][0em]{%
  \footnotemark%
  \marginpar{%
    \vspace*{#1}
    \RaggedLeft \footnotesize
    \sidemark{\thefootnote}\ignorespaces#2
  }%
}%

% Sidetable
\newcommand{\sidetable}[2]{%
  \marginpar{%
    \strictpagechecktrue
    \ifodd\c@page
      \captionsetup{font=footnotesize,%
                    justification=RaggedRight,%
                    singlelinecheck=false}
      \RaggedRight
    \else
      \captionsetup{font=footnotesize,%
                    justification=RaggedLeft,%
                    singlelinecheck=false}
      \RaggedLeft
    \fi
    \footnotesize #2
    \captionof{table}{#1}
  }
}

% Sidefigure
\newcommand{\sidefigure}[3]{%
  \marginpar{%
    \strictpagechecktrue
    \ifodd\c@page
      \captionsetup{font=footnotesize,%
                    justification=RaggedRight,%
                    singlelinecheck=false}
      \RaggedRight
    \else
      \captionsetup{font=footnotesize,%
                    justification=RaggedLeft,%
                    singlelinecheck=false}
      \RaggedLeft
    \fi
    \footnotesize #3
    \captionof{figure}[#1]{#2}
  }
}

%%
%% Environments
%%

% Full width quote environment
\renewenvironment{quote}{%
  \list{}{%
    \setlength{\topsep}{\baselineskip}
    \setlength{\partopsep}{0pt}
    \setlength{\itemindent}{0pt}
    \setlength{\listparindent}{0pt}
    \setlength{\leftmargin}{0pt}
  }%
  \itshape\item[]
}{\endlist}

\newlength{\wholemargin}\setlength{\wholemargin}{\marginparwidth}
\addtolength{\wholemargin}{\marginparpush}
\newlength{\wholewidth}\setlength{\wholewidth}{\textwidth}
\addtolength{\wholewidth}{\wholemargin}

% Whole environment
\newenvironment{whole}{%
  \centering
  \strictpagechecktrue
  \begin{adjustwidth*}{0em}{-\wholemargin}
}{%
  \end{adjustwidth*}
}

% Code environment
\newcommand{\@codelabel}{undefined}
\newcommand{\@codeshortcaption}{undefined}
\newcommand{\@codeverbosecaption}{undefined}
\newenvironment{scode}[4]{%
  \renewcommand{\@codelabel}{#2}
  \renewcommand{\@codeshortcaption}{#3}
  \renewcommand{\@codeverbosecaption}{#4}
  \begin{sourcecode}[!h]
    \lstset{language=#1}
}{%
    \caption[\@codeshortcaption]{\@codeverbosecaption}
    \label{sourcecode:\@codelabel}
  \end{sourcecode}
}


%%
%% PDF and PS specifics
%%

\RequirePackage{ifpdf}
\ifpdf
  \RequirePackage[pdftex,plainpages=false]{hyperref}
  \RequirePackage[protrusion=true,expansion=false,final=true]{microtype}
\else
  \RequirePackage[ps2pdf]{hyperref}
  \RequirePackage{breakurl}
\fi
\RequirePackage{memhfixc}


%%
%% Hyperlinks
%%

\urlstyle{sf}

\hypersetup{%
  colorlinks=false,
  breaklinks,
  pdfborder=0 0 0,
}


%%
%% Code listings
%%

\RequirePackage{listings}

\lstset{%
  basicstyle=\footnotesize,
  numbers=left,
  numberstyle=\footnotesize\texttt,
  showstringspaces=false,
  frame=l,
  captionpos=b,
}

% New float for source code
\newcommand{\sourcecodename}{Source Code Listing}
\newcommand{\listsourcecodename}{List of Source Code}
\newlistof{listofsourcecode}{sc}{\listsourcecodename}
\newfloat[chapter]{sourcecode}{sc}{\sourcecodename}
\newfixedcaption{\fdiagcaption}{sourcecode}
\newlistentry{sourcecode}{sc}{0}

\captionsetup[sourcecode]{position=bottom,font={footnotesize,sf}}


%%
%% Reference shorthands.
%%

\newcommand\figureref[1]{%
  Figure~\ref{figure:#1}%
}
\newcommand\figurepageref[1]{%
  \figureref{#1}
  (p.~\pageref{figure:#1})%
}
\newcommand\tableref[1]{%
  Table~\ref{table:#1}%
}
\newcommand\tablepageref[1]{%
  \tableref{#1}
  (p.~\pageref{table:#1})%
}
\newcommand\sourcecoderef[1]{%
  Source Code Listing~\ref{sourcecode:#1}%
}
\newcommand\sourcecodepageref[1]{%
  \sourcecoderef{#1}
  (p.~\pageref{sourcecode:#1})%
}
\newcommand\chapterref[1]{%
  Chapter~\ref{chapter:#1}
  (p.~\pageref{chapter:#1})%
}
\newcommand\sectionref[1]{%
  \textsection~\ref{section:#1}
  (p.~\pageref{section:#1})%
}
\newcommand\appendixref[1]{%
  Appendix~\ref{appendix:#1}
  (p.~\pageref{appendix:#1})%
}


%%
%% Declerative formatting
%%

% Items to attend to
\newcommand{\todo}[1]{$\bigotimes$ #1 $\bigotimes$}

% Phrase marker
\newcommand{\dash}{ -- }

% Code snippet
\newcommand{\code}[1]{\texttt{{#1}}}

% UNIX-style variable name.
\newcommand{\var}[1]{\code{\${#1}}}

% Executable name
\let\executable\code

% Term (first usage)
\newcommand{\term}[1]{\textit{{#1}}}

% Title of artistic or academic work
\newcommand{\work}[1]{\textsw{{#1}}}

% Latin expressions
\let\latin\term

% Abbreviations (mostly acronyms, but all full caps abbreviations)
\newcommand{\abbr}[1]{\textsc{\MakeLowercase{#1}}}

% Project name (first usage?)
\newcommand{\project}[1]{\textsf{{#1}}}

% Quotation
\newcommand{\q}[1]{``#1''}

% A value
\let\val\q

% Inline quotations
\newcommand{\prequote}[4][]{\citet[#1]{#2} #3 \q{#4}.}
\newcommand{\openprequote}[4][]{\citet[#1]{#2} #3 \q{#4}}

\newcommand{\postquote}[3][]{\q{#3} \citep[#1]{#2}.}
\newcommand{\postquoteyear}[3][]{\q{#3} \citeyearpar[#1]{#2}.}
\newcommand{\openpostquote}[3][]{\q{#3} \citep[#1]{#2}}
\newcommand{\openpostquoteyear}[3][]{\q{#3} \citeyearpar[#1]{#2}}

% Double page citation
\newcommand{\citedouble}[4]{%
  (\citealp[#1]{#2}; \citealp[#3]{#4})%
}
% Cite quote environment
%%
%% DEPRICATED!
%%
\newcommand{\@quotekey}{undefined}
\newcommand{\@quoteopt}{undefined}
\newenvironment{citequote}[2][]{%
  \PackageWarningNoLine{uiothesis}{%
    Environment "citequote" is deprecated}
  \renewcommand{\@quoteopt}{#1}
  \renewcommand{\@quotekey}{#2}
  \begin{quote}
}{%
  \\[0.5\onelineskip]
    \hspace*{\fill}
    \citep[\@quoteopt]{\@quotekey}
  \end{quote}
}

% Full quote encironment
\newenvironment{fullquote}[3][]{%
  \citet[#1]{#2} #3:
  \begin{quote}
}{%
  \end{quote}
}


%%
%% Constants
%%

\newcommand{\urort}{Ur\o{}rt}


%%
%% Front matter
%%

% Colophon
\newcommand{\makecolophon}{%
  \pagestyle{empty}
  \raggedright\small

  \null\vfil

  \begin{adjustwidth*}{\unitlength}{-\unitlength}
    This thesis was typeset using the \LaTeX{} typesetting\\
    system originally developed by Leslie Lamport,\\
    based on \TeX{} created by Donald Knuth.\\

    \bigskip

    The body text is set 12/14.5pt on a 26pc measure with\\
    Minion Pro designed by Robert Slimback.\\
    This neohumanistic font was first issued by Adobe\\
    Systems in 1989 and have since been revised.\\
    Other fonts include Sans and Typewriter from\\
    Donald Knuth's Computer Modern family.\\

    \bigskip

    This thesis was written in American English as\\ 
    dictated in \work{The Elements of Style}\\
    by \citet{strunk00}.\\
    Typographical decisions were based on the\\
    recommendations given in \work{The Elements of\\
    Typographic Style} by \citet{bringhurst04}.\\
    The use of sidenotes instead of footnotes and\\
    figures spanning both the textblock and\\
    fore-edge margin was inspired by \work{Beautiful\\
    Evidence} by \citet{tufte06}.\\
  \end{adjustwidth*}
  
  \vfil

  \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \color{ornament}\fourierOrnament{100}{120}{97}
  \end{adjustwidth*}

  \vfil

  %\metainfo
}

\newcommand{\metainfo}{%
  \normalsize
  \newlength{\alphlen}
  \settowidth{\alphlen}{abcdefghijklmnopqrstuvwxyz}
  The length of the alphabet is: \the\alphlen \\
  The beselineskip is: \the\baselineskip{} 
}

% Titlepage
\renewcommand{\maketitle}{%
  \begin{titlingpage}
    \calccentering{\unitlength}
    \begin{adjustwidth*}{\unitlength}{-\unitlength}
      \begin{center}
        \null\vspace{1cm}
        \includegraphics[width=0.3\textwidth]{uioseal} \\
        \vspace{2cm}
        {\Huge\textsf{{\@title}}} \\
        \vspace{0.5cm}
        {\Large\textsf{{\@subtitle}}} \\
        \vspace{1cm}
        {\large\@author} \\
        \vspace{1cm}
        {\LARGE\aldineleft} \\
        \vspace{1cm}
        Submitted in partial fulfillment of the requirements \\
        for the degree of Master of Science \\
        \vspace{1cm}
        \@date \\
        \vspace{1cm}
        Department of Informatics \\
        Faculty of Mathematics and Natural Sciences \\
        University of Oslo \\
        \vfill
        \@scm
      \end{center}
    \end{adjustwidth*}
    \clearpage
    \makecolophon
  \end{titlingpage}
}
