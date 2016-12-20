vcpp2012x86-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2012\test_x86.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2012  x86
      arch: x86

vcpp2012x86-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2012\vcredist_x86.exe
    - source: http://download.microsoft.com/download/D/3/B/D3B72629-7D95-49ED-A4EC-7FF105754124/VSU4/vcredist_x86.exe
    - source_hash: md5=8ac2452c46dd0f50fe156c0753cf1256
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2012\test_x86.ps1
    - require:
      - file: vcpp2012x86-test
    
vcpp2012x86-install:
  cmd.run:
    - name: ./vcredist_x86.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2012\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2012\test_x86.ps1
    - require: 
      - file: vcpp2012x86-test
      - file: vcpp2012x86-packages

