vcpp2005x86-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2005\test_x86.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2005  x86
      arch: x86

vcpp2005x86-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2005\vcredist_x86.exe
    - source: http://download.microsoft.com/download/5/D/A/5DA273D6-C1CB-4F1C-90C0-73B5263E0AC7/vcredist_x86.EXE
    - source_hash: md5=df77d58ddd63d269f8cba60fc8b2709e
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2005\test_x86.ps1
    - require:
      - file: vcpp2005x86-test
      
vcpp2005x86-install:
  cmd.run:
    - name: ./vcredist_x86.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2005\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2005\test_x86.ps1
    - require: 
      - file: vcpp2005x86-test
      - file: vcpp2005x86-packages

