vcpp2015x86-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2015\test_x86.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2015  x86
      arch: x86

vcpp2015x86-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2015\vcredist_x86.exe
    - source: http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe
    - source_hash: md5=1a15e6606bac9647e7ad3caa543377cf
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2015\test_x86.ps1
    - require: 
      - file: vcpp2015x86-test
    
vcpp2015x86-install:
  cmd.run:
    - name: ./vcredist_x86.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2015\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2015\test_x86.ps1
    - require: 
      - file: vcpp2015x86-test
      - file: vcpp2015x86-packages
