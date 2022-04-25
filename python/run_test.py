import subprocess
import sys
import os
python_exe = os.path.realpath(sys.executable)
test_script = sys.argv[1]
out_dir = sys.argv[2]
test_name = os.path.splitext(os.path.basename(test_script))[0] # No extension
test_output = os.path.join(out_dir, test_name + ".out")
with open(test_output, "w+") as output:
    subprocess.call([python_exe, test_script], stdout=output)
    
