vcpp2013x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2013\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2013  x64
      arch: x64

vcpp2013x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2013\vcredist_x64.exe
    - source: http://download.microsoft.com/download/A/4/D/A4D9F1D3-6449-49EB-9A6E-902F61D8D14B/vcredist_x64.exe
    - source_hash: md5=303c97d76841ca74701e81ad32437070
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2013\test_x64.ps1
    - require: 
      - file: vcpp2013x64-test
    
vcpp2013x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2013\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2013\test_x64.ps1
    - require: 
      - file: vcpp2013x64-test
      - file: vcpp2013x64-packages
