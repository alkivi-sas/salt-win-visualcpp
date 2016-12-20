vcpp2005x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2005\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2005  x64
      arch: x64

vcpp2005x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2005\vcredist_x64.exe
    - source: http://download.microsoft.com/download/5/D/A/5DA273D6-C1CB-4F1C-90C0-73B5263E0AC7/vcredist_x64.EXE
    - source_hash: md5=9c3ddfa5b263dd3751ca08a97d3fdb87
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2005\test_x64.ps1
    - require: 
      - file: vcpp2005x64-test
    
vcpp2005x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2005\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2005\test_x64.ps1
    - require: 
      - file: vcpp2005x64-test
      - file: vcpp2005x64-packages
