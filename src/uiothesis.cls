% UiO LaTeX Thesis Class
%
\ProvidesClass{uiothesis}


% Default options
\newcommand{\@@papersize}{a4paper}
\newcommand{\@@ptsize}{10pt}
\newcommand{\@@sides}{twoside}
\newcommand{\@@columns}{onecolumn}
\newcommand{\@@openwhere}{openright}
\newcommand{\@@status}{final}

% Possible options
\DeclareOption{letterpaper}{\renewcommand{\@@papersize}{letterpaper}}
\DeclareOption{a4paper}{\renewcommand{\@@papersize}{a4paper}}
\DeclareOption{ebook}{\renewcommand{\@@papersize}{ebook}}
\DeclareOption{9pt}{\renewcommand{\@@ptsize}{9pt}}
\DeclareOption{10pt}{\renewcommand{\@@ptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\@@ptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\@@ptsize}{12pt}}
\DeclareOption{17pt}{\renewcommand{\@@ptsize}{17pt}}
\DeclareOption{oneside}{\renewcommand{\@@sides}{oneside}}
\DeclareOption{twoside}{\renewcommand{\@@sides}{twoside}}
\DeclareOption{onecolumn}{\renewcommand{\@@columns}{onecolumn}}
\DeclareOption{twocolumn}{\renewcommand{\@@columns}{twocolumn}}
\DeclareOption{openright}{\renewcommand{\@@openwhere}{openright}}
\DeclareOption{openleft}{\renewcommand{\@@openwhere}{openleft}}
\DeclareOption{openany}{\renewcommand{\@@openwhere}{openany}}
\DeclareOption{draft}{\renewcommand{\@@status}{draft}}
\DeclareOption{final}{\renewcommand{\@@status}{final}}
\ProcessOptions

% This class is based on the memoir class
\LoadClass[\@@papersize,%
           \@@ptsize,%
           \@@sides,%
           \@@columns,%
           \@@openwhere,%
           \@@status]{memoir}

% Internal variables
\newcommand{\@subtitle}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}

% Headers
%\RequirePackage{fancyhdr}

%\pagestyle{fancy}

%\fancyhf{}
%\fancyhead[LE,RO]{ \thepage}
%\fancyhead[LO]{\nouppercase{\rightmark}}
%\fancyhead[RE]{\nouppercase{\leftmark}}

%\renewcommand{\chaptermark}[1]%
%  {\markboth{\thechapter.\ #1}{}%
%}
%\renewcommand{\sectionmark}[1]%
%  {\markright{\thesection.\ #1}{}%
%}


% Nullifies margins of text inside the environment
%\newenvironment{zeromargins}{%
%  \begin{list}{}{%
%    \setlength{\oddsidemargin}{0pt}%
%    \setlength{\evensidemargin}{0pt}%
%  }%
%  \item[]
%}{\end{list}}


% Title page
\RequirePackage{graphicx}

%\renewcommand{\maketitle}{%
%  \begin{titlepage}
%    {\parindent 0pt%
%      \begin{zeromargins}
%        \begin{center}
%            \includegraphics[width=0.3\textwidth]{uioseal} \\
%          \vspace{2cm}
%            \textbf{\Huge{\@title}} \\
%          \vspace{0.5cm}
%            \textbf{\Large{\@subtitle}} \\
%          \vspace{1cm}
%            {\Large\@author} \\
%          \vspace{1cm}
%            Submitted in partial fulfillment of the requirements \\
%            for the degree of Master of Science \\
%          \vspace{1cm}
%            \@date \\
%          \vspace{1cm}
%            Department of Informatics \\
%            Faculty of Mathematics and Natural Sciences \\
%            University of Oslo \\
%          \vspace{5cm}
%        \end{center}
%      \end{zeromargins}
%    }%
%  \end{titlepage}
%}


% Hyper references and breaking of URLs
\RequirePackage[ps2pdf]{hyperref}
\RequirePackage{memhfixc}
\RequirePackage{breakurl}


% Footnotes
%\renewcommand{\thefootnote}{\fnsymbol{footnote}}


% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
