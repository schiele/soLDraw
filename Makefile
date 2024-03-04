OPENSCAD=openscad --hardwarnings --export-format binstl -Dpart='"$*"' -o $@ $<

PARTS := 3001 3002 3003 3004 3005 3006 3007 3008 3009 3010 3020 3021 3023 3024 3031 3068b 3623 3641 3710 3788 3821 3822 3823 3828 3829a 3937 3938 4070 4079 4213 4214 4215 4315 4600 4624 6141

all: $(foreach p,$(PARTS),$(p).stl)

%.stl: soLDraw.scad
	$(OPENSCAD)

.PHONY: clean

clean:
	rm -f *.stl
