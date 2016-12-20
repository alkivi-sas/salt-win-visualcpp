vcpp2015x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2015\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2015  x64
      arch: x64

vcpp2015x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2015\vcredist_x64.exe
    - source: http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe
    - source_hash: md5=27b141aacc2777a82bb3fa9f6e5e5c1c
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2015\test_x64.ps1
    - require: 
      - file: vcpp2015x64-test
    
vcpp2015x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2015\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2015\test_x64.ps1
    - require: 
      - file: vcpp2015x64-test
      - file: vcpp2015x64-packages
