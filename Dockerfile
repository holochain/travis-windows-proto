






RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco install -y git.install nodist

RUN choco install nodist
RUN echo %PATH%
RUN echo %NODE_PATH%

ENV PATH "${PATH}:C:\Program Files (x86)\Nodist\bin"
ENV NODE_PATH "C:\Program Files (x86)\Nodist\bin\node_modules;${NODE_PATH}"

RUN echo %PATH%
RUN echo %NODE_PATH%

# & `
#    nodist + 10 & `
#    nodist global 10 & `
#    nodist npm + 6 & `
#    nodist npm global 6 & `
#    NODE_PATH="/c/Program Files (x86)\Nodist\bin\node_modules;$NODE_PATH" & `
#    PATH="$PATH:/c/Program Files (x86)/Nodist/bin"

RUN rustc --version & `
    rustup --version & `
    cargo --version & `
    git --version & `
    node --version & `
    npm --version
