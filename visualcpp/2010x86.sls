vcpp2010x86-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2010\test_x86.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2010  x86
      arch: x86
    
vcpp2010x86-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2010\vcredist_x86.exe
    - source: http://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe
    - source_hash: md5=1801436936e64598bab5b87b37dc7f87
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2010\test_x86.ps1
    - require:
      - file: vcpp2010x86-test

vcpp2010x86-install:
  cmd.run:
    - name: ./vcredist_x86.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2010\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2010\test_x86.ps1
    - require: 
      - file: vcpp2010x86-test
      - file: vcpp2010x86-packages
