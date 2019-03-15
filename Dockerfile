# escape=`
# https://github.com/carlin-q-scott/docker-mozbuild/blob/520882cc590b8d386ea30447c92d9ab15b69fe1b/Dockerfile

FROM microsoft/windowsservercore:1803

# Download the Build Tools bootstrapper
RUN powershell -Command `
    Invoke-WebRequest `
     -Uri "https://aka.ms/vs/15/release/vs_buildtools.exe" `
     -UseBasicParsing -OutFile vs_buildtools.exe;

# Restore the default Windows shell for correct batch processing below.
SHELL ["cmd", "/S", "/C"]

# Install Build Tools excluding workloads and components with known issues.
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2017
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Component.Windows10SDK.17763 `
    --add Microsoft.VisualStudio.Component.VC.CMake.Project `
    --add Microsoft.VisualStudio.Component.VSSDKBuildTools `
    --add Microsoft.VisualStudio.Component.VC.ATL `
    --add Microsoft.Net.Component.4.6.1.SDK `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
    --remove Microsoft.VisualStudio.Component.Windows81SDK `
    --installPath C:\BuildTools

# TO DO
# start FROM microsoft/windowsservercore
# use all powershell commands you want to prepare your image
# use a second FROM microsoft/nanoserver
# copy what you need from the first stage into your final stage

SHELL ["cmd", "/S", "/C"]

ENV RUST_VERSION nightly-2019-01-24
ENV TARGET x86_64-pc-windows-msvc
ENV WASM_TARGET wasm32-unknown-unknown

RUN curl -sSf -o rustup-init.exe https://win.rustup.rs/ && `
     rustup-init.exe -y --default-host %TARGET% --default-toolchain %RUST_VERSION% && `
     setx path '%path%;%ALLUSERSPROFILE%\.cargo\bin'

RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco install -y git.install nodist

RUN choco install nodist && `
  NODE_PATH="/c/Program Files (x86)\Nodist\bin\node_modules;$NODE_PATH" && `
  PATH="$PATH:/c/Program Files (x86)/Nodist/bin"

RUN rustc --version && `
     rustup --version && `
     rustup --version && `
     cargo --version && `
     git --version && `
     npm --version