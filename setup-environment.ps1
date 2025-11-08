Write-Host "QUANTUM COMPUTING SETUP" -ForegroundColor Cyan

$pythonVersion = python --version 2>&1
Write-Host "Python: $pythonVersion" -ForegroundColor Green

$projectRoot = "quantum-computing-mastery"
New-Item -ItemType Directory -Force -Path "$projectRoot/notebooks" | Out-Null
New-Item -ItemType Directory -Force -Path "$projectRoot/data" | Out-Null
New-Item -ItemType Directory -Force -Path "$projectRoot/exports" | Out-Null

@"
qiskit==1.2.4
qiskit-aer==0.15.1
qiskit-ibm-runtime==0.28.0
numpy==1.26.4
scipy==1.14.1
matplotlib==3.9.2
jupyter==1.1.1
jupyterlab==4.2.5
ipywidgets==8.1.5
pandas==2.2.3
pillow==10.4.0
pylatexenc==2.10
"@ | Out-File -FilePath "$projectRoot/requirements.txt" -Encoding UTF8

Set-Location $projectRoot
python -m venv venv
& .\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet

Write-Host "Verifying..." -ForegroundColor Yellow
python -c "import qiskit; print(f'Qiskit {qiskit.__version__}')"

@"
& .\venv\Scripts\Activate.ps1
jupyter lab --notebook-dir=notebooks
"@ | Out-File -FilePath "launch-jupyter.ps1" -Encoding UTF8

@"
# Quantum Computing Mastery
Run: .\launch-jupyter.ps1
"@ | Out-File -FilePath "README.md" -Encoding UTF8

@'
{"cells":[{"cell_type":"markdown","metadata":{},"source":["# Quantum Computing: Complete Mastery\nStart here"]}],"metadata":{"kernelspec":{"display_name":"Python 3","language":"python","name":"python3"}},"nbformat":4,"nbformat_minor":4}
'@ | Out-File -FilePath "notebooks/quantum_computing_complete.ipynb" -Encoding UTF8

Write-Host "`nDONE! Run: cd $projectRoot; .\launch-jupyter.ps1" -ForegroundColor Green
Set-Location ..