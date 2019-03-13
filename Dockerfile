# escape=`

FROM microsoft/windowsservercore:1803

# Download the Build Tools bootstrapper
RUN powershell -Command `
    Invoke-WebRequest `
     -Uri "https://aka.ms/vs/15/release/vs_buildtools.exe" `
     -UseBasicParsing -OutFile vs_buildtools.exe;

# Restore the default Windows shell for correct batch processing below.
SHELL ["cmd", "/S", "/C"]

# Install Build Tools excluding workloads and components with known issues.
RUN vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add "Microsoft.VisualStudio.Workload.NativeDesktop" `
    --add "Microsoft.VisualStudio.Component.Windows10SDK.10240" `
    --add "Microsoft.VisualStudio.Workload.NativeGame" `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Or VS Community installer
# RUN Invoke-WebRequest `
#     -Uri "https://download.visualstudio.microsoft.com/download/pr/cde51e45-6536-4293-88c4-9dc341a3eb84/fe7096403605291306155738116c3153/vs_community.exe" `
#     -UseBasicParsing -OutFile vs_community.exe
# ADD layout.json
# RUN .\vs_community.exe --in ~\layout.json --quiet --wait


SHELL ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN choco install -y rust