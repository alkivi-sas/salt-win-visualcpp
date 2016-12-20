vcpp2008x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2008\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2008  x64
      arch: x64

vcpp2008x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2008\vcredist_x64.exe
    - source: http://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe
    - source_hash: md5=e2ada570911edaaae7d1b3c979345fce
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2008\test_x64.ps1
    - require:
      - file: vcpp2008x64-test
    
vcpp2008x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2008\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2008\test_x64.ps1
    - require: 
      - file: vcpp2008x64-test
      - file: vcpp2008x64-packages

