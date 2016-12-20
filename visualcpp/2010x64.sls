vcpp2010x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2010\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2010  x64
      arch: x64

vcpp2010x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2010\vcredist_x64.exe
    - source: http://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe
    - source_hash: md5=630d75210b325a280c3352f879297ed5
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2010\test_x64.ps1
    - require:
      - file: vcpp2010x64-test
    
vcpp2010x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2010\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2010\test_x64.ps1
    - require: 
      - file: vcpp2010x64-test
      - file: vcpp2010x64-packages
