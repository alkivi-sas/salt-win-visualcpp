vcpp2012x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2012\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2012  x64
      arch: x64

vcpp2012x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2012\vcredist_x64.exe
    - source: http://download.microsoft.com/download/D/3/B/D3B72629-7D95-49ED-A4EC-7FF105754124/VSU4/vcredist_x64.exe
    - source_hash: md5=77cb884257e6ae51ef5cb9ecd4a2a916
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2012\test_x64.ps1
    - require: 
      - file: vcpp2012x64-test
    
vcpp2012x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2012\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2012\test_x64.ps1
    - require: 
      - file: vcpp2012x64-test
      - file: vcpp2012x64-packages

