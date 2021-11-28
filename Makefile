SBT = sbt

# Generate Verilog code
doit:
	$(SBT) "runMain Processor"

# Run the test
test:
	$(SBT) "test:runMain ProcessorTester"

clean:
	git clean -fd
