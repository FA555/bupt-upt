# Directories
ROOT := .

# Binary
RM := rm -f

clean:
	find $(ROOT) -name '*.pdf' -exec $(RM) {} \;

.PHONY: clean
