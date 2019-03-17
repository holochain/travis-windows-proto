









# & `
#    nodist + 10 & `
#    nodist global 10 & `
#    nodist npm + 6 & `
#    nodist npm global 6 & `
#    NODE_PATH="/c/Program Files (x86)\Nodist\bin\node_modules;$NODE_PATH" & `
#    PATH="$PATH:/c/Program Files (x86)/Nodist/bin"

RUN git --version & `
    node --version & `
    npm --version
