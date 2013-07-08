module ut.testsuite;

import ut.testcase;

import std.stdio;
import std.datetime;

struct TestSuite {
    this(TestCase[] tests) {
        _tests = tests;
    }

    double run() {
        _stopWatch.start();
        foreach(TestCase test; _tests) {
            immutable result = test.run();
            if(!result.success) {
                addFailure(test.getPath());
            }
            write(test.getPath() ~ ":\n" ~ result.output ~ "\n");
        }

        foreach(const ref string failure; _failures) {
            writeln("Test ", failure, " failed.");
        }

        _stopWatch.stop();
        return _stopWatch.peek().seconds();
    }

    void addFailure(string testPath) {
        _failures ~= testPath;
    }

    ulong getNumTestsRun() {
        return _tests.length;
    }

    ulong getNumFailures() {
        return _failures.length;
    }

private:
    TestCase[] _tests;
    string[] _failures;
    StopWatch _stopWatch;
}