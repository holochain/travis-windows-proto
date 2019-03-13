# escape=`
# https://github.com/carlin-q-scott/docker-mozbuild/blob/520882cc590b8d386ea30447c92d9ab15b69fe1b/Dockerfile

FROM microsoft/windowsservercore:1803

# # Download the Build Tools bootstrapper
# RUN powershell -Command `
#     Invoke-WebRequest `
#      -Uri "https://aka.ms/vs/15/release/vs_buildtools.exe" `
#      -UseBasicParsing -OutFile vs_buildtools.exe;

# # Restore the default Windows shell for correct batch processing below.
# SHELL ["cmd", "/S", "/C"]

# # Install Build Tools excluding workloads and components with known issues.
# RUN vs_buildtools.exe --quiet --wait --norestart --nocache `
#     --installPath C:\BuildTools `
#     --add "Microsoft.VisualStudio.Workload.NativeDesktop" `
#     --add "Microsoft.VisualStudio.Component.Windows10SDK.10240" `
#     --add "Microsoft.VisualStudio.Workload.NativeGame" `
#  || IF "%ERRORLEVEL%"=="3010" EXIT 0


# # SHELL ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

# # RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# # RUN choco install -y git.install

SHELL ["cmd", "/S", "/C"]

RUN powershell -Command `
    Invoke-WebRequest `
     -Uri "https://build.travis-ci.com/files/rustup-init.sh" `
     -UseBasicParsing -OutFile rustup-init.sh;

RUN powershell -Command `
     sh rustup-init.sh -v --default-toolchain nightly-2019-01-24 -y;

RUN rustc --version
RUN rustup --version
RUN cargo --version