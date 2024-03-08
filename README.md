# soLDraw - Solid LDraw parts
Solid versions of LDraw.org parts

Since those models reflect solid versions of parts provided by
LDraw.org the same license is applied. For more information refer to
CAreadme.txt or the LDraw.org website. The code itself is rewritten
from scratch but the same license nevertheless applies to this
project as well.

To build the code you may use the provided Makefile.

If you modify or add new parts follow the style of the part module
definition you can find with the other parts in soLDraw.scad. After
adding this definition run the bash script repatch to automatically
update the part dispatcher code and the test cases in test.scad.
If you are working on a system that does not have a bash shell
installed you need to update those files manually.

You can use test.scad to display your part along with a ghost image
of the original LDraw.org libray part to verify that you got the
dimensions right.

Feel free to submit your modifications through a GitHub pull request.
Note that all submissions must be licensed under the project license.
